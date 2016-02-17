//
//  NSString+XMGExtension.m
//
//
//  Created by apple on 15/8/19.
//  Copyright (c) 2015年 wzy. All rights reserved.
//

#import "NSString+ZYExtension.h"
#import "NSDate+JDMExtension.h"

@implementation NSString (XMGExtension)
- (NSInteger)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 1.先判断是否存在
    BOOL isDirectory = NO;
    BOOL exist = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    // 文件不存在
    if (exist == NO) return 0;
    
    // 2.先判断类型（文件夹\文件）
    if (isDirectory) { // 文件夹
        NSInteger size = 0;
        
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 获得文件的全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            
            // 获得属性
            NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubpath error:nil];
            // 过滤掉文件夹
            if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
            
            size += [attrs[NSFileSize] integerValue];
        }
        
        return size;
    }
    
    // 3.文件
    return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
}

- (NSString *)fileSizeString
{
    NSInteger fileSize = self.fileSize;
    CGFloat unit = 1000.0;
    
    if (fileSize >= unit * unit * unit) { // fileSize >= 1GB
        return [NSString stringWithFormat:@"%.1fGB", fileSize/(unit * unit * unit)];
    } else if (fileSize >= unit * unit) { // 1GB > fileSize >= 1MB
        return [NSString stringWithFormat:@"%.1fMB", fileSize/(unit * unit)];
    } else if (fileSize >= unit) { // 1MB > fileSize >= 1KB
        return [NSString stringWithFormat:@"%.1fKB", fileSize/ unit];
    } else { // 1KB > fileSize
        return [NSString stringWithFormat:@"%zdB", fileSize];
    }
}


+ (NSString*)setupButtonTextWithCount:(NSInteger)count headerTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    
    if (headerTitle) {
        if (count >= 10000) {
            return  [NSString stringWithFormat:@"%@%.1f万%@",headerTitle,count / 10000.0,footerTitle];
        } else if (count > 0) {
            return [NSString stringWithFormat:@"%@%zd%@", headerTitle,count,footerTitle] ;
        } else {
            return  [NSString stringWithFormat:@"%@0%@",headerTitle,footerTitle];
        }
        
    }else{
        if (count >= 10000) {
            return  [NSString stringWithFormat:@"%.1f万%@",count / 10000.0,footerTitle];
        } else if (count > 0) {
            return [NSString stringWithFormat:@"%zd%@",count,footerTitle] ;
        } else {
            return  [NSString stringWithFormat:@"0%@",footerTitle];
        }
    }
}


- (NSString *)create_time
{
    // 创建1次formatter
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    
    // 获得日期对象
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [formatter dateFromString:self];
    
    // 获得createDate和当前时间的差值
    NSDateComponents *cmps = createDate.intervalToNow;
    
    // 根据日期对象返回对应的时间字符串
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            if (cmps.hour >= 1) { // interval >= 1小时  xx小时前
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > interval >= 1分钟  xx分钟前
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > interval  刚刚
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天 HH:mm:ss
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:createDate];
        } else { // MM-dd HH:mm:ss
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:createDate];
        }
    } else { // yyyy-MM-dd HH:mm:ss
        return self;
    }
}

@end
