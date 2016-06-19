//
//  ZYCLoginRegisterViewController.m
//  百思不得姐
//
//  Created by zhou on 16/1/20.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCLoginRegisterViewController.h"

@interface ZYCLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation ZYCLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)close {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (self.leftMargin.constant) {// 目前显示的是注册界面, 点击按钮后要切换为登录界面
        
        self.leftMargin.constant = 0;

    }else   // 目前显示的是登录界面, 点击按钮后要切换为注册界面
    {
        self.leftMargin.constant = - self.view.zyc_width;

    }
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        
        //强制刷新
        [self.view layoutIfNeeded];
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
