//
//  ViewController.h
//  shop
//
//  Created by zhangwenqiang on 16/6/5.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKWebViewDeletage.h"
#import "BaseViewController.h"

@interface ViewController : BaseViewController

@property(nonatomic, strong) WKWebView * webView;
@property(nonatomic, strong) UIBarButtonItem* backBarButtonItem;
@property(nonatomic, strong) UIBarButtonItem* rightBarButtonItem;

//@property (nonatomic, strong) DLPanableWebView * webView;

@end

