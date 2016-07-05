//
//  WXApiManager.m
//  shop
//
//  Created by zhangwenqiang on 16/6/16.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "WXApiManager.h"

@implementation WXApiManager

@synthesize delegate;

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

-(void)onReq:(BaseReq *)req{

}


-(void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]) {
        if (delegate != nil && [delegate respondsToSelector:@selector(managerDidRecvPayResponse:)]) {
            PayResp* respones = (PayResp*)resp;
            [delegate managerDidRecvPayResponse:respones];
        }
    }else if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (delegate
            && [delegate respondsToSelector:@selector(managerDidRecvAuthResponse:)]) {
            SendAuthResp *authResp = (SendAuthResp *)resp;
            [delegate managerDidRecvAuthResponse:authResp];
        }
    }
}

@end
