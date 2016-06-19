//
//  ZYCTopicPictureView.m
//  百思不得姐
//
//  Created by zhou on 16/2/14.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCTopicPictureView.h"
#import "ZYCTopice.h"
#import <DALabeledCircularProgressView.h>
#import "ZYCSeeBigViewController.h"

@interface ZYCTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation ZYCTopicPictureView

- (void)awakeFromNib
{

    self.progressView.roundedCorners = 5;
    self.progressView.progressTintColor = [UIColor whiteColor];
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
    
}

- (void)seeBig
{
    ZYCSeeBigViewController *seeBig = [[ZYCSeeBigViewController alloc] init];
    seeBig.topic = self.topice;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
}


- (void)setTopice:(ZYCTopice *)topice
{
    _topice = topice;
    
   //图片
    [self.imageView zyc_setDACLargeImage:topice.image1 smallImage:topice.image0 placeholder:nil progressView:_progressView];
    
    //gif
    self.gifView.hidden = !topice.is_gif;
    
    //显示大图按钮
    if (topice.bigpicture) {  //长图
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.seeBigPictureButton.hidden = YES;
        //self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = NO;
    }
}


@end
