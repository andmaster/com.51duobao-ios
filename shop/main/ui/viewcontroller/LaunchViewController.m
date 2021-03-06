//
//  LaunchViewController.m
//  51indiana
//
//  Created by zhangwenqiang on 16/10/7.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "LaunchViewController.h"
#import "UIImage+adjustImage.h"
#import "ADView.h"
#import "AppDelegate.h"
#import "UserDefault.h"

@interface LaunchViewController ()<ADViewDeletage>

@property (nonatomic, strong) ADView * adView;

@property (nonatomic, strong) UIButton * launchButton;

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self.view addSubview:self.adView];
    [self.view insertSubview:self.launchButton atIndex:1];
}


/**
 ADViewDeletage
 
 @param currentPage 返回当前位置
 */
- (void)currentPage:(NSInteger)currentPage{
    
    //NSLog(@"-->%@",@(currentPage));
    
    __weak typeof(self) ws = self;
    
    self.launchButton.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    [UIView animateWithDuration:0.1 animations:^{
        
        ws.launchButton.transform = CGAffineTransformIdentity;
        
        if (currentPage == 2) {
            
            ws.launchButton.hidden = NO;
        }
        else {
            
            ws.launchButton.hidden = YES;
        }
    }];
    
    
}


/**
 launchButton action
 
 @param sender UIButton
 */
- (void)startApp:(UIButton*)sender{
    
    [[UserDefault share] setFirstLaunch:YES];
    
    [((AppDelegate*)[UIApplication sharedApplication].delegate) switchRootViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ADView *)adView{
    if (_adView == nil) {
        UIImage * image = [UIImage new];
        _adView = [[ADView alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                         images:@[[image addImageNameForFit:@"1"],
                                                  [image addImageNameForFit:@"2"],
                                                  [image addImageNameForFit:@"3"]]];
        _adView.deletage = self;
    }
    return _adView;
}

- (UIButton *)launchButton{
    
    if (_launchButton == nil) {
        CGFloat minY = CGRectGetMinY(self.adView.adPageControl.frame);
        _launchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _launchButton.frame = CGRectMake(0, 0, 80, 25);
        _launchButton.center = CGPointMake(SCREEN_WIDTH/2, minY-25);
        _launchButton.layer.masksToBounds = YES;
        _launchButton.layer.borderWidth = 1;
        _launchButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _launchButton.layer.cornerRadius = 5;
        _launchButton.backgroundColor = [UIColor clearColor];
        _launchButton.titleLabel.font = FONT(15);
        [_launchButton setTitleColor:[UIColor whiteColor]
                            forState:UIControlStateNormal];
        [_launchButton setTitle:@"立即体验"
                       forState:UIControlStateNormal];
        [_launchButton addTarget:self
                          action:@selector(startApp:)
                forControlEvents:UIControlEventTouchUpInside];
        _launchButton.hidden = YES;
    }
    
    return _launchButton;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
