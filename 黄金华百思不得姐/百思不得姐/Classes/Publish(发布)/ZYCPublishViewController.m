//
//  ZYCPublishViewController.m
//  百思不得姐
//
//  Created by zhou on 16/1/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCPublishViewController.h"
#import "ZYCPublishButton.h"
#import <POP.h>

@interface ZYCPublishViewController ()

//标题
@property (nonatomic,weak) UIImageView *sloganView;
//按钮
@property (nonatomic,strong) NSMutableArray *buttons;
//动画时间
@property (nonatomic,strong) NSArray *times;

@end

@implementation ZYCPublishViewController

#pragma mark - 懒加载
- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSArray *)times
{
    if (!_times) {
        CGFloat interval = 0.1; //时间间隔
        _times = @[
                   @(5 * interval),
                   @(4 * interval),
                   @(3 * interval),
                   @(2 * interval),
                   @(1 * interval),
                   @(0 * interval),
                   @(6 * interval)  //标题动画时间
                   ];
        
    } 
    return _times;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 按钮
    [self setupButtons];

    //标题
    [self setupSloganView];
}

#pragma mark - 设置按钮
- (void)setupButtons
{
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //参数
    NSInteger count = images.count;
    NSInteger colsCount = 3;
    NSUInteger rowsCount = (count + colsCount - 1) / colsCount;
    
    //按钮的尺寸
    CGFloat buttonW = ZYCScreenW / colsCount;
    CGFloat buttonH = buttonW * 0.85;
    CGFloat buttonSY = (ZYCScreenH - rowsCount * buttonH) * 0.5;
    
    for (NSInteger i = 0; i < count; i++) {
        
        ZYCPublishButton *publishBut = [ZYCPublishButton buttonWithType:UIButtonTypeCustom];
        publishBut.zyc_width = -1;
        [publishBut addTarget:self action:@selector(publishButClick) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:publishBut];
        [self.view addSubview:publishBut];
        
        //内容
        [publishBut setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [publishBut setTitle:titles[i] forState:UIControlStateNormal];
        
        //frame
        CGFloat buttonX = (i % colsCount) * buttonW;
        CGFloat buttonY = buttonSY + (i / colsCount) * buttonH;
        
        //动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY - ZYCScreenH, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        
        anim.springSpeed = ZYCMargin;
        anim.springBounciness = ZYCMargin;
        // CACurrentMediaTime()获得的是当前时间
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [publishBut pop_addAnimation:anim forKey:nil];
        
    }
}

#pragma mark - 设置标题
- (void)setupSloganView
{
    CGFloat sloganY = ZYCScreenH * 0.2;
    
    UIImageView *slogView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    slogView.zyc_y = sloganY - ZYCScreenH;
    slogView.zyc_centX = ZYCScreenW * 0.5;
    [self.view addSubview:slogView];
    self.sloganView = slogView;
    
    //动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(sloganY);
    anim.springSpeed = ZYCMargin;
    anim.springBounciness = ZYCMargin;
    
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //开始交互
        self.view.userInteractionEnabled = YES;
        
    }];
    [slogView pop_addAnimation:anim forKey:nil];
}

#pragma mark - 退出动画
- (void)exit:(void(^)())task
{
    //禁止交互
    self.view.userInteractionEnabled = YES;
    
    //让按钮执行动画
    for (NSInteger i = 0; i< self.buttons.count; i++) {
        
        ZYCPublishButton *publishBut = self.buttons[i];
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        
        anim.toValue = @(publishBut.layer.position.y + ZYCScreenH);
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        
        [publishBut.layer pop_addAnimation:anim forKey:nil];
    }
    
    //标题执行动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    anim.toValue = @(self.sloganView.layer.position.y + ZYCScreenH);
    
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL fisinhed) {
        [self dismissViewControllerAnimated:NO completion:nil];
        
        !task ? : task();
        
    }];
    [self.sloganView.layer pop_addAnimation:anim forKey:nil];
}
- (IBAction)cancel {
    
    [self exit:nil];
}

- (void)publishButClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
