//
//  ZYCCommentSectionHeader.m
//  百思不得姐
//
//  Created by zhou on 16/2/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCCommentSectionHeader.h"

@implementation ZYCCommentSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor orangeColor];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 在layoutSubviews方法中覆盖对子控件的一些设置
    self.textLabel.font = ZYCCommentSectionHeaderFont;
    
    self.textLabel.zyc_x = ZYCMargin;
}
@end
