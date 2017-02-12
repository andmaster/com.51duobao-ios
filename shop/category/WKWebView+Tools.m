//
//  WKWebView+Tools.m
//  51indiana
//
//  Created by LiuBuyaolian on 2017/2/12.
//  Copyright © 2017年 ishi. All rights reserved.
//

#import "WKWebView+Tools.h"


@implementation WKWebView (Tools)

@dynamic actionTag;

static char * NSObject_key_tag_WKWebView = "NSObject_key_tag_WKWebView";

- (void)setActionTag:(ActionTag)tag{
    /*
     OBJC_ASSOCIATION_ASSIGN;            //assign策略
     OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
     OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
     
     OBJC_ASSOCIATION_RETAIN;
     OBJC_ASSOCIATION_COPY;
     */
    /*
     * id object 给哪个对象的属性赋值
     const void *key 属性对应的key
     id value  设置属性值为value
     objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     */
    
    
    [self willChangeValueForKey:@"NSObject_key_tag_WKWebView"];
    
    objc_setAssociatedObject(self, NSObject_key_tag_WKWebView, @(tag), OBJC_ASSOCIATION_ASSIGN);
    
    [self didChangeValueForKey:@"NSObject_key_tag_WKWebView"];
}

- (ActionTag)actionTag{
    
    NSNumber * number = objc_getAssociatedObject(self, NSObject_key_tag_WKWebView);
    
    return [number integerValue];
}


- (void)clearBackColorForWebView{
    
    self.backgroundColor = [UIColor clearColor];
    
    self.opaque = NO;
    
    for (UIView *aView in [self subviews]) {
        
        if ([aView isKindOfClass:[UIScrollView class]]) {
            
            //[(UIScrollView *)aView setShowsVerticalScrollIndicator:NO];
            
            for (UIView *shadowView in aView.subviews) {
                
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    
                    shadowView.hidden = YES;//上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                }
            }
        }
    }
}

- (void)didNotLeftOrRightScrollForWebView{
    
    [(UIScrollView *)[[self subviews] objectAtIndex:0] setBounces:NO];
}

- (NSString*) titleString{
    
    return self.title;
}

@end
