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

/*GET请求*/
+(void)httpGet:(id)parameters URLString:(NSString*)URLString deletage:(id<HttpRequestDeletage>)deletage type:(HttpTagType)type;

/*POST请求*/
+(void)httpPost:(id)parameters URLString:(NSString*)URLString deletage:(id<HttpRequestDeletage>)deletage type:(HttpTagType)type;

/*POST请求 entity*/
+(void)httpPostEntity:(NSString*)entity URLString:(NSString*)URLString deletage:(id<HttpRequestDeletage>)deletage type:(HttpTagType)type;

/*POST请求*/
+(void)httpPostBody:(NSString*)body URLString:(NSString*)URLString deletage:(id<HttpRequestDeletage>)deletage type:(HttpTagType)type;

@end
