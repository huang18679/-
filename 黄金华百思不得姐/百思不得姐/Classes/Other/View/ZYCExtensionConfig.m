//
//  ZYCExtensionConfig.m
//  百思不得姐
//
//  Created by zhou on 16/2/25.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCExtensionConfig.h"
#import <MJExtension.h>
#import "ZYCTopice.h"
#import "ZYCComment.h"

@implementation ZYCExtensionConfig

+(void)load
{
    [ZYCTopice mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1"
                 };
        
    }];
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];

}

@end
