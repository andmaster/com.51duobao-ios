//
//  Constants.h
//  shop
//
//  Created by zhangwenqiang on 16/6/13.
//  Copyright © 2016年 ishi. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#pragma mark -- URL --
typedef NSString * APPURLName;

static APPURLName const HOST = @"http://www.51indiana.com";

static APPURLName const MOBILE = @"/?/mobile/mobile"; //主页

static APPURLName const GOODSLIST = @"/?/mobile/mobile/glist"; //商品列表（全部商品）

static APPURLName const LOTTERY = @"/?/mobile/mobile/lottery";//最新揭晓

static APPURLName const CARTLIST = @"/?/mobile/cart/cartlist";//购物车

static APPURLName const LOGINURL = @"/?/mobile/user/login";//登录

static APPURLName const HOME = @"/?/mobile/home";//主页

static APPURLName const SEARCH = @"/?/mobile/mobile/search1";//搜索

typedef NSString * WXPayFieldName;
//打开微信
static WXPayFieldName const OPEN_WX_TYPE = @"wxbdeb1cfe97a2faaf://";
//**是 APP_ID 替换为你的应用从官方网站申请到的合法appId
static WXPayFieldName const APP_ID_WX = @"wxbdeb1cfe97a2faaf";
//**是 appSectet
static WXPayFieldName const APP_SECTET_WX = @"863f7c87ddbbfaceb29a8588fd65b499";
//**是 mch_id 商户号
static WXPayFieldName const MCH_ID_WX = @"1388650102";
//**是 交易类型
static WXPayFieldName const TRADE_TYPE_WX = @"APP";
//**是 扩展字段
static WXPayFieldName const PACKAGE_WX = @"Sign=WXPay";
//**是 微信订单通知地址
static WXPayFieldName const NOTIFY_URL_WX = @"/payok.php";//异步地址
//微信支付同步地址
static WXPayFieldName const NOTIFY_URL_PAYED_WX = @"/pay.php";//同步地址

typedef NSString * WXLoginFieldName;
//**是 登录
static WXPayFieldName const  GRANT_TYPE_WX = @"authorization_code";
//**是 应用授权作用域
static WXPayFieldName const SCOPE_WX = @"snsapi_userinfo";
//**是 用于保持请求和回调的状态
static WXPayFieldName const STATE_WX = @"ding_ding_yun_gou";

//统一下单
//static NSString* const GEN_URL = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=android";//测试
static NSString* const GEN_URL = @"https://api.mch.weixin.qq.com/pay/unifiedorder";
//微信授权后登录接口
static NSString* const GET_ACCESS_TOKEN = @"https://api.weixin.qq.com/sns/oauth2/access_token";

//UIWebViewBridge handlerName

typedef NSString * WebViewHandlerName;
static WebViewHandlerName const PayByWx = @"PayByWxsession";
static WebViewHandlerName const PayByAlipay = @"PayByAlipay";
static WebViewHandlerName const LoginByWx = @"LoginByWxsession";

#endif /* Constants_h */
