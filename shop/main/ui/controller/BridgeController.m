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

@interface BridgeController()<HttpRequestDeletage,XMLUtilDeletage>

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
    /*微信支付*/
    [bridge registerHandler:@"PayWx" handler:^(id data, WVJBResponseCallback responseCallback) {
        Log(@"ObjC Echo called with: %@", data);
        //responseCallback(data);//回调数据的block方法
        [self  executUnifiedOrder:data];
        //[HttpRequest httpGet:nil URLString:GEN_URL deletage:self type:SAVEORDER];//案例
    }];
    
    /*支付宝支付*/
    [bridge registerHandler:@"PayAlipay" handler:^(id data, WVJBResponseCallback responseCallback) {
        Log(@"ObjC Echo called with: %@", data);
        //responseCallback(data);//回调数据的block方法
    }];
}

/* 执行统一下单 */
- (void)executUnifiedOrder:(id) data{
    //设置参数
    NSDictionary* callParams = (NSDictionary*)data;
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:APP_ID_WX forKey:@"appid"];//**是 应用ID
    [params setObject:MCH_ID_WX forKey:@"mch_id"];//**是 商户号
    [params setObject:@"" forKey:@"device_info"];//否 设备号
    [params setObject:[OrderUtil nonceStr] forKey:@"nonce_str"];//**是 随机字符串
    [params setObject:@"测试商品test" forKey:@"body"];//**是 商品描述
    [params setObject:@"" forKey:@"detail"];//否 商品详情
    [params setObject:@"" forKey:@"attach"];//否 附加数据
    [params setObject:[OrderUtil getSystemTime]forKey:@"out_trade_no"];//**是 商户订单号
    [params setObject:@"" forKey:@"fee_type"];//否 货币类型
    [params setObject:@"1" forKey:@"total_fee"];//**是 总金额
    [params setObject:[OrderUtil getIPAddress] forKey:@"spbill_create_ip"];//**是 终端IP
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

/* 网络请求成功 */
-(void)successObject:(id)responseObject response:(NSURLResponse *)response type:(HttpTagType)type{
    switch (type) {
        case PLACETHEORDER:{//返回统一下单数据
            NSXMLParser* XMLParser = (NSXMLParser*)responseObject;
            XMLUtil* xmlUtil = [[XMLUtil alloc] initWithXMLParser:XMLParser];
            xmlUtil.deletage = self;
            [xmlUtil parse];
        }
            break;
        case SAVEORDER:{
            Log(@"responseObjectSAVEORDER:%@",responseObject);
        }
            break;
            
        default:
            break;
    }
    
}

/* 网络请求失败 */
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
            
        default:
            break;
    }
}

//拿到解析结果
-(void)parserDidEndDocument:(id)data{
    NSMutableArray* models = (NSMutableArray*)data;
    PayModel* model = [models objectAtIndex:0];
    //NSMutableDictionary* params = [models objectAtIndex:1];
    model.openID = APP_ID_WX;
    model.package = PACKAGE_WX;
    model.nonce_str = [OrderUtil nonceStr];
    model.timestamp = [OrderUtil timeStamp];
    NSMutableDictionary* repParams = [NSMutableDictionary dictionary];
    [repParams setObject:APP_ID_WX forKey:@"appid"];
    [repParams setObject:model.mch_id forKey:@"partnerid"];
    [repParams setObject:model.prepay_id forKey:@"prepayid"];
    [repParams setObject:model.nonce_str forKey:@"noncestr"];
    [repParams setObject:model.timestamp forKey:@"timestamp"];
    [repParams setObject:model.package forKey:@"package"];
    model.sign = [Sign sign:repParams];
    [self sendWxPay:model];
}

/* 掉起微信支付 */
- (void)sendWxPay:(PayModel*)model{
    [[UserDefault share] saveNonceStr:@""];
    [WXApiRequestHandler sendOpenID:model.appid
                        partnerId:model.mch_id //商户号
                         prepayId:model.prepay_id //预支付id
                         nonceStr:model.nonce_str //随机字符串
                        timeStamp:model.timestamp //时间戳
                          package:model.package //扩展字段
                             sign:model.sign]; //签名
}


/* 返回支付结果 */
- (void)managerDidRecvPayResponse:(PayResp *)respones{
    [[UserDefault share] saveNonceStr:nil];//清楚随机字符串
    if (respones.errCode == WXSuccess) {
        [self.viewController showToast:@"支付成功"];
    }
    ViewController* vc = (ViewController*)self.viewController;
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[HOST stringByAppendingString:@"/?/mobile/home"]]];
    [vc.webView loadRequest:request];
}

@end
