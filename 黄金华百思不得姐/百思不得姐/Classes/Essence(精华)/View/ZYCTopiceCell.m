//
//  ZYCTopiceCell.m
//  百思不得姐
//
//  Created by zhou on 16/1/29.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCTopiceCell.h"
#import "ZYCTopice.h"
#import "ZYCUse.h"
#import "ZYCComment.h"
#import "ZYCTopicPictureView.h"
#import "ZYCTopicVideoView.h"
#import "ZYCTopicVoiceView.h"

@interface ZYCTopiceCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
//** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

/**中间控件*/
/**图片控件*/
@property (nonatomic,weak) ZYCTopicPictureView *pictureView;
/**声音控件*/
@property (nonatomic,weak) ZYCTopicVoiceView *voiceView;
/**视频控件*/
@property (nonatomic,weak) ZYCTopicVideoView *videoView;

@end

@implementation ZYCTopiceCell

#pragma mark - 懒加载
- (ZYCTopicPictureView *)pictureView
{
    if (!_pictureView) {
        ZYCTopicPictureView *pictureView = [ZYCTopicPictureView zyc_viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (ZYCTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        ZYCTopicVoiceView *voiceView = [ZYCTopicVoiceView zyc_viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (ZYCTopicVideoView *)videoView
{
    if (!_videoView) {
        ZYCTopicVideoView *videoView = [ZYCTopicVideoView zyc_viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

//初始化
- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];

}

- (void)setTopic:(ZYCTopice *)topic
{
    _topic = topic;
    
    //头像
    [self.profileImageView zyc_setHeader:topic.profile_image];
    
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_Label.text = topic.text;
    
    //设置日期
    [self setupCreatedAt];
    
    [self setupButton:self.dingButton number:topic.ding];
    [self setupButton:self.caiButton number:topic.cai];
    [self setupButton:self.repostButton number:topic.repost];
    [self setupButton:self.commentButton number:topic.comment];
    
    //最热评论
  //  NSDictionary *dict = topic.top_cmt.firstObject;
    
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        
        NSString *userName = topic.top_cmt.user.username;
        NSString *content = topic.top_cmt.content;
        
        if (topic.top_cmt.voiceuri.length) {
            content = @"[语音评论]";
        }
        
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",userName ,content];
    }else{  //没有
        self.topCmtView.hidden = YES;
    }
    
    //中间内容
    if (topic.type == ZYCTopicTypePicture) {  //图片
        
        self.pictureView.hidden = NO;
        self.pictureView.topice = topic;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
    }else if (topic.type == ZYCTopicTypeVoice){  //声音
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        
    }else if (topic.type == ZYCTopicTypeVideo){  //视频
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }else if (topic.type == ZYCTopicTypeWord){  //段子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
}


#pragma mark - 重写
- (void)setFrame:(CGRect)frame
{
    frame.size.height -=ZYCMargin;
    
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_topic.type == ZYCTopicTypePicture) {
        self.pictureView.frame = self.topic.cententFame;
        
    }else if (_topic.type == ZYCTopicTypeVoice){
        self.voiceView.frame = self.topic.cententFame;
        
    }else if (_topic.type == ZYCTopicTypeVideo){
        self.videoView.frame = self.topic.cententFame;
    }

}

- (void)setupButton:(UIButton *)button number:(NSInteger)number
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }
}

//设置日期
- (void)setupCreatedAt
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt dateFromString:self.topic.created_at];

    if (createdAtDate.zyc_isInThisYear) { //今年
        if (createdAtDate.zyc_isInYesterday) {  //昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            self.createdAtLabel.text = [fmt stringFromDate:createdAtDate];
            
        }else if (createdAtDate.zyc_isInToday){  //今天
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [[NSCalendar zyc_calendar] components:unit fromDate:createdAtDate toDate:[NSDate date] options:0];
            
            if (cmps.hour >= 1) {   //时间间隔 >= 1小时
                self.createdAtLabel.text = [NSString stringWithFormat:@"%zd小时前",cmps.hour];
                
            }else if (cmps.minute >= 1){    //1小时 >= 时间间隔 >= 1分钟
                self.createdAtLabel.text = [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
                
            }else{  //时间间隔小于一分钟
                self.createdAtLabel.text = @"刚刚";
            }
            
        }else { //除今天之外
            fmt.dateFormat = @"MMdd HH:mm:ss";
            self.createdAtLabel.text = [fmt stringFromDate:createdAtDate];
        }
        
    }else { //非今年
        self.createdAtLabel.text = self.topic.created_at;
    }
    
}

@end
