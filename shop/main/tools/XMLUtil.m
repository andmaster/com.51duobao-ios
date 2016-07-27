//
//  XMLUtil.m
//  shop
//
//  Created by zhangwenqiang on 16/6/21.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "XMLUtil.h"

@implementation XMLUtil

static NSString* const XMLParserDidEndNotification = @"xml_parser_did_end_notify";

- (instancetype)initWithXMLParser:(NSXMLParser*)parser{
    self = [super init];
    if (self) {
        self.XMLParser = parser;
        //添加代理
        self.XMLParser.delegate = self;
    }
    return self;
}

//几个代理方法的实现，是按逻辑上的顺序排列的，但实际调用过程中中间三个可能因为循环等问题乱掉顺序
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidStartDocument...");
}

//准备节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    self.currentElement = elementName;
    
    if ([self.currentElement isEqualToString:@"xml"]){
        self.model = [[PayModel alloc] init];
    }
}

//获取节点内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if ([self.currentElement isEqualToString:@"return_code"]) {
        self.model.return_code = string;
        //[self.params setObject:string forKey:@"return_code"];
        
    }else if ([self.currentElement isEqualToString:@"return_msg"]){
        
        self.model.return_msg = string;
        //[self.params setObject:string forKey:@"return_msg"];
        
    }else if ([self.currentElement isEqualToString:@"appid"]){
        
        self.model.appid = string;
        //[self.params setObject:string forKey:@"appid"];
        
    }else if ([self.currentElement isEqualToString:@"mch_id"]){
        
        self.model.mch_id = string;
        [self.params setObject:string forKey:@"mch_id"];
        
    }else if ([self.currentElement isEqualToString:@"device_info"]){
        
        self.model.device_info = string;
        //[self.params setObject:string forKey:@"device_info"];
        
    }else if ([self.currentElement isEqualToString:@"nonce_str"]){
        
        self.model.nonce_str = string;
        //[self.params setObject:string forKey:@"nonce_str"];
        
    }else if ([self.currentElement isEqualToString:@"sign"]){
        
        self.model.sign = string;
        //[self.params setObject:string forKey:@"sign"];
        
    }else if ([self.currentElement isEqualToString:@"result_code"]){
        
        self.model.result_code = string;
       //[self.params setObject:string forKey:@"result_code"];
        
    }else if ([self.currentElement isEqualToString:@"err_code"]){
        
        self.model.err_code = string;
        //[self.params setObject:string forKey:@"err_code"];
        
    }else if ([self.currentElement isEqualToString:@"err_code_des"]){
        self.model.err_code_des = string;
        //[self.params setObject:string forKey:@"err_code_des"];
        
    }else if ([self.currentElement isEqualToString:@"trade_type"]){
        
        self.model.trade_type = string;
        //[self.params setObject:string forKey:@"trade_type"];
        
    }else if ([self.currentElement isEqualToString:@"prepay_id"]){
        
        self.model.prepay_id = string;
        [self.params setObject:string forKey:@"prepay_id"];
    }
}

//解析完一个节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    
    if ([elementName isEqualToString:@"xml"]) {
        
        [self.userInfo addObject:self.model];
        [self.userInfo addObject:self.params];
    }
    self.currentElement = nil;
}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidEndDocument...");
    [[NSNotificationCenter defaultCenter] postNotificationName:XMLParserDidEndNotification object:(NSMutableArray*)self.userInfo];
}

//初始化数组，存放解析后的数据
-(NSMutableArray *)userInfo{
    if (_userInfo == nil) {
        _userInfo= [NSMutableArray array];
    }
    return _userInfo;
}

//参数字典
-(NSMutableDictionary *)params{
    if (_params == nil) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

//外部调用接口
-(void)parse{
    [self.XMLParser parse];
    
}

@end
