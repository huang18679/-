//
//  ZYCVideoPlayViewController.h
//  百思不得姐
//
//  Created by zhou on 16/2/26.
//  Copyright © 2016年 zhou. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

@class ZYCTopice;


@interface ZYCVideoPlayViewController :AVPlayerViewController

@property (nonatomic,strong) ZYCTopice *topic;
@end
