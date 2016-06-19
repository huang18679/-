//
//  UIImageView+ZYCHeader.m
//  百思不得姐
//
//  Created by zhou on 16/1/31.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "UIImageView+ZYCHeader.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (ZYCHeader)

- (void)zyc_setHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage zyc_tailorImageName:@"defaultUserIcon"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return ;
        
        self.image = [image zyc_tailorimage];
    }];
}

@end
