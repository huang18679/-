//
//  ZYCNewViewController.m
//  百思不得姐
//
//  Created by zhou on 16/1/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCNewViewController.h"
#import "ZYCSubTagTableViewController.h"


@interface ZYCNewViewController ()

@end

@implementation ZYCNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //设置导航条内容
    [self setupClickNavigationItem];
}

#pragma mark - 设置导航条内容
- (void)setupClickNavigationItem
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highimage:[UIImage imageNamed:@"MainTagSubIconClick"] addTarget:self action:@selector(SubIconClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)SubIconClick
{
    ZYCSubTagTableViewController *subtagVc = [[ZYCSubTagTableViewController alloc] init];
    
    [self.navigationController pushViewController:subtagVc animated:YES];
}

@end
