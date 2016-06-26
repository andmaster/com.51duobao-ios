//
//  PayModel.h
//  shop
//
//  Created by zhangwenqiang on 16/6/21.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayModel : NSObject

@property(nonatomic,strong) NSString *return_code;/* 返回状态码 */
@property(nonatomic,strong) NSString *return_msg;/* 返回信息 */

@property(nonatomic,strong) NSString *appid;/* 应用APPID */
@property(nonatomic,strong) NSString *mch_id;/* 商户号 */
@property(nonatomic,strong) NSString *device_info;/* 设备号 */
@property(nonatomic,strong) NSString *nonce_str;/** 随机串，防重发 */
@property(nonatomic,strong) NSString *sign;/** 商家根据微信开放平台文档对数据做的签名 */

@property(nonatomic,strong) NSString *result_code;/* 业务结果 */
@property(nonatomic,strong) NSString *err_code;/* 错误代码 */
@property(nonatomic,strong) NSString *err_code_des;/* 错误代码描述 */

@property(nonatomic,strong) NSString *trade_type;/** 交易类型 */
@property(nonatomic,strong) NSString *prepay_id;/** 预支付交易会话标识 */

@property(nonatomic,strong) NSString *package;/* 扩展字段 */
@property(nonatomic,strong) NSString *timestamp;/* 时间戳 */
@property(nonatomic,strong) NSString *openID;


//@synthesize return_code,return_msg,appid,mch_id,device_info,nonce_str,sign,result_code,err_code,err_code_des,trade_type,prepay_id;

@end
