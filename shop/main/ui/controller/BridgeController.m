//
//  BridgeController.m
//  shop
//
//  Created by zhangwenqiang on 16/6/19.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "BridgeController.h"
#import "WebViewJavascriptBridge.h"
#import "WXApiRequestHandler.h"
#import "GDataXMLNode.h"
#import "HttpRequest.h"
#import "Constants.h"
#import "OrderUtil.h"
#import "BaseAPI.h"
#import "Sign.h"
#import "AFNetworking.h"
#import "XMLUtil.h"
#import "ViewController.h"
#import "RechargeVC.h"

@interface BridgeController()<HttpRequestDeletage>

@property(nonatomic,strong)BaseViewController* viewController;

@end

@implementation BridgeController

+(instancetype)share{

    static BridgeController* bridgeController =  nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        bridgeController = [[BridgeController alloc] init];
    });
    
    return bridgeController;
    
}

/* 监听点击js */
- (void)registerHandler:(WebViewJavascriptBridge*)bridge viewController:(BaseViewController*)viewController{
    
    _viewController = viewController;
    
    __weak typeof(self) weakSelf = self;
    
    /*微信支付*/
    [bridge registerHandler:PayByWx handler:^(id data, WVJBResponseCallback responseCallback) {
        //responseCallback(data);//回调数据的block方法
        
        if (data == nil) { return ; }
        
        if (![WXApi isWXAppInstalled]) {//TODO
            
            NSURL * URL = [(ViewController*)viewController webView].request.URL;
            
            if ([[UIApplication sharedApplication] canOpenURL:URL]) {
                
                NSLog(@"URL-->%@",[URL description]);
                
                [[UIApplication sharedApplication] openURL:URL]; return;
            }
            
            /*if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:OPEN_WX_TYPE]]) {
                
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:OPEN_WX_TYPE]]; 
            }*/
            return;
        }
        
        if ([data isKindOfClass:[NSString class]]) {
            
            NSArray* params = [((NSString*)data) componentsSeparatedByString:@"#"];
            
            if (params.count == 4) {
                
                [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(parseDidEndDocument:) name:XMLParserDidEndNotification object:nil];
                
                NSMutableDictionary* param = [NSMutableDictionary dictionary];
                
                [param setObject:[params objectAtIndex:0] forKey:@"body"];
                
                [param setObject:[params objectAtIndex:1] forKey:@"out_trade_no"];
                
                [param setObject:[params objectAtIndex:2] forKey:@"total_fee"];
                
                [param setObject:[params objectAtIndex:3] forKey:@"spbill_create_ip"];
                
                [weakSelf  executUnifiedOrder:param];
            }
        }
    }];
    
    /*支付宝支付*/
    [bridge registerHandler:PayByAlipay handler:^(id data, WVJBResponseCallback responseCallback) {
        //responseCallback(data);//回调数据的block方法
    }];
    
    //微信登录
    [bridge registerHandler:LoginByWx handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [weakSelf sendWxAuth];//微信登录
    }];
    
    //苹果虚拟商品支付
    [bridge registerHandler:@"PayByApple" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:[[RechargeVC alloc] init]];
        
        [viewController presentViewController:nav animated:YES completion:^{
        
            NSLog(@"完成");
        }];
    }];
}

/* 执行统一下单 */
- (void)executUnifiedOrder:(id) data{
    //设置参数
    NSDictionary* dictionary = (NSDictionary*)data;
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    [params setObject:APP_ID_WX forKey:@"appid"];//**是 应用ID
    
    [params setObject:MCH_ID_WX forKey:@"mch_id"];//**是 商户号
    
    [params setObject:@"" forKey:@"device_info"];//否 设备号
    
    [params setObject:[OrderUtil nonceStr] forKey:@"nonce_str"];//**是 随机字符串
    
    [params setObject:[dictionary objectForKey:@"body"] forKey:@"body"];//**是 商品描述
    
    [params setObject:@"" forKey:@"detail"];//否 商品详情
    
    [params setObject:@"" forKey:@"attach"];//否 附加数据
    
    [params setObject:[dictionary objectForKey:@"out_trade_no"] forKey:@"out_trade_no"];//**是 商户订单号
    
    [params setObject:@"" forKey:@"fee_type"];//否 货币类型
    
    [params setObject:[dictionary objectForKey:@"total_fee"] forKey:@"total_fee"];//**是 总金额
    
    [params setObject:[dictionary objectForKey:@"spbill_create_ip"] forKey:@"spbill_create_ip"];//**是 终端IP
    
    [params setObject:@"" forKey:@"time_start"];//否 交易起始时间
    
    [params setObject:@"" forKey:@"time_expire"];//否 交易结束时间
    
    [params setObject:@"" forKey:@"goods_tag"];//否 商品标记
    
    [params setObject:[OrderUtil notifyURL] forKey:@"notify_url"];//**是 通知地址
    
    [params setObject:[OrderUtil tradeType] forKey:@"trade_type"];//**是 交易类型
    
    [params setObject:@"" forKey:@"limit_pay"];//否 指定支付方式
    
    [params setObject:[Sign sign:params] forKey:@"sign"];//**是 签名
    
    NSString* xml = [OrderUtil toXml:params];
    
    [HttpRequest httpPostBody:xml URLString:GEN_URL deletage:self type:PLACETHEORDER];
}

