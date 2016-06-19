//
//  ZYCSquareCell.m
//  百思不得姐
//
//  Created by zhou on 16/1/23.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCSquareCell.h"
#import <UIImageView+WebCache.h>
#import "ZYCSquareItem.h"

@interface ZYCSquareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation ZYCSquareCell

- (void)awakeFromNib {

}

- (void)setItem:(ZYCSquareItem *)item
{
    _item = item;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    
    _nameView.text = item.name;
}

@end
