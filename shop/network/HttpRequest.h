//
//  HttpRequest.h
//  shop
//
//  Created by zhangwenqiang on 16/6/17.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpTag.h"

@protocol HttpRequestDeletage <NSObject>

-(void)successObject:(id)responseObject response:(NSURLResponse*)response type:(HttpTagType) type;
-(void)failedError:(NSString*)error type:(HttpTagType) type;

@end

@interface HttpRequest : NSObject

+(void)httpGet:(id)parameters deletage:(id<HttpRequestDeletage>)deletage type:(HttpTagType)type;/*GET请求*/

+(void)httpPost:(id)parameters deletage:(id<HttpRequestDeletage>)deletage type:(HttpTagType)type;/*POST请求*/

@end
