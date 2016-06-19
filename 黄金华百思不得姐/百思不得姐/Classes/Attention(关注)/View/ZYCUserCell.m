//
//  ZYCUserCell.m
//  百思不得姐
//
//  Created by zhou on 16/3/2.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCUserCell.h"
#import "ZYCFollowUser.h"

@interface ZYCUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end


@implementation ZYCUserCell

- (void)awakeFromNib {


}


- (void)setUser:(ZYCFollowUser *)user
{
    _user = user;
    
    [self.headerImageView zyc_setHeader:user.header];
    self.screenNameLabel.text = user.screen_name;
    
    if (user.fans_count >= 10000) {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%0.1f万人关注",user.fans_count / 10000.0];
    }else{
        self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    }
}


@end
