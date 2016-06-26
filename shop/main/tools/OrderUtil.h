//
//  OrderUtil.h
//  shop
//
//  Created by zhangwenqiang on 16/6/19.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderUtil : NSObject

/******是 随机字符串****/
+(NSString*)nonceStr;

/******是 通知地址****/
+(NSString*)notifyURL;

/*****是 交易类型*****/
+(NSString*)tradeType;

/****否 设备号****/
+(NSString*)deviceInfo;

/****//**是 终端IP****/
+(NSString*)spbillCreateIp;
/********Get IP Address******/
+(NSString *)getIPAddress;

/****** 对象转xml *****/
+(NSString*)toXml:(id)data;

/**获取时间**/
+(NSString*)getSystemTime;

/** 获取系统当前的时间戳 */
+(NSString*)timeStamp;

@end
