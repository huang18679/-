//
//  ZYCFileCacheManager.h
//  百思不得姐
//
//  Created by zhou on 16/1/23.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCFileCacheManager : NSObject

+ (void)getCacherSizeOfDirectoriesPath:(NSString *)directoriesPath completeBlock:(void(^)(NSInteger))completeblock;

+ (void)removeDirectoriesPath:(NSString *)directoriesPath;
@end
