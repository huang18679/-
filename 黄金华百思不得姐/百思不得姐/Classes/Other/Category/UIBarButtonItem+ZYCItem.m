//
//  UIBarButtonItem+ZYCItem.m
//  百思不得姐
//
//  Created by zhou on 16/1/19.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "UIBarButtonItem+ZYCItem.h"

@implementation UIBarButtonItem (ZYCItem)

+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image highimage:(UIImage *)highimage addTarget:(id)Target action:(SEL)action
{
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setImage:image forState:UIControlStateNormal];
    [Button setImage:highimage forState:UIControlStateHighlighted];
    [Button sizeToFit];
    [Button addTarget:Target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *ButtonView = [[UIView alloc] initWithFrame:Button.bounds];
    [ButtonView addSubview:Button];
    return [[UIBarButtonItem alloc] initWithCustomView:ButtonView];
}

+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image selimage:(UIImage *)selimage addTarget:(id)Target action:(SEL)action
{
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setImage:image forState:UIControlStateNormal];
    [Button setImage:selimage forState:UIControlStateSelected];
    [Button sizeToFit];
    [Button addTarget:Target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *ButtonView = [[UIView alloc] initWithFrame:Button.bounds];
    [ButtonView addSubview:Button];
    return [[UIBarButtonItem alloc] initWithCustomView:ButtonView];
}

//返回按钮
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highimage:(UIImage *)highimage addTarget:(id)Target action:(SEL)action title:(NSString *)title
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highimage forState:UIControlStateHighlighted];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton sizeToFit];
    
    //设置内容的内边距
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [backButton addTarget:Target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}

@end
