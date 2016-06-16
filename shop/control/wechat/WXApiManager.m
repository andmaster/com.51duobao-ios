//
//  WXApiManager.m
//  shop
//
//  Created by zhangwenqiang on 16/6/16.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "WXApiManager.h"

@implementation WXApiManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

@end
