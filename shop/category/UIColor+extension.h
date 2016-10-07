//
//  UIColor+extension.h
//  Xiaozufan
//
//  Created by 王付元 on 15/5/18.
//  Copyright (c) 2015年 Xiaozufan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (extension)

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*) color;
+ (UIColor *) hexStringToColor: (NSString *) stringToConvert;

@end
