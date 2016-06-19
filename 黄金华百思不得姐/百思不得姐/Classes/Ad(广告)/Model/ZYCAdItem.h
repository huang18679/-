//
//  ZYCAdItem.h
//  百思不得姐
//
//  Created by zhou on 16/1/19.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCAdItem : NSObject

//图片的url
@property (nonatomic,strong) NSString *w_picurl;

//点击广告跳转界面
@property (nonatomic,strong) NSString *ori_curl;

@property (nonatomic,assign) CGFloat w ;
@property (nonatomic,assign) CGFloat h;


@end
