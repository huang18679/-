//
//  ZYCTopicVoiceView.m
//  百思不得姐
//
//  Created by zhou on 16/2/14.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCTopicVoiceView.h"
#import "ZYCTopice.h"
#import "ZYCSeeBigViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZYCComment.h"

@interface ZYCTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playVoiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playerItem;


@end

@implementation ZYCTopicVoiceView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
    
    [self.playerItem addTarget:self action:@selector(playerItemClick) forControlEvents:UIControlEventTouchDown];
}

- (void)seeBig
{
    ZYCSeeBigViewController *seeBig = [[ZYCSeeBigViewController alloc] init];
    seeBig.topic = self.topic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
}

- (void)setTopic:(ZYCTopice *)topic
{
    _topic = topic;
    
    //图片
    [self.imageView zyc_setLargeImage:topic.image1 smallImage:topic.image0 placeholder:nil];
    
    //播放次数
    if (topic.playcount >= 10000) {
        self.playVoiceLabel.text = [NSString stringWithFormat:@"%.1f万次播放",topic.playcount / 10000.0];
    }else{
        self.playVoiceLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    }

    //时长
    NSInteger minutes = topic.voicetime / 60;
    NSInteger seconds = topic.voicetime % 60;
    
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minutes,seconds];
}

- (AVPlayer *)playerItemClick
{
    
    NSURL *playitemurl = [NSURL URLWithString:self.topic.top_cmt.voiceuri];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:playitemurl];
    
    AVPlayer *play = [AVPlayer playerWithPlayerItem:playerItem];
    
    NSLog(@"playitem");
    return play;
}

@end
