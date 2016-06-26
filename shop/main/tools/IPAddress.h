//
//  IPAddress.h
//  shop
//
//  Created by zhangwenqiang on 16/6/19.
//  Copyright © 2016年 ishi. All rights reserved.
//

#ifndef IPAddress_h
#define IPAddress_h

#include <stdio.h>

#define MAXADDRS    32

extern char *if_names[MAXADDRS];
extern char *ip_names[MAXADDRS];
extern char *hw_addrs[MAXADDRS];
extern unsigned long ip_addrs[MAXADDRS];

// Function prototypes

void InitAddresses();
void FreeAddresses();
void GetIPAddresses();
void GetHWAddresses();

#endif /* IPAddress_h */