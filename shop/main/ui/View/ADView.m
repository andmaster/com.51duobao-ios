//
//  ADView.m
//  51indiana
//
//  Created by zhangwenqiang on 16/10/7.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "ADView.h"

@interface ADView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *adScrollView;
@property (nonatomic, strong) UIPageControl *adPageControl;

@end

@implementation ADView

- (id)initWithFrame:(CGRect)frame images:(NSArray<UIImage *> *)images
{
    if (self = [super initWithFrame:frame]) {
        
        [self initViews:frame images:images];
    }
    return self;
}

- (void)initViews:(CGRect)frame images:(NSArray<UIImage*>*)images{

    _adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    _adScrollView.pagingEnabled = true;
    
    _adScrollView.bounces = false;
    
    _adScrollView.delegate = self;
    
    _adScrollView.contentSize = CGSizeMake(frame.size.width * images.count, frame.size.height);
    
    _adScrollView.showsVerticalScrollIndicator = NO;
    
    _adScrollView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:_adScrollView];
    
    [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView * adImageView = [[UIImageView alloc] initWithImage:obj];
        
        adImageView.frame = CGRectMake(frame.size.width * idx, 0, frame.size.width, frame.size.height);
        
        [_adScrollView addSubview:adImageView];
    }];
    
    _adPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_adScrollView.frame)-30, frame.size.width, 0)];
    
    [_adPageControl addTarget:self
                       action:@selector(pageTurn:)
             forControlEvents:UIControlEventAllEditingEvents];
    
    _adPageControl.numberOfPages = images.count;//设置点的个数
    
    _adPageControl.currentPage = 0;
    
    [self addSubview:_adPageControl];
}

- (void) pageTurn:(UIPageControl *)sender
{
    CGSize viewSize = _adScrollView.frame.size;
    
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    
    [_adScrollView scrollRectToVisible:rect animated:YES];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    CGRect bounds = scrollView.frame;
    
    _adPageControl.currentPage = offset.x / bounds.size.width;
    
    if (_deletage != nil && [_deletage respondsToSelector:@selector(currentPage:)]) {
        
        [_deletage currentPage:_adPageControl.currentPage];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
