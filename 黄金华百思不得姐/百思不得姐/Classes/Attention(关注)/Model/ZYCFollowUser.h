//
//  ZYCFollowUser.h
//  百思不得姐
//
//  Created by zhou on 16/3/1.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCFollowUser : NSObject
/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;
/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;
@end
