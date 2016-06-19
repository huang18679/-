//
//  UIView+ZYCInit.m
//  百思不得姐
//
//  Created by zhou on 16/2/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "UIView+ZYCInit.h"

@implementation UIView (ZYCInit)

+ (instancetype)zyc_viewFromXib
{

    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
