//
//  ZYCTopWindow.m
//  百思不得姐
//
//  Created by zhou on 16/1/27.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCTopWindow.h"

@interface ZYCTopViewController : UIViewController
@property (nonatomic,copy) void(^statuseBlack)();

@end
@implementation ZYCTopViewController

#pragma mark - 状态栏控制
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.statuseBlack) {
        self.statuseBlack();
    }
}
@end
//**************************************

@interface ZYCTopWindow ()

@property (nonatomic,copy) void(^statuseBlack)();

@end

@implementation ZYCTopWindow

static ZYCTopWindow *window_;

+ (void)showWithStatusBarClickBlack:(void(^)())black
{
    window_ = [[ZYCTopWindow alloc] init];
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor clearColor];
    
    //显示window
    window_.hidden = NO;
    
    //设置根控制器
    ZYCTopViewController *topVc = [[ZYCTopViewController alloc] init];
    topVc.view.backgroundColor = [UIColor clearColor];
    topVc.view.frame = [UIApplication sharedApplication].statusBarFrame;
    topVc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    topVc.statuseBlack = black;
    window_.rootViewController = topVc;
}

/**
 *  当用户点击屏幕时，首先会调用这个方法，询问谁来处理这个点击事件
 *  @return 如果返回nil，代表当前window不处理这个点击事件
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 如果触摸点的y值 > 20，当前window不处理
    if (point.y > 20) return nil;
    
    // 如果触摸点的y值 <= 20，按照默认做法处理
    return [super hitTest:point withEvent:event];

}



@end
