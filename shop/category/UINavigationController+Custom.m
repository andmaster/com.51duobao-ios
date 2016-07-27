//
//  UINavigationController+Custom.m
//  shop
//
//  Created by zhangwenqiang on 16/6/13.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "UINavigationController+Custom.h"

@implementation UINavigationController (Custom)

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //默认的黑色（UIStatusBarStyleDefault）
    //白色（UIStatusBarStyleLightContent）
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationBar setBarTintColor :[UIColor colorWithRed:0.898 green:0.251 blue:0.282 alpha:1.00]];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
}

@end
