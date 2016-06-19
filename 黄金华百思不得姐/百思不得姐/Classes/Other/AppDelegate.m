//
//  AppDelegate.m
//  百思不得姐
//
//  Created by zhou on 16/1/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "AppDelegate.h"
#import "ZYCTabBarController.h"
#import "ZYCAdViewController.h"
#import "ZYCTopWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //创建主窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置窗口的根控制器
    ZYCTabBarController *tabbarVc = [[ZYCTabBarController alloc] init];
    ZYCAdViewController *adVc = [[ZYCAdViewController alloc] init];
    
    self.window.rootViewController = adVc;
    
    //显示主窗口
    [self.window makeKeyAndVisible];
    
    //显示顶部窗口
    [ZYCTopWindow showWithStatusBarClickBlack:^{
        
        [self searchAllScrollViewsInView:application.keyWindow];
    }];
    
    return YES;
}

/**
 *  查找出view里面的所有scrollView
 */
- (void)searchAllScrollViewsInView:(UIView *)view
{
    //判断scrollview是否重叠
    if (![view zyc_intersectWithView:nil]) return;
    
    
    //遍历所有子控件
    for (UIView *subview in view.subviews) {
        [self searchAllScrollViewsInView:subview];
    }
    
    //如果不是scrollView,就返回
    if (![view isKindOfClass:[UIScrollView class]]) return;
    
    //滚动scrollView
    UIScrollView *scrollView = (UIScrollView *)view;
    CGPoint offset = scrollView.contentOffset;
    offset.y = - scrollView.contentInset.top;
    [scrollView setContentOffset:offset animated:YES];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
