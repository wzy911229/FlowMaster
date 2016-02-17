//
//  NSDate+XMGExtension.h
//  2期-百思不得姐
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JDMExtension)
/**
 *  是否为今年
 */
- (BOOL)isThisYear;
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为明天
 */
- (BOOL)isTomorrow;

/**
 *  获得跟当前时间（now）的差值
 */
- (NSDateComponents *)intervalToNow;
@end
