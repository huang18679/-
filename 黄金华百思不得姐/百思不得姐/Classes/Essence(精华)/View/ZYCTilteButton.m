//
//  ZYCTilteButton.m
//  百思不得姐
//
//  Created by zhou on 16/1/26.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCTilteButton.h"

@implementation ZYCTilteButton

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
}
@end
