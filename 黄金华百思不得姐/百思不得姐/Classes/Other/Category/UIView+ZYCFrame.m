//
//  UIView+ZYCFrame.m
//  百思不得姐
//
//  Created by zhou on 16/1/19.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "UIView+ZYCFrame.h"

@implementation UIView (ZYCFrame)

- (BOOL)zyc_intersectWithView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    CGRect rect1 = [self convertRect:self.bounds toView:nil];
    CGRect rect2 = [view convertRect:view.bounds toView:nil];
    
    return CGRectIntersectsRect(rect1, rect2);
}


- (CGFloat)zyc_x
{
    return self.frame.origin.x;
}

- (void)setZyc_x:(CGFloat)zyc_x
{
    CGRect frame = self.frame;
    frame.origin.x = zyc_x;
    self.frame = frame;
}

- (CGFloat)zyc_y
{
    return self.frame.origin.y;
}

- (void)setZyc_y:(CGFloat)zyc_y
{
    CGRect frame = self.frame;
    frame.origin.y = zyc_y;
    self.frame = frame;
}

- (CGFloat)zyc_width
{
    return self.frame.size.width;
}

- (void)setZyc_width:(CGFloat)zyc_width
{
    CGRect frame = self.frame;
    frame.size.width = zyc_width;
    self.frame = frame;
}

- (CGFloat)zyc_height
{
    return self.frame.size.height;
}

- (void)setZyc_height:(CGFloat)zyc_height
{
    CGRect frame = self.frame;
    frame.size.height = zyc_height;
    self.frame = frame;
}

- (CGFloat)zyc_centX
{
    return self.center.x;
}

- (void)setZyc_centX:(CGFloat)zyc_centX
{
    CGPoint center = self.center;
    center.x = zyc_centX;
    self.center = center;
}

- (CGFloat)zyc_centY
{
    return self.center.y;
}

- (void)setZyc_centY:(CGFloat)zyc_centY
{
    CGPoint center = self.center;
    center.y = zyc_centY;
    self.center = center;
}
@end
