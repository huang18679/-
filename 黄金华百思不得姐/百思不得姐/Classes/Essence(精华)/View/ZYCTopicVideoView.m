//
//  ZYCTopicVideoView.m
//  百思不得姐
//
//  Created by zhou on 16/2/14.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCTopicVideoView.h"
#import "ZYCTopice.h"
#import "ZYCSeeBigViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ZYCComment.h"

@interface ZYCTopicVideoView () <AVPlayerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *PlayButton;

@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerViewController *PlayerViewController;

@end

@implementation ZYCTopicVideoView

- (AVPlayer *)player
{
    if (_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;

    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
    
    [self.PlayButton addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchDown];
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
    
    //播放数量
    if (topic.playcount >= 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万播放",topic.playcount / 10000.0];
    }else{
        self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    }

    //时长
    NSInteger minutes = topic.videotime / 60;
    NSInteger seconds = topic.videotime % 60;
    
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minutes,seconds];
    
    NSURL *url = [NSURL URLWithString:topic.videouri];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    
    [self.PlayerViewController.player replaceCurrentItemWithPlayerItem:item];

    
}

- (void)playButtonClick
{
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.PlayerViewController animated:YES completion:nil];
    
}


- (AVPlayerViewController *)PlayerViewController{
    if (_PlayerViewController == nil) {
        
        NSURL *url = [NSURL URLWithString:_topic.videouri];
        _player = [AVPlayer playerWithURL:url];
        
        _PlayerViewController = [[AVPlayerViewController alloc] init];
        
        _PlayerViewController.player = _player;
        
        
    }
    
    
    return _PlayerViewController;
}


@end