//拿到解析结果
-(void)parseDidEndDocument:(NSNotification*)notify{
    
    if (![notify.object isKindOfClass:[NSArray class]]) { return; }
    
    NSMutableArray* models = (NSMutableArray*)notify.object;
    
    PayModel* model = [models objectAtIndex:0];
    
    if (model == nil) { return; }
    
    //NSMutableDictionary* params = [models objectAtIndex:1];
    model.openID = APP_ID_WX;
    
    model.package = PACKAGE_WX;
    
    model.nonce_str = [OrderUtil nonceStr];
    
    model.timestamp = [OrderUtil timeStamp];
    
    NSMutableDictionary* repParams = [NSMutableDictionary dictionary];
    
    [repParams setObject:APP_ID_WX forKey:@"appid"];
    
    if(model.mch_id == nil || model.mch_id.length == 0){ return; }
    
    [repParams setObject:model.mch_id forKey:@"partnerid"];
    
    if (model.prepay_id == nil || model.prepay_id.length == 0) { return; }
    
    [repParams setObject:model.prepay_id forKey:@"prepayid"];
    
    if (model.nonce_str == nil || model.nonce_str.length == 0) { return; }
    
    [repParams setObject:model.nonce_str forKey:@"noncestr"];
    
    if (model.timestamp == nil || model.timestamp.length == 0) { return; }
    
    [repParams setObject:model.timestamp forKey:@"timestamp"];
    
    if (model.package == nil || model.package.length == 0) { return; }
    
    [repParams setObject:model.package forKey:@"package"];
    
    model.sign = [Sign sign:repParams];
    
    [self sendWxPay:model];
}

/* 掉起微信支付 */
- (void)sendWxPay:(PayModel*)model{
    
    [[UserDefault share] saveNonceStr:@""];//清楚随机字符串
    
    [WXApiRequestHandler sendOpenID:model.appid
                        partnerId:model.mch_id //商户号
                         prepayId:model.prepay_id //预支付id
                         nonceStr:model.nonce_str //随机字符串
                        timeStamp:model.timestamp //时间戳
                          package:model.package //扩展字段
                             sign:model.sign]; //签名
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:XMLParserDidEndNotification object:nil];
}


/* 返回支付结果 */
- (void)managerDidRecvPayResponse:(PayResp *)respones{
    
    if (respones.errCode == WXSuccess) {
        
        [self.viewController showToast:@"支付成功"];
        
        ViewController* vc = (ViewController*)self.viewController;
        
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:NOTIFY_URL_PAYED_WX]];
        
        [vc.webView loadRequest:request];
    }
    else if ([((ViewController*)self.viewController).webView canGoBack]) {
        
        [((ViewController*)self.viewController).webView goBack];
    }
}

/*  微信登录授权*/
- (void)sendWxAuth{
    
    [WXApiRequestHandler sendOpenID:APP_ID_WX scope:SCOPE_WX state:STATE_WX];
}

/* 返回微信登录响应*/
-(void)managerDidRecvAuthResponse:(SendAuthResp *)response{
    
    if (response.errCode == WXSuccess) {
        
        [self getWxAccessToken:response.code];
    }
}

#pragma mark -- http request --

-(void)getWxAccessToken:(NSString*)APP_CODE_WX{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    [params setObject:APP_ID_WX forKey:@"appid"];
    
    [params setObject:APP_SECTET_WX forKey:@"secret"];
    
    [params setObject:APP_CODE_WX forKey:@"code"];
    
    [params setObject:GRANT_TYPE_WX forKey:@"grant_type"];
    
    [HttpRequest httpGet:params URLString:GET_ACCESS_TOKEN deletage:self type:WXACCESSTOKEN];
}

-(void)successObject:(id)responseObject response:(NSURLResponse *)response type:(HttpTagType)type{
    
    switch (type) {
            
        case PLACETHEORDER:{//返回统一下单数据
            
            NSXMLParser* XMLParser = (NSXMLParser*)responseObject;
            
            XMLUtil* xmlUtil = [[XMLUtil alloc] initWithXMLParser:XMLParser];
            
            [xmlUtil parse];
        }
            break;
            
        case SAVEORDER:{
            
            Log(@"responseObjectSAVEORDER:%@",responseObject);
        }
            break;
            
        case WXACCESSTOKEN:{
            
            Log(@"responseObjectSAVEORDER:%@",responseObject);
        }
            break;
            
        default:
            break;
    }
    
}

- (void)failedError:(NSString *)error type:(HttpTagType)type{
    
    switch (type) {
            
        case PLACETHEORDER:{
            
            Log(@"PLACETHEORDER:%@",error);
            
        }
            break;
            
        case SAVEORDER:{
            
            Log(@"SAVEORDER:%@",error);
            
        }
            break;
            
        case WXACCESSTOKEN:{
            
            Log(@"SAVEORDER:%@",error);
        }
            break;
            
        default:
            break;
    }
}


@end
