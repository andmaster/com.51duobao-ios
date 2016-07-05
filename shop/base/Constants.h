//
//  Constants.h
//  shop
//
//  Created by zhangwenqiang on 16/6/13.
//  Copyright © 2016年 ishi. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

static NSString* const HOST = @"http://app.dd1yyg.com";

//**是 APP_ID 替换为你的应用从官方网站申请到的合法appId
static NSString* const APP_ID_WX = @"wx6a6dabef860d5157";
//**是 appSectet
static NSString* const APP_SECTET_WX = @"e61df9cfd301d1ae6bc662591932d170";
//**是 mch_id 商户号
static NSString* const MCH_ID_WX = @"1356293102";
//**是 交易类型
static NSString* const TRADE_TYPE_WX = @"APP";
//**是 扩展字段
static NSString* const PACKAGE_WX = @"Sign=WXPay";
//**是 微信订单通知地址
static NSString* const NOTIFY_URL_WX = @"http://app.dd1yyg.com/payok.php";

//**是 登录
static NSString* const  GRANT_TYPE_WX = @"authorization_code";
//**是 应用授权作用域
static NSString* const SCOPE_WX = @"snsapi_userinfo";
//**是 用于保持请求和回调的状态
static NSString* const STATE_WX = @"ding_ding_yun_gou";

//统一下单
//static NSString* const GEN_URL = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=android";//测试
static NSString* const GEN_URL = @"https://api.mch.weixin.qq.com/pay/unifiedorder";
//微信授权后登录接口
static NSString* const GET_ACCESS_TOKEN = @"https://api.weixin.qq.com/sns/oauth2/access_token";

//UIWebViewBridge handlerName
static NSString* const PayByWx = @"PayByWxsession";
static NSString* const PayByAlipay = @"PayByAlipay";
static NSString* const LoginByWx = @"LoginByWxsession";

#endif /* Constants_h */
