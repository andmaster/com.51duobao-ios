//
//  UINavigationController+Custom.h
//  shop
//
//  Created by zhangwenqiang on 16/6/13.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Custom)

@property(nonatomic,strong) UIButton* backButton;
-(void) setHideBackButton:(BOOL)flag;
@property(nonatomic,strong) UIBarButtonItem* leftBarButtonItem;

@end
