//
//  BridgeController.h
//  shop
//
//  Created by zhangwenqiang on 16/6/19.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApiManager.h"
#import "BaseViewController.h"

@class WebViewJavascriptBridge;

@interface BridgeController : NSObject<WXApiManagerDelegate>

+(instancetype)share;

-(void)executUnifiedOrder:(id)data;

/*  微信登录授权*/
- (void)sendWxAuth;

/* 监听点击js */
- (void)registerHandler:(WebViewJavascriptBridge*)bridge viewController:(BaseViewController*)viewController;

@end
