//
//  ZYCRecommendFollowViewController.m
//  百思不得姐
//
//  Created by zhou on 16/1/20.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCRecommendFollowViewController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "ZYCFollowCategory.h"
#import "ZYCFollowUser.h"
#import "ZYCCategoryCell.h"
#import "ZYCUserCell.h"

@interface ZYCRecommendFollowViewController () <UITableViewDelegate,UITableViewDataSource>

//左边类别的表格
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

//右边用户的表格
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic,strong) AFHTTPSessionManager *manager;

//类别的数据
@property (nonatomic,strong) NSMutableArray *categoryArray;
@end

@implementation ZYCRecommendFollowViewController

//懒加载
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

static NSString *ZYCCategoryCellId = @"category";
static NSString *ZYCUserCellId = @"user";



- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tableview的属性
    [self setupTable];

    //设置刷新控件
    [self setupRefresh];
    
    
    //左边表格加载数据
    [self loadCategories];
}

- (void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUser)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUser)];
}

- (void)setupTable
{
    self.title = @"推荐标签";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets inset = UIEdgeInsetsMake(ZYCNavMaxY, 0, 0, 0);
    self.categoryTableView.contentInset = inset;
    self.categoryTableView.scrollIndicatorInsets = inset;
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCCategoryCell class]) bundle:nil] forCellReuseIdentifier:ZYCUserCellId];
    
    self.userTableView.rowHeight = 70;
    self.userTableView.contentInset = inset;
    self.userTableView.scrollIndicatorInsets = inset;
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCUserCell class]) bundle:nil] forCellReuseIdentifier:ZYCUserCellId];
}

- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}


#pragma mark -- 加载数据
- (void)loadCategories{
    
    //弹框
    [SVProgressHUD show];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    ZYCWeakSelf
    //发送请求
    [self.manager GET:ZYCBaseUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        //字典数组 --> 模型数组

        weakSelf.categoryArray = [ZYCFollowCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        NSLog(@"%@",self.categoryArray);
        //刷新表格

        [weakSelf.categoryTableView reloadData];
        
        //默认选中第0行
        [weakSelf.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //让右边表格进入下拉刷新
        [weakSelf.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",error);
    }];
}

- (void)loadNewUser{
    
    //取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    
    //右边选中类型的id
    ZYCFollowCategory *selectedCategory = self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row];
    params[@"category_id"] = selectedCategory.ID;
    
    //发送请求
    [self.manager GET:ZYCBaseUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //设置页码为1
        selectedCategory.page = 1;
        
        //储存总数
        selectedCategory.total = [responseObject[@"total"] integerValue];
        
        //存储总数
        selectedCategory.users = [ZYCFollowUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        //刷新右边的表格
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        if (selectedCategory.users.count >= selectedCategory.total) {
            // 这组的所有用户数据已经加载完毕
            self.userTableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
    
}

- (void)loadMoreUser{
    
    //取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    
    //左边选中类型的id
    ZYCFollowCategory *selectedCategory = self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row];
    params[@"u"] = selectedCategory.ID;
    
    //页码
    NSInteger page = selectedCategory.page + 1;
    params[@"page"] = @(page);
    
    //发送请求
    [self.manager GET:ZYCBaseUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //设置当前的最新页码
        selectedCategory.page = page;
        
        //存储总数
        selectedCategory.total = [responseObject[@"total"] integerValue];
        
        //追加新的用户数据的数组中
        NSArray *newUser = [ZYCFollowUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [selectedCategory.users addObjectsFromArray:newUser];
        
        //刷新右边的表格
        [self.userTableView reloadData];
        
        if (selectedCategory.users.count >= selectedCategory.total) {
            //这组所有的用户数据已经加载完毕
            self.userTableView.mj_footer.hidden = YES;
        }else{
            //结束刷新
            [self.userTableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {  //左边的
        return self.categoryArray.count;
        
    }else{  //右边的
        ZYCFollowCategory *selectedCategory = self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row];
        return selectedCategory.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {  //左边的
        ZYCCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYCCategoryCellId];
        
        cell.category = self.categoryArray[indexPath.row];
        
        return cell;
        
    }else{  //右边的
        
        ZYCUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYCUserCellId];
        //左边选中的类别
        ZYCFollowCategory *selectedCategory = self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = selectedCategory.users[indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {  //左边的表格
        ZYCFollowCategory *selectedCategory = self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row];
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        // 判断footer是否应该显示
        if (selectedCategory.users.count >= selectedCategory.total) {
            // 这组的所有用户数据已经加载完毕
            self.userTableView.mj_footer.hidden = YES;
        }
        
        if (selectedCategory.users.count == 0) {  //从未有过数据
            //加载右边的用户数据
            [self.userTableView.mj_header beginRefreshing];
        }
        
    }else {  //右边的表格
        
        NSLog(@"点击了%zd行",indexPath.row);
    }

}

@end
