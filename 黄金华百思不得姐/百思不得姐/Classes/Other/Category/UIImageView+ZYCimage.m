//
//  UIImageView+ZYCimage.m
//  百思不得姐
//
//  Created by zhou on 16/2/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "UIImageView+ZYCimage.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <DALabeledCircularProgressView.h>

@implementation UIImageView (ZYCimage)

- (void)zyc_setDACLargeImage:(NSString *)LargeImageUrl smallImage:(NSString *)smallImageUrl placeholder:(UIImage *)placeholder progressView:(DALabeledCircularProgressView *)progressView
{
    [self sd_setImageWithURL:[NSURL URLWithString:LargeImageUrl] placeholderImage:placeholder options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
//        receivedSize 已经接收图片的大小
//        expectedSize 图片的总大小
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        progressView.progress = progress;
        progressView.hidden = NO;
        progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        progressView.hidden = YES;
        
    }];

}

- (void)zyc_setLargeImage:(NSString *)LargeImageUrl smallImage:(NSString *)smallImageUrl placeholder:(UIImage *)placeholder
{

    [self sd_setImageWithURL:[NSURL URLWithString:LargeImageUrl] placeholderImage:placeholder];
}

@end
