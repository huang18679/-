//
//  ZYCTopice.h
//  百思不得姐
//
//  Created by zhou on 16/1/29.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZYCComment;

typedef enum {
    //全部
    ZYCTopicTypeAll = 1,
    //图片
    ZYCTopicTypePicture = 10,
    //视频
    ZYCTopicTypeVideo = 41,
    //声音
    ZYCTopicTypeVoice = 31,
    //文字
    ZYCTopicTypeWord = 29

} ZYCTopicType;

@interface ZYCTopice : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 用户的名字 */
@property (nonatomic,copy) NSString *name;
/** 用户的头像 */
@property (nonatomic,copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic,copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic,copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic,assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic,assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic,assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic,assign) NSInteger comment;
//最热评论
@property (nonatomic,strong) ZYCComment *top_cmt;
//图片的真实宽度
@property (nonatomic,assign) CGFloat width;
//图片的真实高度
@property (nonatomic,assign) CGFloat height;

/** 播放数量 */
@property (nonatomic,assign) NSInteger playcount;
/** 声音文件播放时长 */
@property (nonatomic,assign) NSInteger voicetime;
/** 视频文件播放时长 */
@property (nonatomic,assign) NSInteger videotime;

/** 视频文件 */
@property (nonatomic,strong) NSString *videouri;

/**小图 */
@property (nonatomic,copy) NSString *image0;
/** 大图 */
@property (nonatomic,copy) NSString *image1;
/** 中图 */
@property (nonatomic,copy) NSString *image2;
/** 是否为动态图 */
@property (nonatomic,assign) BOOL is_gif;
//添加方法
/** 通过这个模型计算出来的cell高度 */
@property (nonatomic,assign) CGFloat cellHeight;
/** 中间人内容的frame */
@property (nonatomic,assign) CGRect cententFame;

//是否为长图
@property (nonatomic,assign ,getter=isBigPicture) BOOL bigpicture;
/** 帖子类型*/
@property (nonatomic,assign) ZYCTopicType type;

@end
