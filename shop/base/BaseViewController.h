//
//  BaseViewController.h
//  shop
//
//  Created by zhangwenqiang on 16/6/12.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAPI.h"
#import "UserDefault.h"
#import "Constants.h"
#import "NSString+MD5.h"
#import "HttpRequest.h"
#import "WXApiManager.h"
#import "WXApiRequestHandler.h"
#import "GDataXMLNode.h"
#import "IQKeyboardManager.h"
#import "UINavigationController+Custom.h"
#import "UIViewController+Custom.h"

@interface BaseViewController : UIViewController<HttpRequestDeletage>

/*json解析*/
- (nullable id)parserWithJsonString:(NSString * _Nonnull)jsonString;

/* 显示用户信息提示框 */
- (void)showToast:(NSString * _Nonnull)msg;
//- (void)showToastFmt:(NSString * _Nonnull)fmtStr,...;

@end
