//
//  ZYCCommentCell.m
//  百思不得姐
//
//  Created by zhou on 16/2/22.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCCommentCell.h"
#import "ZYCUse.h"
#import "ZYCComment.h"

@interface ZYCCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;


@end

@implementation ZYCCommentCell

- (void)awakeFromNib {
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setComment:(ZYCComment *)comment
{
    _comment = comment;
    
    self.usernameLabel.text = comment.user.username;
    self.contentLabel.text = comment.content;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    [self.profileImageView zyc_setHeader:comment.user.profile_image];
    
    NSString *seximageName = [comment.user.sex isEqualToString:ZYCUserSexMale] ? @"Profile_manIcon" : @"Profile_womanIcon";

    self.sexView.image = [UIImage imageNamed:seximageName];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
        
    }else{
        self.voiceButton.hidden = YES;
    }
}

@end
