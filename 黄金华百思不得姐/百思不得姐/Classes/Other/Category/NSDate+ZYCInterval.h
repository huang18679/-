//
//  NSDate+ZYCInterval.h
//  百思不得姐
//
//  Created by zhou on 16/1/31.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCInterval : NSObject

@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger hour;
@property (nonatomic,assign) NSInteger minute;
@property (nonatomic,assign) NSInteger second;

@end

@interface NSDate (ZYCInterval)

//是否为今天
- (BOOL)zyc_isInToday;

//是否为昨天
- (BOOL)zyc_isInYesterday;

//是否为今年
- (BOOL)zyc_isInThisYear;
@end
