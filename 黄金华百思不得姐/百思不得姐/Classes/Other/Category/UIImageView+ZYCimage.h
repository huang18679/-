//
//  UIImageView+ZYCimage.h
//  百思不得姐
//
//  Created by zhou on 16/2/18.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DALabeledCircularProgressView;

@interface UIImageView (ZYCimage)

- (void)zyc_setDACLargeImage:(NSString *)LargeImageUrl smallImage:(NSString *)smallImageUrl placeholder:(UIImage *)placeholder progressView:(DALabeledCircularProgressView *)progressView;

- (void)zyc_setLargeImage:(NSString *)LargeImageUrl smallImage:(NSString *)smallImageUrl placeholder:(UIImage *)placeholder;
@end
