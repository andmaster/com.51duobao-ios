//
//  WKWebViewDeletage.h
//  51indiana
//
//  Created by LiuBuyaolian on 2017/2/12.
//  Copyright © 2017年 ishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "BaseViewController.h"

@interface WKWebViewDeletage : NSObject<WKNavigationDelegate>

-(instancetype)initWithVC:(BaseViewController*)vc;

@end
