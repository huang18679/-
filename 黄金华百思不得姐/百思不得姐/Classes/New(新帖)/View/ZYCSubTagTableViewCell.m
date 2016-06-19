//
//  ZYCSubTagTableViewCell.m
//  百思不得姐
//
//  Created by zhou on 16/1/21.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCSubTagTableViewCell.h"
#import "ZYCSubTagItem.h"

@interface ZYCSubTagTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;

@end

@implementation ZYCSubTagTableViewCell

- (void)awakeFromNib
{

}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -=1;
    
    [super setFrame:frame];
}

- (void)setItem:(ZYCSubTagItem *)item
{
    _item = item;
    
    [self.iconView zyc_setHeader:item.image_list];
    
    //名称
    self.nameView.text = item.theme_name;
    //订阅数
    CGFloat numF = 0;
    NSString *str = [NSString stringWithFormat:@"%ld人订阅",item.sub_number];
    if (item.sub_number > 10000) {
        numF = item.sub_number / 10000.0;
        str = [NSString stringWithFormat:@"%.1f万人订阅",numF];
        str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
    }
    
    self.numView.text = str;

}

@end
