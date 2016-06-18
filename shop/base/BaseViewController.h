//
//  BaseViewController.h
//  shop
//
//  Created by zhangwenqiang on 16/6/12.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAPI.h"
#import "Constants.h"
#import "UINavigationController+Custom.h"
#import "NSString+MD5.h"
#import "HttpRequest.h"

@interface BaseViewController : UIViewController<HttpRequestDeletage>

/*json解析*/
- (nullable id)parserWithJsonString:(NSString * _Nonnull)jsonString;

@end
