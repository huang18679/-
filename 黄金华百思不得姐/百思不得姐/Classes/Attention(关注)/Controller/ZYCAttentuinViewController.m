//
//  ZYCAttentuinViewController.m
//  百思不得姐
//
//  Created by zhou on 16/1/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCAttentuinViewController.h"
#import "ZYCRecommendFollowViewController.h"
#import "ZYCLoginRegisterViewController.h"

@interface ZYCAttentuinViewController ()

@end

@implementation ZYCAttentuinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条内容
    [self setupNavigationitem];

}

#pragma mark -设置导航条内容
- (void)setupNavigationitem
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highimage:[UIImage imageNamed:@"friendsRecommentIcon-click"] addTarget:self action:@selector(RecommentIcon)];
    
    self.navigationItem.title = @"我的关注";
}

- (void)RecommentIcon
{
    ZYCRecommendFollowViewController *recommend = [[ZYCRecommendFollowViewController alloc] init];

    [self.navigationController pushViewController:recommend animated:YES];
}
- (IBAction)Login:(id)sender {
    
    ZYCLoginRegisterViewController *loginregister = [[ZYCLoginRegisterViewController alloc] init];
    [self presentViewController:loginregister animated:YES completion:nil];
    
}


@end
