//
//  ZYCTopViewController.m
//  百思不得姐
//
//  Created by zhou on 16/1/27.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCTopViewController.h"

@interface ZYCTopViewController ()

//@property (nonatomic,copy) void(^statuseBlack)();
@end

@implementation ZYCTopViewController

#pragma mark - 状态栏控制
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.statuseBlack) {
        self.statuseBlack();
    }
    
    NSLog(@"222222");
}
@end
