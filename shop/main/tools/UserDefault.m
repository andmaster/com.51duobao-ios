//
//  ZXUserDefault.m
//  ZiXun_iOS
//
//  Created by PangTengFei on 16/3/12.
//  Copyright © 2016年 SYW. All rights reserved.
//

#import "UserDefault.h"

@implementation UserDefault

+(UserDefault *)share{
    static UserDefault *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[UserDefault alloc] init];
    });
    return instance;
}

- (BOOL)synchronize{
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
 *保存随机字符串
 */
-(void) saveNonceStr:(NSString*) nonceStr{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nonceStr"];
    [[NSUserDefaults standardUserDefaults] setObject:nonceStr forKey:@"nonceStr"];
    [self synchronize];
}

/*
 *获得随机字符串
 */
-(NSString*) getNonceStr{
    NSString* userToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"nonceStr"];
    return userToken;
}

@end
