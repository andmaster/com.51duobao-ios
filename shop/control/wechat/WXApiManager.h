//
//  WXApiManager.h
//  shop
//
//  Created by zhangwenqiang on 16/6/16.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@protocol WXApiManagerDelegate <NSObject>

@optional

- (void)managerDidRecvPayResponse:(PayResp*)respones;

@end

@interface WXApiManager : NSObject<WXApiDelegate>

@property (nonatomic, assign) id<WXApiManagerDelegate> delegate;

+(instancetype)sharedManager;

@end
