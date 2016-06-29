//
//  ZXUserDefault.h
//  ZiXun_iOS
//
//  Created by PangTengFei on 16/3/12.
//  Copyright © 2016年 SYW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAPI.h"
@interface UserDefault : NSObject

+(UserDefault *)share;

/*
 * Writes any modifications to the persistent domains to disk and updates all unmodified persistent domains to what is on disk.
 */
- (BOOL)synchronize;

/*
 *保存随机字符串
 */
-(void) saveNonceStr:(NSString*) nonceStr;

/*
 *获得随机字符串
 */
-(NSString*) getNonceStr;


@end
