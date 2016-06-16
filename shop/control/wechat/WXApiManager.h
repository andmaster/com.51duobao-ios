//
//  WXApiManager.h
//  shop
//
//  Created by zhangwenqiang on 16/6/16.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface WXApiManager : NSObject<WXApiDelegate>

+(instancetype)sharedManager;

@end
