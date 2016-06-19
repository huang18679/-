//
//  UIImage+ZYCimage.m
//  百思不得姐
//
//  Created by zhou on 16/1/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "UIImage+ZYCimage.h"

@implementation UIImage (ZYCimage)

+ (UIImage *)imageinitWithOriginal:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
