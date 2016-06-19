//
//  ZYCRefreshHeader.m
//  百思不得姐
//
//  Created by zhou on 16/2/23.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCRefreshHeader.h"

@interface ZYCRefreshHeader ()


@end

@implementation ZYCRefreshHeader

//初始化
- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor purpleColor];
    self.stateLabel.textColor = [UIColor orangeColor];
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
    
}

//摆放子控件
- (void)placeSubviews
{
    [super placeSubviews];
    
    
}
@end
