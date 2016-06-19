//
//  ZYCUse.h
//  百思不得姐
//
//  Created by zhou on 16/2/3.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCUse : NSObject

//用户名
@property (nonatomic,strong) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 m(male) f(female) */
@property (nonatomic, copy) NSString *sex;
@end
