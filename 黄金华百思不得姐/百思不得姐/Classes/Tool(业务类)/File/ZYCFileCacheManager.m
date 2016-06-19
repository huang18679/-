//
//  ZYCFileCacheManager.m
//  百思不得姐
//
//  Created by zhou on 16/1/23.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCFileCacheManager.h"

@implementation ZYCFileCacheManager

//清除缓存
+ (void)removeDirectoriesPath:(NSString *)directoriesPath
{
    //清空缓存,删除文件
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //判断是否是文件夹
    BOOL isDirectory;
    BOOL isExists = [manager fileExistsAtPath:directoriesPath isDirectory:&isDirectory];
    if (!isDirectory || !isExists) {
        
        //抛异常
        NSException *excp = [NSException exceptionWithName:@"乱传" reason:@"必须传入文件夹" userInfo:nil];
        [excp raise];
    }
    //获取文件夹里所有文件的路径
    NSArray *subpaths = [manager subpathsAtPath:directoriesPath];
    
    //遍历所有文件
    for (NSString *subpath in subpaths) {
        
        //拼接文件全路径
        NSString *filepath = [directoriesPath stringByAppendingPathComponent:subpath];
        
        [manager removeItemAtPath:filepath error:nil];
    }
    
}

//设置缓存
+ (void)getCacherSizeOfDirectoriesPath:(NSString *)directoriesPath completeBlock:(void (^)(NSInteger))completeblock
{
    //开启异步执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
       //创建文件管理者
        NSFileManager *manager = [NSFileManager defaultManager];
        
        //判断是否是文件夹
        BOOL isDirectory;
        BOOL isExists = [manager fileExistsAtPath:directoriesPath isDirectory:&isDirectory];
        
        if (!isDirectory || !isExists) {
            
            //抛异常
            NSException *excp = [NSException exceptionWithName:@"乱传" reason:@"必须传文件夹路径"
                userInfo:nil];
            [excp raise];
        }
        
        //获取文件夹下所有的文件的路径
        NSArray *SubPaths = [manager subpathsAtPath:directoriesPath];
        NSInteger totalSize = 0;
        
        //遍历所有文件
        for (NSString *subpath in SubPaths) {
            
            //拼接全路径
            NSString *filePaht = [directoriesPath stringByAppendingPathComponent:subpath];
            
            //判断是否是文件夹
            BOOL isDirectory;
            BOOL isExists = [manager fileExistsAtPath:filePaht isDirectory:&isDirectory];
            
            if ([filePaht containsString:@"DS"] || !isDirectory || !isExists) continue;
            
            //获取文件属性
            NSDictionary *attr = [manager attributesOfItemAtPath:filePaht error:nil];
            
            //获取文件尺寸
            NSInteger fileSize = [attr[NSFileSize] integerValue];
            
            totalSize +=fileSize;
        }
        
        //在主线程回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (completeblock) {
                completeblock(totalSize);
            }
        });
        
    });
}
@end
