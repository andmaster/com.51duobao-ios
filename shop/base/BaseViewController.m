//
//  BaseViewController.m
//  shop
//
//  Created by zhangwenqiang on 16/6/12.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

/*json解析*/
- (nullable id)parserWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id json = [NSJSONSerialization JSONObjectWithData:jsonData
                                              options:NSJSONReadingMutableContainers
                                                error:&err];
    
    if(err) {
        NSLog(@"json解析失败--------%@",err);
        return nil;
    }
    
    return json;
}


@end
