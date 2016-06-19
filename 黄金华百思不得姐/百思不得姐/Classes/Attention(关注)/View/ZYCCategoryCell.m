//
//  ZYCCategoryCell.m
//  百思不得姐
//
//  Created by zhou on 16/3/1.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCCategoryCell.h"
#import "ZYCFollowCategory.h"

@interface ZYCCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation ZYCCategoryCell

- (void)awakeFromNib {
    // 清除文字背景色（这样就不会挡住分割线）
    self.backgroundColor = [UIColor clearColor];
}

/**
 * 这个方法可以用来监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.textLabel.textColor = selected ? [UIColor redColor] : [UIColor darkGrayColor];
    self.selectedIndicator.hidden = !selected;
}

- (void)setCategory:(ZYCFollowCategory *)category
{
    _category = category;
    
    //设置文字
    self.textLabel.text = category.name;
}

@end
