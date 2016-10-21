//
//  NSString+Append.m
//  51indiana
//
//  Created by zhangwenqiang on 16/10/12.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "NSString+Append.h"

@implementation NSString (Append)

-(NSString *)fileNameAppend:(NSString *)string
{
    //拿到扩展名
    NSString *extension = [self pathExtension];
    
    //去掉扩展名
    NSString *fileName = [self stringByDeletingPathExtension];
    
    //拼接字符串名称
    fileName = [fileName stringByAppendingString:string];
    
    //加入扩展名
    NSString *newFileName = [fileName stringByAppendingPathExtension:extension];
    
    //返回处理好的图片名
    return newFileName;
}

@end
