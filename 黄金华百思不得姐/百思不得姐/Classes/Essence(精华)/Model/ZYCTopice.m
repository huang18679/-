//
//  ZYCTopice.m
//  百思不得姐
//
//  Created by zhou on 16/1/29.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCTopice.h"
#import "ZYCUse.h"
#import "ZYCComment.h"

@implementation ZYCTopice

- (CGFloat)cellHeight
{
    if (_cellHeight)  return _cellHeight;
    
    //头像
    _cellHeight += 55;
    
    //文字
    CGFloat textMaxW = ZYCScreenW - 2 * ZYCMargin;
    CGSize textMaxsize = CGSizeMake(textMaxW, MAXFLOAT);
    
    CGSize textsize = [self.text boundingRectWithSize:textMaxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    
    _cellHeight +=textsize.height + ZYCMargin;
    
    //中间的内容
    if (self.type != ZYCTopicTypeWord) {// 如果是图片\声音\视频帖子, 才需要计算中间内容的高度
        // 中间内容的高度 == 中间内容的宽度 * 图片的真实高度 / 图片的真实宽度
        CGFloat cententW = textMaxW;
        
        CGFloat cententH = textMaxW * self.height / self.width;
        if (cententH >= ZYCScreenH) {
            cententH = 200;
            self.bigpicture = YES;
        }
        
        //图片显示的Y
        CGFloat cententY = _cellHeight;
        //图片显示的X
        CGFloat cententX = ZYCMargin;
        //中间内容的frame
        self.cententFame = CGRectMake(cententX, cententY, cententW, cententH);
        
        _cellHeight +=cententH + ZYCMargin;
    }
    
    //最热评论
    if (_top_cmt) {
        
        //最热评论-标题
        _cellHeight +=20;
        
        NSString *topcmtContent = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username,self.top_cmt.content];
        
        CGSize topcmtContentSize = [topcmtContent boundingRectWithSize:textMaxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
        _cellHeight += topcmtContentSize.height + ZYCMargin;
        
    }
    
    //底部工具条
    _cellHeight += 35 + ZYCMargin;
    
    return _cellHeight;
    
}


@end
