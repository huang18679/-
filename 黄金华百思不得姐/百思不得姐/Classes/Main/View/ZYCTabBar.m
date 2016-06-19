//
//  ZYCTabBar.m
//  百思不得姐
//
//  Created by zhou on 16/1/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCTabBar.h"
#import "ZYCPublishViewController.h"

@interface ZYCTabBar ()

@property (nonatomic,weak) UIButton *pubButton;

@property (nonatomic,assign) NSInteger previousClickedTabBarButtonTag;
@end

@implementation ZYCTabBar

- (UIButton *)pubButton
{
    if (!_pubButton) {

        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [but sizeToFit];
        [self addSubview:but];
        _pubButton = but;
    }
    [_pubButton addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return _pubButton;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.items.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.frame.size.width / (count + 1);
    CGFloat h = self.frame.size.height;

    int i = 0;
    for (UIControl *tabbarBut in self.subviews) {
        if ([tabbarBut isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
           
            if (i == 2) {
                i +=1;
            }
            x = i * w;
            tabbarBut.frame = CGRectMake(x, y, w, h);
            tabbarBut.tag = i;
            i++;
            
            [tabbarBut addTarget:self action:@selector(tabbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    //设置加号按钮的位置
    self.pubButton.center = CGPointMake(ZYCScreenW * 0.5, h * 0.5);
}

- (void)tabbarButtonClick:(UIControl *)tabbarBut
{
    if (self.previousClickedTabBarButtonTag == tabbarBut.tag) {
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:ZYCTabBarButtonDidRepeatClickNotification object:nil];
    }
    self.previousClickedTabBarButtonTag = tabbarBut.tag;
}


- (void)ClickButton:(UIButton *)but
{
    ZYCPublishViewController *publishView = [[ZYCPublishViewController alloc] init];
    
    [self.window.rootViewController presentViewController:publishView animated:YES completion:nil];
}


@end
