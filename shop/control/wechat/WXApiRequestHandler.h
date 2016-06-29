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

@end
