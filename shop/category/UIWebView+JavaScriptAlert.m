//
//  UIWebView+JavaScriptAlert.m
//  shop
//
//  Created by zhangwenqiang on 16/7/28.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "UIWebView+JavaScriptAlert.h"

typedef NS_ENUM(NSInteger,JSDialogType) {
    JSAlertDialogType = 0,
    JSConfirmDialogType,
};

@implementation UIWebView (JavaScriptAlert)

static BOOL diagStat = NO;

-(void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
    
    UIAlertView* dialogue = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    
    dialogue.tag = JSAlertDialogType;
    
    [dialogue show];
}

static NSInteger bIdx = -1;

-(BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
    
    BOOL isContainString = [(message?:@"") containsString:@"宝石不足"];
    
    //NSLocalizedString(@"ok", @"Ok")
    UIAlertView* dialogue = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:isContainString?@"去充值":@"确定", nil];
    
    dialogue.tag = JSConfirmDialogType;
    
    [dialogue show];
    
    while ([dialogue isVisible]) {
        
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
    }
    
    return diagStat;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (alertView.tag) {
        case JSAlertDialogType:{
            
            if (buttonIndex == 0) {
                
                NSLog(@"取消");
            }
            else if (buttonIndex == 1) {
                
                NSLog(@"确定");
            }
        }
            break;
            
        case JSConfirmDialogType:{
            
            bIdx = buttonIndex;
            
            if (buttonIndex == 0) {
                
                diagStat = NO;
                
            }
            else if(buttonIndex==1){
                
                diagStat = YES;
            }
            NSLog(@"isVisible:%@:",@([alertView isVisible]));
        }
            break;

        default:
            break;
    }
}

@end
