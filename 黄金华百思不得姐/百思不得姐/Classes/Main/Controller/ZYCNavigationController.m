//
//  ZYCNavigationController.m
//  百思不得姐
//
//  Created by zhou on 16/1/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCNavigationController.h"

@interface ZYCNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation ZYCNavigationController

+ (void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    
    [navBar setTitleTextAttributes:dict];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //全屏滑动返回
    id target = self.interactivePopGestureRecognizer.delegate;
    
   // self.interactivePopGestureRecognizer.delegate = self;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    pan.delegate = self;
    
    
    [self.view addGestureRecognizer:pan];

    self.interactivePopGestureRecognizer.enabled = NO;
    
//    NSLog(@"%@",target);
//   NSLog(@"%@",pan);
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        // 非根控制器,设置返回按钮
        //设置跳转到非根控制器时,下部的tabbar隐藏
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highimage:[UIImage imageNamed:@"navigationButtonReturnClick"] addTarget:self action:@selector(backClick) title:@"返回"];
    }
    //实现跳转
    [super pushViewController:viewController animated:animated];
}

- (void)backClick
{
    [self popViewControllerAnimated:YES];
}

//是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}
@end
