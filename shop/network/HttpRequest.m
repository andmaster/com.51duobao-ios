//
//  HttpRequest.m
//  shop
//
//  Created by zhangwenqiang on 16/6/17.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"

@implementation HttpRequest

/*GET请求*/
+(void)httpGet:(id)parameters
     URLString:(NSString*)URLString
      deletage:(id<HttpRequestDeletage>)deletage
          type:(HttpTagType)type{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSError* error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                                 URLString:URLString
                                                                                parameters:parameters
                                                                                     error:&error];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if (deletage != nil && [deletage respondsToSelector:@selector(failedError:type:)]) {
                [deletage failedError:error.description type:type];
            }
        } else {
            if (deletage != nil && [deletage respondsToSelector:@selector(successObject:response:type:)]){
                [deletage successObject:responseObject response:nil type:type];
            }
        }
    }];
    [dataTask resume];
}

/*POST请求*/
+(void)httpPost:(id)parameters
      URLString:(NSString*)URLString
       deletage:(id<HttpRequestDeletage>)deletage
           type:(HttpTagType)type{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSError* error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                 URLString:URLString
                                                                                parameters:parameters
                                                                                     error:&error];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if (deletage != nil && [deletage respondsToSelector:@selector(failedError:type:)]) {
                [deletage failedError:error.description type:type];
            }
        } else {
            if (deletage != nil && [deletage respondsToSelector:@selector(successObject:response:type:)]){
                [deletage successObject:responseObject response:response type:type];
            }
        }
    }];
    [dataTask resume];
}

/*POST请求*/
+(void)httpPostEntity:(NSString*)entity
            URLString:(NSString*)URLString
             deletage:(id<HttpRequestDeletage>)deletage
                 type:(HttpTagType)type{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSError* error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                 URLString:URLString
                                                                                parameters:nil
                                                                                     error:&error];
    
    //create the body
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"%@",entity] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postBody];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if (deletage != nil && [deletage respondsToSelector:@selector(failedError:type:)]) {
                [deletage failedError:error.description type:type];
            }
        } else {
            if (deletage != nil && [deletage respondsToSelector:@selector(successObject:response:type:)]){
                [deletage successObject:responseObject response:response type:type];
            }
        }
    }];
    [dataTask resume];
}

/*POST请求*/
+(void)httpPostBody:(NSString*)body
          URLString:(NSString*)URLString
           deletage:(id<HttpRequestDeletage>)deletage
               type:(HttpTagType)type{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSError* error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                 URLString:URLString
                                                                                parameters:nil error:&error];
    
    request.timeoutInterval = 1.5*60;
    
    //create the body
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"%@",body] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postBody];
    
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];//解析xml
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if (deletage != nil && [deletage respondsToSelector:@selector(failedError:type:)]) {
                [deletage failedError:error.description type:type];
            }
        } else {
            if (deletage != nil && [deletage respondsToSelector:@selector(successObject:response:type:)]){
                [deletage successObject:responseObject response:response type:type];
            }
        }
    }];
    [dataTask resume];
}



@end
