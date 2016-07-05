//
//  SendAuthReq+Request.m
//  shop
//
//  Created by zhangwenqiang on 16/7/2.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "SendAuthReq+Request.h"

@implementation SendAuthReq (Request)

+ (SendAuthReq *)requestWithOpenID:(NSString*)openID /* 应用唯一标识 */
                             scope:(NSString *)scope/** 应用授权作用域，如获取用户个人信息则填写snsapi_userinfo */
                             state:(NSString *)state/** 用于保持请求和回调的状态，授权请求后原样带回给第三方。该参数可用于防止csrf攻击（跨站请求伪造攻击），建议第三方带上该参数，可设置为简单的随机数加session进行校验 */
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.openID = openID;
    req.scope = scope;
    req.state = state ;
    return req;
}

@end
