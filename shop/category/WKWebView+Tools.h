//
//  WKWebView+Tools.h
//  51indiana
//
//  Created by LiuBuyaolian on 2017/2/12.
//  Copyright © 2017年 ishi. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <objc/runtime.h> //包含对类、成员变量、属性、方法的操作
#import <objc/message.h> //包含消息机制

typedef NS_ENUM(NSInteger, ActionTag) {
    ContinueActionTag = 10,
    BreakActionTag = 11
};

@interface WKWebView (Tools)

@property(nonatomic) ActionTag actionTag;

- (void)clearBackColorForWebView;//清楚上下黑边

- (void)didNotLeftOrRightScrollForWebView;//禁止左右滑动

- (NSString*) titleString;//获得Title

@end
