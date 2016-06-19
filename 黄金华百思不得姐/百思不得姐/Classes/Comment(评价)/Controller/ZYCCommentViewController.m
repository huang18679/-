//
//  ZYCCommentViewController.m
//  百思不得姐
//
//  Created by zhou on 16/2/20.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCCommentViewController.h"
#import "ZYCCommentCell.h"
#import <MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import <AFNetworking/AFNetworking.h>
#import "ZYCUse.h"
#import "ZYCComment.h"
#import "ZYCRefreshHeader.h"
#import "ZYCTopice.h"
#import "ZYCCommentSectionHeader.h"
#import "ZYCTopiceCell.h"

@interface ZYCCommentViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;

/**任务管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;

/**最热评论的数据*/
@property (nonatomic,strong) NSMutableArray<ZYCComment *> *hotestComment;

/**最新评论的数据*/
@property (nonatomic,strong) NSMutableArray<ZYCComment *> *lastestComment;

//最热评论
@property (nonatomic,strong) ZYCComment *savedTopcmt;
@end

static NSString * const ZYCCommentCellId = @"comment";
static NSString * const ZYCSectionHeaderlId = @"header";


@implementation ZYCCommentViewController
//懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBase];
    
    [self setupTable];
    
    [self setupRefresh];
    
    [self setupHeader];
}

- (void)setupHeader
{
    //处理模型数据
    self.savedTopcmt = self.topic.top_cmt;
    self.topic.top_cmt = nil;
    self.topic.cellHeight = 0;
    
    //创建headerView
    UIView *headerView = [[UIView alloc] init];
    
    //添加cell到header中
    ZYCTopiceCell *cell = [ZYCTopiceCell zyc_viewFromXib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    [headerView addSubview:cell];
    
    headerView.zyc_height = cell.zyc_height + ZYCMargin * 2;
    
    self.tableView.tableHeaderView = headerView;

}

#pragma mark - 初始化
- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCCommentCell class]) bundle:nil] forCellReuseIdentifier:ZYCCommentCellId];
    
    [self.tableView registerClass:[ZYCCommentSectionHeader class] forHeaderFooterViewReuseIdentifier:ZYCSectionHeaderlId];
    
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    // 每一组头部控件的高度
    self.tableView.sectionHeaderHeight = ZYCCommentSectionHeaderFont.lineHeight + 2;
    // 设置cell的高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
}

#pragma mark - 刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];

}

#pragma mark - 设置通知
- (void)setupBase
{
    self.navigationItem.title = @"评论";
    
    //发送通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.topic.top_cmt = self.savedTopcmt;
    self.topic.cellHeight = 0;
}

#pragma mark - 监听
- (void)keyboardwillChangeFrame:(NSNotification *)note
{
    //修改约束
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    self.bottomMargin.constant = screenH - keyboardY;

    //执行动画
    CGFloat keyboardTime = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:keyboardTime animations:^{
        
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 加载数据
- (void)loadNewComment
{
    //取消所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"hot"] = @1;
    

    //发送请求
    __weak typeof(self) weakSelf = self;
    [self.manager GET:ZYCBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //没有评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            //让[刷新控件]结束刷新
            [self.tableView.mj_header endRefreshing];
            return;
        }
        
        //字典数组 --> 模型数组
        weakSelf.lastestComment = [ZYCComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.hotestComment = [ZYCComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //刷新表格
        [weakSelf.tableView reloadData];
        
        //让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        
        int total = [responseObject[@"total"] intValue];
        if (weakSelf.lastestComment.count == total) {  //全部加载完毕
            //隐藏
            weakSelf.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        NSLog(@"%@",error);
        
    }];
}

- (void)loadMoreComment
{
    //取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"lastcid"] = self.lastestComment.lastObject.ID;
    
    //发送请求
    __weak typeof(self) weakSelf = self;
    [self.manager GET:ZYCBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_footer endRefreshing];
        }
        
        //字典数组 --> 模型数组
        NSArray *moreComment = [ZYCComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.lastestComment addObjectsFromArray:moreComment];
        
        //刷新表格
        [weakSelf.tableView reloadData];
        
        int titoal = [responseObject[@"titosl"] intValue];
        if (weakSelf.lastestComment.count == titoal) {  //全部加载完毕
            weakSelf.tableView.mj_footer.hidden = YES;  //隐藏
        }else{
            //结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 有最热评论 + 最新评论数据
    if (self.hotestComment.count) return 2;
    // 没有最热评论数据, 有最新评论数据
    if (self.lastestComment.count) return 1;
    // 没有最热评论数据, 没有最新评论数据
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotestComment.count) {
        return self.hotestComment.count;
    }
    
    //其他情况
    return self.lastestComment.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    ZYCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYCCommentCellId];
    
    if (indexPath.section == 0 && self.hotestComment.count) {
        cell.comment = self.hotestComment[indexPath.row];
        
    }else{
        cell.comment = self.lastestComment[indexPath.row];
    }
    
    return cell;
}

#pragma mark - 代理方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZYCCommentSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ZYCSectionHeaderlId];
    
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotestComment.count) {
        header.textLabel.text = @"最热评论";
    }else{
        header.textLabel.text = @"最新评论";
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
@end
