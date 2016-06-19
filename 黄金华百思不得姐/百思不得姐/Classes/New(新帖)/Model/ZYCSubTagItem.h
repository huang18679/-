//
//  ZYCSubTagItem.h
//  百思不得姐
//
//  Created by zhou on 16/1/21.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCSubTagItem : NSObject
//头像
@property (nonatomic,strong) NSString *image_list;
//标签名称
@property (nonatomic,strong) NSString *theme_name;

//订阅数
@property (nonatomic,assign) NSInteger sub_number;
@end
