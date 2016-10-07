//
//  BaseAPI.h
//  shop
//
//  Created by zhangwenqiang on 16/6/12.
//  Copyright © 2016年 ishi. All rights reserved.
//

#ifndef BaseAPI_h
#define BaseAPI_h

#import "UIColor+extension.h"
#import "DLPanableWebView.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define STRING(object) [NSString stringWithFormat:@"%@",object]
#define STRINGFMT( fmt, ...) [NSString stringWithFormat:(fmt), ##__VA_ARGS__]
#define REUSEIDENTIFIER(identifier,indexPath) \
[NSString stringWithFormat:@"%@%@%@%@",identifier,@(indexPath.section),@(indexPath.row),@(indexPath.item)]
#define FONT(fontSize) [UIFont systemFontOfSize:fontSize]
#define COLOR(stringToConvert) [UIColor hexStringToColor:stringToConvert]
#define CGCOLOR(stringToConvert) COLOR(stringToConvert).CGColor
#define IMAGE(imageName) [UIImage imageNamed:imageName]
#define URLREQUEST(URLString) [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]]


#ifdef DEBUG

#define Log(fomat,...) NSLog( @"[%@:(%d)] %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(fomat), ##__VA_ARGS__] )

#else

#define Log(fomat,...)

#endif

#endif /* BaseAPI_h */
