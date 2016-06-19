//
//  ZYCSubTagTableViewController.m
//  百思不得姐
//
//  Created by zhou on 16/1/21.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCSubTagTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "ZYCSubTagItem.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "ZYCSubTagTableViewCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ZYCSubTagTableViewController ()

@property (nonatomic,weak) AFHTTPSessionManager *manager;

@property (nonatomic,strong) NSArray *subtags;
@end

static NSString * const ID = @"cell";

//http://api.budejie.com/api/api_open.php
@implementation ZYCSubTagTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题.只有在非根控制器才能这样设置
    self.title = @"推荐标签";
    
    //提示用户正在加载
    [SVProgressHUD showWithStatus:@"正在加载ing..."];
    
    //加载数据
    [self loadData];

    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCSubTagTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    //设置分割线
    //取消系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置tableview的背景颜色为分割线的颜色
    self.tableView.backgroundColor = ZYCColor(206, 206, 206);
}

//控制器的view即将消失的时候调用
- (void)viewWillDisappear:(BOOL)animated
{
    //隐藏提示
    [SVProgressHUD dismiss];

    //取消请求
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

#pragma mark -加载数据
- (void)loadData
{
    //创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    
    //发送请求
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
      //字典数组转换为模型数组
        _subtags = [ZYCSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        //刷新表格
        [self.tableView reloadData];
        
        //隐藏加载提示
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //隐藏指示器
        [SVProgressHUD dismiss];
    }];
}

//返回多少cell
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _subtags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //缓存池
    ZYCSubTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    ZYCSubTagItem *item = self.subtags[indexPath.row];
    
    cell.item =item;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
@end
