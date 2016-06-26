//
//  PayModel.m
//  shop
//
//  Created by zhangwenqiang on 16/6/21.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "PayModel.h"

@implementation PayModel

@synthesize return_code,return_msg,appid,mch_id,device_info,nonce_str,sign,result_code,err_code,err_code_des,trade_type,prepay_id,package,timestamp,openID;

-(NSString *)description{
    return [NSString stringWithFormat:@"PayModel{return_code=%@,return_msg=%@,appid=%@,mch_id=%@,device_info=%@,nonce_str=%@,sign=%@,result_code=%@,err_code=%@,err_code_des=%@,trade_type=%@,prepay_id=%@,package=%@,timestamp=%@,opendID=%@}",return_code,return_msg,appid,mch_id,device_info,nonce_str,sign,result_code,err_code,err_code_des,trade_type,prepay_id,package,timestamp,openID];
}

@end
