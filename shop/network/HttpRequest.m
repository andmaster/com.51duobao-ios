//
//  HttpRequest.m
//  shop
//
//  Created by zhangwenqiang on 16/6/17.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "BaseAPI.h"

@implementation HttpRequest

/*GET请求*/
+(void)httpGet:(id)parameters deletage:(id<HttpRequestDeletage>)deletage type:(HttpTagType)type{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSError* error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:HOST parameters:parameters error:&error];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            Log(@"Error: %@", error.description);
            if (deletage != nil && [deletage respondsToSelector:@selector(failedError:type:)]) {
                [deletage failedError:error.description type:type];
            }
        } else {
            Log(@"%@ %@", response, responseObject);
            if (deletage != nil && [deletage respondsToSelector:@selector(successObject:response:type:)]){
                [deletage successObject:responseObject response:response type:type];
            }
        }
    }];
    [dataTask resume];
}

/*POST请求*/
+(void)httpPost:(id)parameters deletage:(id<HttpRequestDeletage>)deletage type:(HttpTagType)type{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSError* error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:HOST parameters:parameters error:&error];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            Log(@"Error: %@", error.description);
            if (deletage != nil && [deletage respondsToSelector:@selector(failedError:type:)]) {
                [deletage failedError:error.description type:type];
            }
        } else {
            Log(@"%@ %@", response, responseObject);
            if (deletage != nil && [deletage respondsToSelector:@selector(successObject:response:type:)]){
                [deletage successObject:responseObject response:response type:type];
            }        }
    }];
    [dataTask resume];
}

@end
