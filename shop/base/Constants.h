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
//**是 mch_id 商户号
static NSString* const MCH_ID_WX = @"1356293102";
//**是 交易类型
static NSString* const TRADE_TYPE_WX = @"APP";
//**是 扩展字段
static NSString* const PACKAGE_WX = @"Sign=WXPay";

//统一下单
//static NSString* const GEN_URL = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=android";//测试
static NSString* const GEN_URL = @"https://api.mch.weixin.qq.com/pay/unifiedorder";

#endif /* Constants_h */
