//
//  URLSetUtil.m
//  shop
//
//  Created by zhangwenqiang on 16/8/1.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "URLSetUtil.h"
#import "Constants.h"

@implementation URLSetUtil

+(instancetype)share{
    
    static URLSetUtil* instance;
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
       
        instance = [[URLSetUtil alloc] init];
        
    });
    
    return instance;
}

-(NSMutableArray *)URLSet{
    
    if (_URLSet == nil) {
        
        _URLSet = [NSMutableArray array];
        
        [_URLSet addObject:HOST];
        
        [_URLSet addObject:[HOST stringByAppendingString:@"/"]];
        
        [_URLSet addObject:[HOST stringByAppendingFormat:@"%@/",MOBILE]];
        
        [_URLSet addObject:[HOST stringByAppendingString:MOBILE]];
        
        [_URLSet addObject:[HOST stringByAppendingFormat:@"%@/",GOODSLIST]];
        
        [_URLSet addObject:[HOST stringByAppendingString:GOODSLIST]];
        
        [_URLSet addObject:[HOST stringByAppendingFormat:@"%@/",LOTTERY]];
        
        [_URLSet addObject:[HOST stringByAppendingString:LOTTERY]];
        
        [_URLSet addObject:[HOST stringByAppendingFormat:@"%@/",CARTLIST]];
        
        [_URLSet addObject:[HOST stringByAppendingString:CARTLIST]];
        
        [_URLSet addObject:[HOST stringByAppendingFormat:@"%@/",LOGINURL]];
        
        [_URLSet addObject:[HOST stringByAppendingString:LOGINURL]];
        
        [_URLSet addObject:[HOST stringByAppendingFormat:@"%@/",HOME]];
        
        [_URLSet addObject:[HOST stringByAppendingString:HOME]];
        
        //tabUrls.add("data:text/html,chromewebdata");
        //tabUrls.add("file:///android_asset/html/error.html");
    }
    
    return _URLSet;
}

@end
