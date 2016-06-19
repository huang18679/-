//
//  ZYCSeeBigViewController.m
//  百思不得姐
//
//  Created by zhou on 16/2/19.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCSeeBigViewController.h"
#import "ZYCTopice.h"
#import <UIImageView+WebCache.h>

#import <Photos/Photos.h>

#import <SVProgressHUD.h>

@interface ZYCSeeBigViewController () <UIScrollViewDelegate>

/**图片控件*/
@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation ZYCSeeBigViewController
static NSString * ZYCAssetCollectionTitle = @"zzz";


- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1]];
    [scrollView addSubview:imageView];
    
    imageView.zyc_width = scrollView.zyc_width;
    imageView.zyc_height = self.topic.height * imageView.zyc_width / self.topic.width;
    imageView.zyc_x = 0;
    
    
    if (imageView.zyc_height >= scrollView.zyc_height) {  //图片的高度大于屏幕的高度
        
        imageView.zyc_y = 0;
        //scrollView滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.zyc_height);
    }else{  //居中显示
        imageView.zyc_centY = scrollView.zyc_height * 0.5;
    }
    self.imageView = imageView;
    
    //缩放比例
    CGFloat scale = self.topic.width / imageView.zyc_width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
        
    }
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    /*
     PHAuthorizationStatusNotDetermined,     用户还没有做出选择
     PHAuthorizationStatusDenied,            用户拒绝当前应用访问相册(用户当初点击了"不允许")
     PHAuthorizationStatusAuthorized         用户允许当前应用访问相册(用户当初点击了"好")
     PHAuthorizationStatusRestricted,        因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
     */
    //判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted) {  //因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
        
        [SVProgressHUD showErrorWithStatus:@"因为系统原因,无法访问相册"];
        
    }else if (status == PHAuthorizationStatusDenied){  //用户拒绝当前应用访问相册(用户当初点击了"不允许")
        [SVProgressHUD showErrorWithStatus:@"请设置访问权限"];
        
    }else if (status == PHAuthorizationStatusAuthorized){  //用户允许当前应用访问相册(用户当初点击了"好")
        [self saveImage];
        
    }else if (status == PHAuthorizationStatusNotDetermined){  //用户还没有做出选择
        //弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) {  //用户点击了好;
                [self saveImage];
            }
        }];
    }
}


- (void)saveImage
{
    // PHAssetCollection的标识, 利用这个标识可以找到对应的PHAssetCollection对象(相簿对象)
   // __block NSString *assetCollectionLocalIdentifier = nil;
    
    // PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
    __block NSString *assetLocalIdentifier = nil;
    
    
    // 如果想对"相册"进行修改(增删改), 那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1.保存图片A到"相机胶卷"中
        // 创建图片的请求
     assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
    
        if (success == NO) {
            [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
            return ;
        }
        
        //获取相册
        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
        
        if (createdAssetCollection == nil) {  //曾经创建过相簿
          /*  [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                // 3.添加"相机胶卷"中的图片A到"相簿"D中
                
                // 获得图片
                PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
                // 添加图片到相簿中的请求
                PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
                
                //添加图片到相簿中
                [request addAssets:@[asset]];
                
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success == NO) {
                    [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
                }
            }];*/
            [SVProgressHUD showErrorWithStatus:@"创建相册失败"];
            return;
        
        }
        //没有创建过相簿
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            // 3.添加"相机胶卷"中的图片A到新建的"相簿"D中
            
            // 获得图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
            
            // 添加图片到相簿中的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
            
            // 添加图片到相簿
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            if (success == NO) {
                [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
            }else{
                [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
            }
            
        }];
        
    }];
}

/**
 *  获得相簿
 */
- (PHAssetCollection *)createdAssetCollection
{
    //获得曾经创建过的相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:ZYCAssetCollectionTitle]) {
            return assetCollection;
        }
    }
    
    //错误信息
    NSError *error = nil;
    
    // PHAssetCollection的标识, 利用这个标识可以找到对应的PHAssetCollection对象(相簿对象)
    __block NSString *assetCollectionLocalIdentifier = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //创建相册的请求
      assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:ZYCAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
        
    } error:&error];
    
    //如果有错误信息
    if (error) return nil;
    
    //获取刚才创建的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
}
@end
