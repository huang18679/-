//
//  UIBarButtonItem+ZYCItem.h
//  百思不得姐
//
//  Created by zhou on 16/1/19.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZYCItem)

//  创建UIBarButtonItem,高亮
+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image highimage:(UIImage *)highimage addTarget:(id)Target action:(SEL)action;

//  创建UIBarButtonItem,选中
+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image selimage:(UIImage *)selimage addTarget:(id)Target action:(SEL)action;

//设置返回按钮
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highimage:(UIImage *)highimage addTarget:(id)Target action:(SEL)action title:(NSString *)title;
@end
