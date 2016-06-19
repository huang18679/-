//
//  ZYCAdViewController.m
//  百思不得姐
//
//  Created by zhou on 16/1/19.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCAdViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "ZYCAdItem.h"
#import <MJExtension/MJExtension.h>
#import "ZYCTabBarController.h"

@interface ZYCAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchimageView;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (nonatomic,strong) ZYCAdItem *aditem;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;

@property (nonatomic,weak) NSTimer *time;
@end

/**
 *  基本的url: http://mobads.baidu.com/cpro/ui/mads.php
    完善URL = 基本URL + 参数
    code2 = code2
 http://mobads.baidu.com/cpro/ui/mads.php?code2=
 *
 
 text/html"
 */

@implementation ZYCAdViewController

static NSString * const code2 =@"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam";

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //启动图片
    [self setupLaunchimage];
    
    //设置请求数据
    [self loadAdData];
    
    //创建定时器
    _time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timechang) userInfo:nil repeats:YES];
    
}

//定时器.每个一秒就会调用一次
- (void)timechang
{
    static int i = 0;
    
    //设置按钮文字
    NSString *title = [NSString stringWithFormat:@"跳过 (%d)",i];
    [self.jumpButton setTitle:title forState:UIControlStateNormal];
    
    // 2.倒计时,3秒之后,停止定时器,进入主框架界面
    if (i == -1) {
        [self jump:nil];
    }
    i--;
}

#pragma mark - 请求广告数据
- (void)loadAdData
{
    //创建回话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    //发送请求
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {

        //获取广告字典
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];

        //字典转模型
        ZYCAdItem *aditem = [ZYCAdItem mj_objectWithKeyValues:adDict];
        _aditem = aditem;
        //创建广告界面
        
        if (aditem.w) {
            
            CGFloat w = ZYCScreenW;
            CGFloat h = ZYCScreenW / aditem.w * aditem.h;
            
            UIImageView *adview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
            
            [self.adView addSubview:adview];
            
            //网络中加载数据
            [adview sd_setImageWithURL:[NSURL URLWithString:aditem.w_picurl]];
            
            //添加点击事件
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
            [self.adView addGestureRecognizer:tap];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"%@",error);
        
    }];
}
- (IBAction)jump:(id)sender {
    
    [_time invalidate];
    
    //跳转到主控制器
    ZYCTabBarController *tabbar = [[ZYCTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
    
}

//加载广告网页
- (void)tap
{
    NSURL *url = [NSURL URLWithString:_aditem.ori_curl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - 启动图片
- (void)setupLaunchimage
{
    UIImage *image;
    if (iPhone4) {
        image = [UIImage imageNamed:@"LaunchImage"];
        
    }else if (iPhone5){
        image = [UIImage imageNamed:@"LaunchImage-568h"];
        
    }else if (iPhone6){
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
        
    }else if (iPhone6p){
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }
    
    _launchimageView.image = image;
}



@end
