//
//  ViewController.h
//  shop
//
//  Created by zhangwenqiang on 16/6/5.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic, strong) UIWebView* webView;

@end

