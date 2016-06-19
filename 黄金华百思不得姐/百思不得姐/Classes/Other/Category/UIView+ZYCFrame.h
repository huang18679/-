//
//  UIView+ZYCFrame.h
//  百思不得姐
//
//  Created by zhou on 16/1/19.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYCFrame)

@property CGFloat zyc_x;
@property CGFloat zyc_y;
@property CGFloat zyc_width;
@property CGFloat zyc_height;

@property CGFloat zyc_centX;
@property CGFloat zyc_centY;

/**
 *  判断self和view是否重叠
 */
- (BOOL)zyc_intersectWithView:(UIView *)view;
@end
