//
//  ZYCPublishButton.m
//  百思不得姐
//
//  Created by zhou on 16/2/26.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCPublishButton.h"

@implementation ZYCPublishButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.zyc_y = 0;
    self.imageView.zyc_centX = self.zyc_width * 0.5;
    
    self.titleLabel.zyc_width = self.zyc_width;
    self.titleLabel.zyc_y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.zyc_x = 0;
    self.titleLabel.zyc_height = self.zyc_height - self.titleLabel.zyc_y;
}
@end
