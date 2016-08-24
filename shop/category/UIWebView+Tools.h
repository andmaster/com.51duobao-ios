//
//  UIWebView+Tools.h
//  shop
//
//  Created by zhangwenqiang on 16/8/23.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Tools)

- (void)clearBackColorForWebView;//清楚上下黑边

- (void)didNotLeftOrRightScrollForWebView;//禁止左右滑动

- (NSString*) titleString;//获得Title

@end
