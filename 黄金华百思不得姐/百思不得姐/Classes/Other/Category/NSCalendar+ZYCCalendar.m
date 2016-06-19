//
//  NSCalendar+ZYCCalendar.m
//  百思不得姐
//
//  Created by zhou on 16/1/31.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "NSCalendar+ZYCCalendar.h"

@implementation NSCalendar (ZYCCalendar)

+ (instancetype)zyc_calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}

@end
