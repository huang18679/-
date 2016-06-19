//
//  ZYCComment.h
//  百思不得姐
//
//  Created by zhou on 16/2/3.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZYCUse;

@interface ZYCComment : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
//内容
@property (nonatomic,copy) NSString *content;

//用户
@property (nonatomic,strong) ZYCUse *user;
/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
@end
