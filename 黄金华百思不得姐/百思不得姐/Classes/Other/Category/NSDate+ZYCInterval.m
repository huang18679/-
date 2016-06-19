//
//  NSDate+ZYCInterval.m
//  百思不得姐
//
//  Created by zhou on 16/1/31.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "NSDate+ZYCInterval.h"
#import "NSCalendar+ZYCCalendar.h"

@implementation NSDate (ZYCInterval)

//是否为今天
- (BOOL)zyc_isInToday
{
    NSCalendar *calendar = [NSCalendar zyc_calendar];
    
    //获取年月日
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *selfcmps = [calendar components:unit fromDate:self];
    NSDateComponents *nowcmps = [calendar components:unit fromDate:[NSDate date]];
    
    return [selfcmps isEqual:nowcmps];
}

//是否为今年
- (BOOL)zyc_isInThisYear
{
    NSCalendar *calendar = [NSCalendar zyc_calendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear;
    
    NSDateComponents *selfcmps = [calendar components:unit fromDate:self];
    NSDateComponents *nowcmps = [calendar components:unit fromDate:[NSDate date]];
    
    return [selfcmps isEqual:nowcmps];
}

//是否为昨天
- (BOOL)zyc_isInYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    //获取年月日的字符串对象
    NSString *selfstring = [fmt stringFromDate:self];
    NSString *nowstring = [fmt stringFromDate:[NSDate date]];
    
    //获取年月日的日期对象
    NSDate *selfdate = [fmt dateFromString:selfstring];
    NSDate *nowdate = [fmt dateFromString:nowstring];
    
    //比较
    NSCalendar *calendar = [NSCalendar zyc_calendar];
    
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfdate toDate:nowdate options:0];
    
    return cmps.day == 1;
}

@end
