//
//  ZYCTabBarController.m
//  百思不得姐
//
//  Created by zhou on 16/1/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCTabBarController.h"
#import "ZYCAttentuinViewController.h"
#import "ZYCEssenceViewController.h"
#import "ZYCMeTableViewController.h"
#import "ZYCNewViewController.h"
#import "ZYCPublishViewController.h"

#import "ZYCTabBar.h"
#import "ZYCNavigationController.h"

@interface ZYCTabBarController ()

@end

@implementation ZYCTabBarController

+ (void)load
{
    //获得全局的UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];

    //正常
    NSMutableDictionary *norTitle = [NSMutableDictionary dictionary];
    norTitle[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:norTitle forState:UIControlStateNormal];
    
    //选中
    NSMutableDictionary *selTitle = [NSMutableDictionary dictionary];
    selTitle[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selTitle[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:selTitle forState:UIControlStateSelected];

}


- (void)viewDidLoad {
    [super viewDidLoad];

    //添加子控制器
    [self setupAllClickViewController];
    
    //设置TabBarButton
    [self setupClickTabBarButton];
    
    //自定义tabbar
    [self setuptabBar];
}

#pragma mark - 添加子控制器
- (void)setupAllClickViewController
{
    //精华
    ZYCEssenceViewController *essenceVc = [[ZYCEssenceViewController alloc] init];
    ZYCNavigationController *nav = [[ZYCNavigationController alloc] initWithRootViewController:essenceVc];
    [self addChildViewController:nav];
    
    //新帖
    ZYCNewViewController *newVc = [[ZYCNewViewController alloc] init];
    ZYCNavigationController *nav2 = [[ZYCNavigationController alloc] initWithRootViewController:newVc];
    [self addChildViewController:nav2];
    
    //关注
    ZYCAttentuinViewController *attentionVc = [[ZYCAttentuinViewController alloc] init];
    ZYCNavigationController *nav3 = [[ZYCNavigationController alloc] initWithRootViewController:attentionVc];
    [self addChildViewController:nav3];
    
    //我
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([ZYCMeTableViewController class]) bundle:nil];
    
    ZYCMeTableViewController *meVc = [storyBoard instantiateInitialViewController];
    ZYCNavigationController *nav4 = [[ZYCNavigationController alloc] initWithRootViewController:meVc];
    [self addChildViewController:nav4];

}

#pragma mark - 设置TabBarButton
- (void)setupClickTabBarButton
{
    //精华
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageinitWithOriginal:@"tabBar_essence_click_icon"];
    
    //新帖
    UINavigationController *nav2 = self.childViewControllers[1];
    nav2.tabBarItem.title = @"新帖";
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageinitWithOriginal:@"tabBar_new_click_icon"];
    
    //关注
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageinitWithOriginal:@"tabBar_friendTrends_click_icon"];
    
    //我
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我的";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageinitWithOriginal:@"tabBar_me_click_icon"];
}

#pragma mark - 自定义TabBar
- (void)setuptabBar
{
    ZYCTabBar *tabbar = [[ZYCTabBar alloc] init];
    
    [self setValue:tabbar forKey:@"tabBar"];
}
@end
