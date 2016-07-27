//
//  XMLUtil.h
//  shop
//
//  Created by zhangwenqiang on 16/6/21.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayModel.h"

static NSString* const XMLParserDidEndNotification;

@interface XMLUtil : NSObject<NSXMLParserDelegate>

//添加属性
@property (nonatomic, strong) NSXMLParser *XMLParser;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) PayModel *model;
//存放每个Field
@property (nonatomic, strong) NSMutableArray *userInfo;
//标记当前标签，以索引找到XML文件内容
@property (nonatomic, copy) NSString *currentElement;
//初始化解析工具类
- (instancetype)initWithXMLParser:(NSXMLParser*)parser;
//声明parse方法，通过它实现解析
-(void)parse;

@end
