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

@interface BaseViewController : UIViewController

/*json解析*/
- (nullable id)parserWithJsonString:(NSString *)jsonString;

@end
