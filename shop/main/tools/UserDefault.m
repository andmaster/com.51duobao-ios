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
    [[NSUserDefaults standardUserDefaults] synchronize];
    return instance;
}

/*
 *保存随机字符串
 */
-(void) saveNonceStr:(NSString*) nonceStr{
    
    [self setObject:nonceStr forKey:@"nonceStr"];
}

/*
 *获得随机字符串
 */
-(NSString*) getNonceStr{
    
    return [self getObjectForKey:@"nonceStr"];
}


/**
 第一次启动App

 @return 返回时第一次启动BOOL值
 */
- (BOOL)isFirstLaunch{
    
    return ![[self getObjectForKey:@"app_first_launch"] boolValue];
}


/**
  第一次启动App

 @param firstLaunch 保持第一次启动
 */
- (void)setFirstLaunch:(BOOL)firstLaunch{

    [self setObject:[NSNumber numberWithBool:firstLaunch] forKey:@"app_first_launch"];
}


/**
 返回UserDefaults 保存的key对应的value

 @param key 获取value值的key

 @return 返回value值
 */
- (id)getObjectForKey:(NSString*)key{

    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


/**
 保存对应

 @param anObject 要保存的对象
 @param key      对象所对应的key
 */
- (void)setObject:(id)anObject forKey:(NSString*)key{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:anObject forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

//[NSKeyedArchiver archivedDataWithRootObject:object]//对象序列化
             
@end
