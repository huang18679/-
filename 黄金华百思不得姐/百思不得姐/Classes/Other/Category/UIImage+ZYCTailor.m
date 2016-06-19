//
//  UIImage+ZYCTailor.m
//  百思不得姐
//
//  Created by zhou on 16/1/31.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "UIImage+ZYCTailor.h"

@implementation UIImage (ZYCTailor)
- (instancetype)zyc_tailorimage
{
    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    //描述裁剪路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    //设置裁剪区域
    [path addClip];
     
    //裁剪
    [self drawAtPoint:CGPointZero];
     
    //从上下文中获取裁剪好的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)zyc_tailorImageName:(NSString *)name
{
    return [[self imageNamed:name] zyc_tailorimage];
}

@end
