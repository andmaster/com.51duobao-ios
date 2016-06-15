//
//  UINavigationController+Custom.m
//  shop
//
//  Created by zhangwenqiang on 16/6/13.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "UINavigationController+Custom.h"

@implementation UINavigationController (Custom)

@dynamic leftBarButtonItem, backButton;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //默认的黑色（UIStatusBarStyleDefault）
    //白色（UIStatusBarStyleLightContent）
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationBar setBarTintColor :[UIColor colorWithRed:0.102 green:0.102 blue:0.122 alpha:1.00]];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
}

-(UIBarButtonItem *)leftBarButtonItem{
    static UIBarButtonItem* leftBarButtonItem = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    });
    return leftBarButtonItem;
}

-(UIButton *)backButton{
    static UIButton* backButton = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat size = CGRectGetHeight(self.navigationBar.frame);
        backButton.frame = CGRectMake(0, 0, size, size);
        UIImage *image = [UIImage imageNamed:@"back-arrow"];
        [backButton setImage:image forState:UIControlStateNormal];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, size/2);
        backButton.hidden = YES;
    });
    return backButton;
}

-(void) setHideBackButton:(BOOL)flag{
    self.backButton.hidden = flag;
}

@end
