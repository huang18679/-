//
//  ZYCEssenceViewController.m
//  百思不得姐
//
//  Created by zhou on 16/1/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCEssenceViewController.h"
#import "ZYCTilteButton.h"
#import "ZYCAllController.h"
#import "ZYCVideoController.h"
#import "ZYCVoiceController.h"
#import "ZYCPictureTableViewController.h"
#import "ZYCWordController.h"

@interface ZYCEssenceViewController () <UIScrollViewDelegate>
//标题栏的view
@property (nonatomic,weak) UIView *titleView;
//上一次选中的按钮
@property (nonatomic,weak) ZYCTilteButton *selButton;
//下划线
@property (nonatomic,weak) UIView *LineView;
//UIScrollView
@property (nonatomic,weak) UIScrollView *scrollView;
@end

@implementation ZYCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = ZYCColor(256, 256, 256);
    
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    //设置导航条内容
    [self setupClickNavigationItem];
    
    //添加ScrollerView
    [self setupScrollerView];
    
    //添加标题栏
    [self setupTilteView];
    
    //添加子控制器
    [self setupChildViewController];
    //默认选中第一个
    [self addchildViewControllerInScrollView:0];
}

#pragma mark - 添加子控制器
- (void)setupChildViewController
{
    //全部
    [self addChildViewController:[[ZYCAllController alloc] init]];
    //视频
    [self addChildViewController:[[ZYCVideoController alloc] init]];
    //声音
    [self addChildViewController:[[ZYCVoiceController alloc] init]];
    //图片
    [self addChildViewController:[[ZYCPictureTableViewController alloc] init]];
    //段子
    [self addChildViewController:[[ZYCWordController alloc] init]];
    
    NSInteger count = self.childViewControllers.count;
//    for (NSInteger i = 0; i < count; i++) {
//        UIViewController *childVc = self.childViewControllers[i];
//        childVc.view.zyc_x = i * self.scrollView.zyc_width;
//        childVc.view.zyc_y = 0;
//        childVc.view.zyc_height = self.scrollView.zyc_height;
//        [self.scrollView addSubview:childVc.view];
//    }
    
    //设置scrollview
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.zyc_width, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    //不要自动调节内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 添加scrollerView
- (void)setupScrollerView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.delegate = self;
}

#pragma mark - 添加标题栏
- (void)setupTilteView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, ZYCNavMaxY, self.view.zyc_width, ZYCTitlesViewH);
    titleView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    //添加标题按钮
    [self setupTitleButtonClick];
    //添加下划线
    [self setupunderLine];

}

#pragma mark - 设置标题栏按钮
- (void)setupTitleButtonClick
{
    NSArray *titleArrs = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSInteger count = titleArrs.count;
    
    CGFloat w = self.titleView.zyc_width / count;
    CGFloat h = self.titleView.zyc_height;
    
    for (NSInteger i = 0; i < count; i++) {
        
        ZYCTilteButton *titleBut = [ZYCTilteButton buttonWithType:UIButtonTypeCustom];
        titleBut.tag = i;
        [titleBut setTitle:titleArrs[i] forState:UIControlStateNormal];
        [titleBut setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleBut setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [titleBut addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
        titleBut.frame = CGRectMake(i * w, 0, w, h);
        [self.titleView addSubview:titleBut];
    }
}

#pragma mark - 标题按钮的点击事件
- (void)titleButtonClick:(ZYCTilteButton *)but
{
    //重复点击标题按钮
    if (self.selButton == but) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ZYCTitleButtonDidRepeatClickNotification object:nil];
    }
    
    //处理标题按钮,下划线,scrollview
    [self dealTitleButtonClick:but];
}

//处理下划线.标题按钮,scrollview
- (void)dealTitleButtonClick:(ZYCTilteButton *)titlebutton
{
    //切换按钮状态
    self.selButton.selected = NO;
    titlebutton.selected = YES;
    self.selButton = titlebutton;
    
    NSInteger index = titlebutton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        //下划线
        self.LineView.zyc_width = titlebutton.titleLabel.zyc_width;
        self.LineView.zyc_centX = titlebutton.zyc_centX;
        
        //计算偏移量
        CGFloat offset = titlebutton.tag * self.scrollView.zyc_width;
        self.scrollView.contentOffset = CGPointMake(offset, self.scrollView.zyc_y);
        
    }completion:^(BOOL finished) {
        //添加子控制的view到scrollView上
        [self addchildViewControllerInScrollView:index];
    }];

}

#pragma mark - 设置下划线
- (void)setupunderLine
{
    //标题按钮
    ZYCTilteButton *firstTitleBut = self.titleView.subviews.firstObject;
    
    UIView *lineView = [[UIView alloc] init];
    CGFloat underLineH = 2;
    lineView.frame = CGRectMake(0, self.titleView.zyc_height - underLineH, 100, underLineH);
    lineView.backgroundColor = [firstTitleBut titleColorForState:UIControlStateSelected];
    
    [self.titleView addSubview:lineView];
    self.LineView = lineView;
    
    //设置默认选中第一个按钮
    firstTitleBut.selected = YES;
    self.selButton = firstTitleBut;
    
    //设置下划线的位置和长度
    [firstTitleBut.titleLabel sizeToFit];
    lineView.zyc_width = firstTitleBut.titleLabel.zyc_width;
    lineView.zyc_centX = firstTitleBut.zyc_centX;
    
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //按钮索引
    NSInteger index = scrollView.contentOffset.x / scrollView.zyc_width;
    
    ZYCTilteButton *titleBut = self.titleView.subviews[index];
    
    //选中按钮
    [self dealTitleButtonClick:titleBut];
    [self addchildViewControllerInScrollView:index];
}

-(void)addchildViewControllerInScrollView:(NSInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    
    if (childVc.isViewLoaded) return;
    
    childVc.view.zyc_x = index * self.scrollView.zyc_width;
    childVc.view.zyc_y = 0;
    childVc.view.zyc_height = self.scrollView.zyc_height;
    [self.scrollView addSubview:childVc.view];

}

#pragma mark - 设置导航条内容
- (void)setupClickNavigationItem
{
    //左边的barbuttonitem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highimage:[UIImage imageNamed:@"nav_item_game_click_icon"] addTarget:self action:@selector(leftClick)];
    
    //右边飞barbuttonitem
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highimage:[UIImage imageNamed:@"navigationButtonRandomClick"] addTarget:self action:@selector(rightClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}


#pragma mark - 监听导航栏按钮监听
- (void)leftClick
{

}
- (void)rightClick
{

}
@end
