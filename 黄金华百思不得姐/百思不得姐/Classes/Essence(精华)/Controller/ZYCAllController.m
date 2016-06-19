//
//  ZYCAllController.m
//  百思不得姐
//
//  Created by zhou on 16/1/26.
//  Copyright © 2016年 zhou. All rights reserved.
//
/*
#import "ZYCAllController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "ZYCTopice.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>

#import "ZYCTopiceCell.h"
@interface ZYCAllController ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;
//帖子数据
@property (nonatomic,strong) NSMutableArray<ZYCTopice *> *topices;
//用来加载下一页数据
@property (nonatomic,copy) NSString *maxtime;

//刷新控件
//@property (nonatomic,weak) UIRefreshControl *header;


@end

static NSString * const ZYCTopiceCellID = @"ZYCTopiceCellID";

@implementation ZYCAllController
//懒加载AFHTTPSessionManager
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(ZYCNavMaxY + ZYCTitlesViewH, 0, ZYCTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
  //  self.tableView.rowHeight = 200;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCTopiceCell class]) bundle:nil] forCellReuseIdentifier:ZYCTopiceCellID];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabbarButtonDidRepeatClick) name:ZYCTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:ZYCTitleButtonDidRepeatClickNotification object:nil];
    
    //设置刷新
    [self setupRefresh];
}

#pragma mark - 执行通知方法
- (void)tabbarButtonDidRepeatClick
{
    //判断当前控制器的view是否在window上
    if (self.view.window == nil) return;
    
    //判断当前view是否和window重叠
    if (![self.view zyc_intersectWithView:nil]) return;
    
    //下拉刷新
    [self.tableView.mj_header beginRefreshing];
}

- (void)titleButtonDidRepeatClick
{
    [self tabbarButtonDidRepeatClick];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

#pragma mark - 数据
//加载新的帖子
- (void)loadNewTopics
{
    //取消请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(ZYCTopicTypeAll);
    
    //发送请求
    [self.manager GET:ZYCBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //保存maxtime,用来加载下一页数据
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组 --> 模型数组
        self.topices = [ZYCTopice mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新数据
        [self.tableView reloadData];
        
        //结束刷新状态
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新状态

        [self.tableView.mj_header endRefreshing];
    }];
}

//加载新的帖子
- (void)loadMoreTopics
{
    //取消请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //拼接数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @1;
    parameters[@"maxtime"] = self.maxtime;
    
    //发送请求
    [self.manager GET:ZYCBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //存储maxtime.用来加载下一次数据
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组 --> 模型数组
        NSArray *moreTopices = [ZYCTopice mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topices addObjectsFromArray:moreTopices];
        
        //刷新数据
        [self.tableView reloadData];
        
        //结束刷新状态
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //结束刷新状态
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - TableViewDatasource;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topices.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ZYCTopiceCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYCTopiceCellID];
    
    //传递模型数据
    cell.topic = self.topices[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topices[indexPath.row].cellHieght;
    
}

@end
*/

#import "ZYCAllController.h"

@interface ZYCAllController ()

@end

@implementation ZYCAllController


- (ZYCTopicType)type
{
    return ZYCTopicTypeAll;
}

@end


