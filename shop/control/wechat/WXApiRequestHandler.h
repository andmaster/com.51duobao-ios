//
//  WXApiRequestHandler.h
//  shop
//
//  Created by zhangwenqiang on 16/6/17.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXApiRequestHandler : NSObject

+ (BOOL)sendType:(int)type
          openID:(NSString*)openID
       partnerId:(NSString *)partnerId/** 商家向财付通申请的商家id */
        prepayId:(NSString *)prepayId/** 预支付订单 */
        nonceStr:(NSString *)nonceStr/** 随机串，防重发 */
       timeStamp:(NSString *)timeStamp/** 时间戳，防重发 */
         package:(NSString *)package/** 商家根据财付通文档填写的数据和签名 */
            sign:(NSString *)sign;/** 商家根据微信开放平台文档对数据做的签名 */

+ (BOOL)sendOpenID:(NSString*)openID
          partnerId:(NSString *)partnerId/** 商家向财付通申请的商家id */
           prepayId:(NSString *)prepayId/** 预支付订单 */
           nonceStr:(NSString *)nonceStr/** 随机串，防重发 */
          timeStamp:(NSString *)timeStamp/** 时间戳，防重发 */
            package:(NSString *)package/** 商家根据财付通文档填写的数据和签名 */
               sign:(NSString *)sign;/** 商家根据微信开放平台文档对数据做的签名 */


+ (BOOL)sendPartnerId:(NSString *)partnerId/** 商家向财付通申请的商家id */
             prepayId:(NSString *)prepayId/** 预支付订单 */
             nonceStr:(NSString *)nonceStr/** 随机串，防重发 */
            timeStamp:(NSString *)timeStamp/** 时间戳，防重发 */
              package:(NSString *)package/** 商家根据财付通文档填写的数据和签名 */
                 sign:(NSString *)sign;/** 商家根据微信开放平台文档对数据做的签名 */

//微信登录
+ (BOOL)sendOpenID:(NSString*)openID /* 应用唯一标识 */
             scope:(NSString *)scope/** 应用授权作用域，如获取用户个人信息则填写snsapi_userinfo */
             state:(NSString *)state;/** 用于保持请求和回调的状态，授权请求后原样带回给第三方。该参数可用于防止csrf攻击（跨站请求伪造攻击），建议第三方带上该参数，可设置为简单的随机数加session进行校验 */

@end
