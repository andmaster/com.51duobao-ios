//
//  UIImage+adjustImage.m
//  51indiana
//
//  Created by zhangwenqiang on 16/10/12.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "UIImage+adjustImage.h"
#import "NSString+Append.h"

//iPhone 4以前
//iPhone、iPhone3/3G机型未采用retina，坐标是320 x 480，屏幕像素320 x 480 ，他们一一对应，1:1关系。即一个坐标对应1个像素。
//iPhone 4/4s
//机器采用了retina屏幕，坐标是320 x 480，屏幕像素640 x 960，他们之间是1:2关系。即一个坐标对应2个像素。
//iPhone 5/5s/5c
//机器采用了retina屏幕，坐标是320 x 568，屏幕像素640 x 1136，他们之间关系式1:2关系。即一个坐标对应2个像素。
//iPhone 6
//机器采用了retina屏幕，坐标是375, 667，屏幕像素750 x 1334，他们之间关系式1:2关系。即一个坐标对应2个像素。
//iPhone 6 plus
//机器采用了retina屏幕，坐标是414, 736，屏幕像素1080 x 1920，他们之间关系式1:2.6关系。即一个坐标对应2.6个像素。

@implementation UIImage (adjustImage)

-(UIImage *)addImageNameForFit:(NSString *)name
{
    //NSString * deviceName = [[UIDevice currentDevice] name];
    
    //进行判断，对不同的机型加入不同的图片名称的后缀，返回不同的适配图片
    if (IS_IPHONE_4_OR_LESS) {
        //name = [name fileNameAppend:@"-480h@2x"];
        name = [name stringByAppendingString:@"_960"];
    }
    else if (IS_IPHONE_5) {
        //name = [name fileNameAppend:@"-568h@2x"];
        name = [name stringByAppendingString:@"_1136"];
    }
    else if (IS_IPHONE_6) {
        //name = [name fileNameAppend:@"-667h@2x"];
        name = [name stringByAppendingString:@"_1280"];
    }
    else if (IS_IPHONE_6P) {
        //name = [name fileNameAppend:@"-736h@2x"];
        name = [name stringByAppendingString:@"_1334"];
    }
    else if (IS_IPHONE_7) {
        //name = [name fileNameAppend:@"-736h@2x"];
        name = [name stringByAppendingString:@"_1334"];
    }
    else if (IS_IPHONE_7P) {
        //name = [name fileNameAppend:@"-736h@2x"];
        name = [name stringByAppendingString:@"_2208"];
    }

    return [UIImage imageNamed:name];
}

@end
