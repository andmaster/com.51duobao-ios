//
//  BaseViewController.m
//  shop
//
//  Created by zhangwenqiang on 16/6/12.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "BaseViewController.h"
#include <stdio.h>

@implementation BaseViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}

/*json解析*/
- (nullable id)parserWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id json = [NSJSONSerialization JSONObjectWithData:jsonData
                                              options:NSJSONReadingMutableContainers
                                                error:&err];
    
    if(err) {
        NSLog(@"json解析失败--------%@",err);
        return nil;
    }
    
    return json;
}

- (void)showToastFmt:(NSString *)fmtStr,...{
    
    

}

/*
 * 显示用户信息提示框
 */
- (void)showToast:(NSString *) msg{
    
    UILabel *msgLa = [[UILabel alloc] init];
    msgLa.numberOfLines=0;
    msgLa.text = msg ;
    msgLa.textAlignment = NSTextAlignmentCenter ;
    msgLa.font = [UIFont systemFontOfSize:15];
    msgLa.backgroundColor = [UIColor clearColor];
    msgLa.textColor = [UIColor colorWithRed:0.780 green:0.780 blue:0.780 alpha:1];
    
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 5 ;
    view.tag = 600 ;
    CGFloat width = [msg boundingRectWithSize:CGSizeMake(1000, 30) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil].size.width;
    if (width>SCREEN_WIDTH - 60) {
        CGFloat height = [msg boundingRectWithSize:CGSizeMake(SCREEN_WIDTH- 60, 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15.0]} context:nil].size.height;
        view.frame=CGRectMake(0, 0, SCREEN_WIDTH, height);
        msgLa.frame = CGRectMake(0, 0, SCREEN_WIDTH-60, height) ;
        
    }else{
        view.frame = CGRectMake(0, 0, width+30, 50);
        msgLa.frame = CGRectMake(0, 0, width+30, 50) ;
    }
    
    view.backgroundColor = [UIColor blackColor];
    view.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - 44-view.frame.size.height-10);
    
    [view addSubview:msgLa];
    
    [[[UIApplication sharedApplication].delegate window] addSubview:view];
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(void){
         [view setAlpha:0.6];
     }completion:^(BOOL finished){
         [view removeFromSuperview];
     }];
}

@end
