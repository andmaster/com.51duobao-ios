//
//  PayReq+Request.h
//  shop
//
//  Created by zhangwenqiang on 16/6/17.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "WXApiObject.h"

@interface PayReq (Request)

+ (PayReq *)requestWithType:(int)type/*请求类型*/
                     openID:(NSString*)openID /** 由用户微信号和AppID组成的唯一标识，发送请求时第三方程序必须填写，用于校验微信用户是否换号登录*/
                  partnerId:(NSString *)partnerId/** 商家向财付通申请的商家id */
                   prepayId:(NSString *)prepayId/** 预支付订单 */
                   nonceStr:(NSString *)nonceStr/** 随机串，防重发 */
                  timeStamp:(NSString *)timeStamp/** 时间戳，防重发 */
                    package:(NSString *)package/** 商家根据财付通文档填写的数据和签名 */
                       sign:(NSString *)sign;/** 商家根据微信开放平台文档对数据做的签名 */

+ (PayReq *)requestWithPartnerId:(NSString *)partnerId/** 商家向财付通申请的商家id */
                        prepayId:(NSString *)prepayId/** 预支付订单 */
                        nonceStr:(NSString *)nonceStr/** 随机串，防重发 */
                       timeStamp:(NSString *)timeStamp/** 时间戳，防重发 */
                         package:(NSString *)package/** 商家根据财付通文档填写的数据和签名 */
                            sign:(NSString *)sign;/** 商家根据微信开放平台文档对数据做的签名 */

@end
