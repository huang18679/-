//
//  ZYCSettingTableController.m
//  百思不得姐
//
//  Created by zhou on 16/1/19.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCSettingTableController.h"
#import "ZYCFileCacheManager.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ZYCSettingTableController ()

@property (nonatomic,assign) NSInteger totalsize;
@end

static NSString * const ID = @"cell";

@implementation ZYCSettingTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"zzz" style:0 target:self action:@selector(ButtonClick)];
    
    self.title = @"设置";
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存..."];
    
    //获取cache的文件夹路径
    NSString *cachePaht = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    //获取缓存尺寸
    [ZYCFileCacheManager getCacherSizeOfDirectoriesPath:cachePaht completeBlock:^(NSInteger totalsize) {
        
        _totalsize = totalsize;
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    }];
    
}

#pragma mark - Tableviewdatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [self cacheStr:_totalsize];
    
    return cell;
}

//选中某行cell时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cache文件路径
    NSString *cachepath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    //真正清空缓存
    [ZYCFileCacheManager removeDirectoriesPath:cachepath];
    
    //清空数据
    _totalsize = 0;
    
    //刷新表格
    [self.tableView reloadData];
}

// 获取缓存字符串
- (NSString *)cacheStr:(NSInteger)totalSize
{
    // 获取文件夹缓存尺寸:文件夹比较小,文件夹非常大,获取尺寸比较耗时
    CGFloat cacheSizeF = 0;
    NSString *cacheStr = @"清空缓存";
    if (totalSize > (1000 * 1000)) { //MB
        cacheSizeF = totalSize / (1000 * 1000);
        cacheStr = [NSString stringWithFormat:@"清空缓存(%.1fMB)",cacheSizeF];
        cacheStr = [cacheStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (totalSize > 1000) { //KB
        cacheSizeF = totalSize / 1000;
        cacheStr = [NSString stringWithFormat:@"清空缓存(%.1fKB)",cacheSizeF];
    } else if (totalSize > 0){ // B
        cacheStr = [NSString stringWithFormat:@"清空缓存(%ldB)",totalSize];
    }
    
    return cacheStr;
}


@end
