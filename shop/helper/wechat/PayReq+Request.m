//
//  PayReq+Request.m
//  shop
//
//  Created by zhangwenqiang on 16/6/17.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "PayReq+Request.h"

@implementation PayReq (Request)

+ (PayReq *)requestWithPartnerId:(NSString *)partnerId/** 商家向财付通申请的商家id */
                        prepayId:(NSString *)prepayId/** 预支付订单 */
                        nonceStr:(NSString *)nonceStr/** 随机串，防重发 */
                       timeStamp:(NSString *)timeStamp/** 时间戳，防重发 */
                         package:(NSString *)package/** 商家根据财付通文档填写的数据和签名 */
                            sign:(NSString *)sign/** 商家根据微信开放平台文档对数据做的签名 */
{
    PayReq *req = [[PayReq alloc] init];
    req.partnerId = partnerId;
    req.prepayId = prepayId;
    req.nonceStr = nonceStr;
    req.timeStamp = [timeStamp intValue];
    req.package = package;
    req.sign = sign;
    
    return req;
}

@end
