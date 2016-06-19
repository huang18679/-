//
//  ZYCVideoController.m
//  百思不得姐
//
//  Created by zhou on 16/1/26.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCVideoController.h"

@interface ZYCVideoController ()

@end

@implementation ZYCVideoController

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(ZYCTitlesViewH + ZYCNavMaxY, 0, ZYCTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabbarButtonDidRepeatClick) name:ZYCTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:ZYCTitleButtonDidRepeatClickNotification object:nil];
}

#pragma mark - 实现监听方法
- (void)tabbarButtonDidRepeatClick
{
    //判断当前控制器的view是否在window上
    if (self.view.window == nil) return;
    
    //判断当期view是否和window重叠,
    if (![self.view zyc_intersectWithView:nil]) return;
    
    NSLog(@"qqqqqq");
}

- (void)titleButtonDidRepeatClick
{
    [self tabbarButtonDidRepeatClick];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static UIColor *bgColor = nil;
    if (!bgColor) {
        bgColor = ZYCRandomColor;
    }
    static NSString * const ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = bgColor;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%zd",[self class], indexPath.row];
    return cell;
}
 */
- (ZYCTopicType)type
{
    return ZYCTopicTypeVideo;
}


@end
