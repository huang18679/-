//
//  ZYCMeTableViewController.m
//  百思不得姐
//
//  Created by zhou on 16/1/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCMeTableViewController.h"
#import "ZYCSettingTableController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "ZYCSquareItem.h"
#import "ZYCSquareCell.h"
#import "ZYCWebViewController.h"

@interface ZYCMeTableViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray *squareList;

@property (nonatomic,weak) UICollectionView *collectionView;
@end

static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const margin = 0.5;
#define cellWH (ZYCScreenW - (cols - 1) * margin) / cols

@implementation ZYCMeTableViewController

//- (NSMutableArray *)squareList
//{
//    if (!_squareList) {
//        _squareList = [NSMutableArray array];
//    }
//    return _squareList;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ZYCColor(256, 256, 256);
    
    //设置导航栏
    [self setupNavigationBar];
 
    //设置数据
    [self loadData];
    //设置tableFooterView视图
    [self setupAllClickCollectionView];
    
    //设置cell间距
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
}

#pragma mark - 加载数据
- (void)loadData
{
    //创建会话
    AFHTTPSessionManager *manager= [AFHTTPSessionManager manager];
    
    //拼接数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    //发送请求
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        //字典数组转模型数组
        self.squareList = [ZYCSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        //刷新表格
        [self.collectionView reloadData];
        
        //计算collectionView的高度
        NSInteger count = _squareList.count;
        NSInteger rows = (count - 1) / cols + 1;
        CGFloat collectionH = rows * cellWH;
        self.collectionView.zyc_height = collectionH;
        
        //重新设置collectionView的高度
        self.tableView.tableFooterView = self.collectionView;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 添加collectionView
- (void)setupAllClickCollectionView
{
    //设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(cellWH, cellWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
   
    //添加collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 150) collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = collectionView;
    //设置collectionView不能滚动
    self.collectionView.scrollEnabled = NO;
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCSquareCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma amrk -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYCSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.squareList[indexPath.row];
    
    return cell;
}

#pragma mark -设置导航栏
- (void)setupNavigationBar
{
    UIBarButtonItem *item1 = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highimage:[UIImage imageNamed:@"mine-setting-icon-click"] addTarget:self action:@selector(settingClick)];
    
    UIBarButtonItem *item2 = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selimage:[UIImage imageNamed:@"mine-moon-icon-click"] addTarget:self action:@selector(moonClick:)];
    
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.rightBarButtonItems = @[item1,item2];
}

//点击设置按钮
- (void)settingClick
{
    ZYCSettingTableController *setting = [[ZYCSettingTableController alloc] init];
    
    [self.navigationController pushViewController:setting animated:YES];
}
//点击夜间模式
- (void)moonClick:(UIButton *)but
{
    but.selected = !but.selected;
}

#pragma mark -点击某个cell时调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //获取模型
    ZYCSquareItem *item = self.squareList[indexPath.row];
    if ([item.url hasPrefix:@"http"]) {
        
        ZYCWebViewController *webView = [[ZYCWebViewController alloc] init];
        webView.url = [NSURL URLWithString:item.url];
        
        [self.navigationController pushViewController:webView animated:YES];
    }
}
@end
