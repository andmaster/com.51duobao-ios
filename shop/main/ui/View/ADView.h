//
//  ADView.h
//  51indiana
//
//  Created by zhangwenqiang on 16/10/7.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADViewDeletage <NSObject>

- (void)currentPage:(NSInteger)currentPage;

@end

@interface ADView : UIView

@property (nonatomic, strong, readonly) UIScrollView *adScrollView;
@property (nonatomic, strong, readonly) UIPageControl *adPageControl;
@property (nonatomic, weak) id<ADViewDeletage> deletage;

- (id)initWithFrame:(CGRect)frame images:(NSArray<UIImage *> *)images;

@end
