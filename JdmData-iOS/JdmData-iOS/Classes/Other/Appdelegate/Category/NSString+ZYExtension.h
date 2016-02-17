//
//  NSString+XMGExtension.h
//
//
//  Created by apple on 15/8/19.
//  Copyright (c) 2015年 wzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZYExtension)
- (NSInteger)fileSize;
/**
 *  获得文件大小（18.7GB\10.9MB）
 *
 *  @return 获得字符串形式的文件大小
 */
- (NSString *)fileSizeString;
/** 一万以上显示多少万,*/
+ (NSString*)setupButtonTextWithCount:(NSInteger)count headerTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;
/** 判断时间*/
- (NSString *)create_time;
@end
