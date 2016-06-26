//
//  OrderUtil.m
//  shop
//
//  Created by zhangwenqiang on 16/6/19.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "OrderUtil.h"
#import "NSString+MD5.h"
#import "Constants.h"
#import "IPAddress.h"
#import <UIKit/UIKit.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@interface IPModel : NSObject

@property(nonatomic,strong) NSString* name;
@property(nonatomic,strong) NSString* mac;
@property(nonatomic,strong) NSString* ip;

@end

@implementation IPModel

@synthesize name,mac,ip;

@end


@implementation OrderUtil

/******是 随机字符串****/
+(NSString*)nonceStr{
    NSString* random = [NSString stringWithFormat:@"%u",arc4random()];
    return [random MD5Hash];
}

/******是 通知地址****/
+(NSString*)notifyURL{
    return HOST;
}

/*****是 交易类型*****/
+(NSString*)tradeType{
    return TRADE_TYPE_WX;
}

/****否 设备号****/
+(NSString*)deviceInfo{
    return [UIDevice currentDevice].model;
}

/****//**是 终端IP****/
+(NSString*)spbillCreateIp{
    InitAddresses();
    GetIPAddresses();
    GetHWAddresses();
    
    int i;
    NSMutableArray* infoAddr = [NSMutableArray array];
    for (i=0; i < MAXADDRS; ++i){
        static unsigned long localHost = 0x7F000001;            // 127.0.0.1
        unsigned long theAddr;
        
        theAddr = ip_addrs[i];
        
        if (theAddr == 0) break;
        if (theAddr == localHost) continue;
        
        IPModel* model = [[IPModel alloc] init];
        model.name = @(if_names[i]);
        model.mac = @(hw_addrs[i]);
        model.ip = @(ip_names[i]);
        [infoAddr addObject:model];
        //NSLog(@"Name: %s MAC: %s IP: %s\n", if_names[i], hw_addrs[i], ip_names[i]);
    }
    IPModel* m = infoAddr[1];
    return m.ip;
}

/********Get IP Address******/
+(NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/****** 对象转xml *****/
+(NSString*)toXml:(id)data{
    NSMutableString* xml = [NSMutableString string];
    NSMutableDictionary* content = (NSMutableDictionary*)data;
    [xml appendString:@"<xml>"];
    
    NSArray<NSString*>* allKeys = content.allKeys;
    NSMutableArray* keys = [NSMutableArray arrayWithArray:allKeys];
    [keys sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    for (NSString* key in keys) {
        NSString* value = [content objectForKey:key];
        if (value == nil || value.length == 0) {
            continue;
        }
        [xml appendFormat:@"<%@>",key];
        [xml appendFormat:@"%@",value];
        [xml appendFormat:@"</%@>\n",key];
    }
    [xml appendString:@"</xml>"];
    
    return [NSString stringWithFormat:@"%@",xml];
}

/**获取时间**/
+(NSString*)getSystemTime{
    //获得系统时间
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    //[dateformatter setDateFormat:@"YYYY:HH:mm"];
    //NSString * locationString=[dateformatter stringFromDate:senddate];
    [dateformatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString * morelocationString=[dateformatter stringFromDate:senddate];
    
    //获得系统日期
//    NSCalendar * cal=[NSCalendar currentCalendar];
//    NSUInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
//    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
//    NSInteger year=[conponent year];
//    NSInteger month=[conponent month];
//    NSInteger day=[conponent day];
//    NSString * nsDateString= [NSString stringWithFormat:@"M年-月-日",year,month,day];
    return morelocationString;
}

/** 获取系统当前的时间戳 */
+(NSString*)timeStamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    return [timeString componentsSeparatedByString:@"."][0];
}

@end
