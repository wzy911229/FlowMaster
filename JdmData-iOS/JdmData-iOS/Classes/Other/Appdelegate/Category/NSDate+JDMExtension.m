//
//  NSDate+XMGExtension.m

//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年  All rights reserved.
//

#import "NSDate+JDMExtension.h"

@implementation NSDate (JDMExtension)

static NSDateFormatter *formatter_;
+ (void)load
{
    formatter_ = [[NSDateFormatter alloc] init];
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

//- (BOOL)isThisYear
//{
//    formatter_.dateFormat = @"yyyy";
//    
//    NSString *nowString = [formatter_ stringFromDate:[NSDate date]];
//    NSString *selfString = [formatter_ stringFromDate:self];
//    
//    return [nowString isEqualToString:selfString];
//}

/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year
    && nowCmps.month == selfCmps.month
    && nowCmps.day == selfCmps.day;
}

//- (BOOL)isToday
//{
//    formatter_.dateFormat = @"yyyy-MM-dd";
//
//    NSString *nowString = [formatter_ stringFromDate:[NSDate date]];
//    NSString *selfString = [formatter_ stringFromDate:self];
//
//    return [nowString isEqualToString:selfString];
//}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    formatter_.dateFormat = @"yyyy-MM-dd";

    // 产生只有年月日，没有时分秒的字符串
    NSString *nowString = [formatter_ stringFromDate:[NSDate date]];
    // 产生只有年月日，没有时分秒的日期
    NSDate *nowDate = [formatter_ dateFromString:nowString];
    
    // 产生只有年月日，没有时分秒的字符串
    NSString *selfString = [formatter_ stringFromDate:self];
    // 产生只有年月日，没有时分秒的日期
    NSDate *selfDate = [formatter_ dateFromString:selfString];
    
    // 获得2个日期之间的差值
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    // 2014-12-31 19:20:30 -> 2014-12-31 00:00:00
    // 2015-01-01 02:20:30 -> 2015-01-01 00:00:00
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

/**
 *  是否为明天
 */
- (BOOL)isTomorrow
{
    formatter_.dateFormat = @"yyyy-MM-dd";
    
    // 产生只有年月日，没有时分秒的字符串
    NSString *nowString = [formatter_ stringFromDate:[NSDate date]];
    // 产生只有年月日，没有时分秒的日期
    NSDate *nowDate = [formatter_ dateFromString:nowString];
    
    // 产生只有年月日，没有时分秒的字符串
    NSString *selfString = [formatter_ stringFromDate:self];
    // 产生只有年月日，没有时分秒的日期
    NSDate *selfDate = [formatter_ dateFromString:selfString];
    
    // 获得2个日期之间的差值
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    // 2014-12-31 19:20:30 -> 2014-12-31 00:00:00
    // 2015-01-01 02:20:30 -> 2015-01-01 00:00:00
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}

/**
 *  获得跟当前时间（now）的差值
 */
- (NSDateComponents *)intervalToNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}
@end
