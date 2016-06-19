//
//  ZYCCommentCell.h
//  百思不得姐
//
//  Created by zhou on 16/2/22.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYCComment;

@interface ZYCCommentCell : UITableViewCell

//评论模型数据
@property (nonatomic,strong) ZYCComment *comment;
@end
