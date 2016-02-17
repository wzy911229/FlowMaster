//
//  JDMMsyList.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/16.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMsgList.h"

@implementation JDMMsgList
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id",
             };
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self= [super init]) {
        
        _msgtitle = [aDecoder decodeObjectForKey:@"msgtitle"];
        _msgtext = [aDecoder decodeObjectForKey:@"msgtext"];
        _createtime = [aDecoder decodeObjectForKey:@"createtime"];
        _isreadflag = [aDecoder decodeObjectForKey:@"isreadflag"];
        _msgtype = [aDecoder decodeObjectForKey:@"msgtype"];
        _platform = [aDecoder decodeObjectForKey:@"platform"];
        _uuid = [aDecoder decodeObjectForKey:@"uuid"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_msgtitle forKey:@"msgtitle"];
    [aCoder encodeObject:_msgtext forKey:@"msgtext"];
    [aCoder encodeObject:_createtime forKey:@"createtime"];
    [aCoder encodeBool:_isreadflag forKey:@"isreadflag"];
    [aCoder encodeObject:_msgtype forKey:@"msgtype"];
    [aCoder encodeObject:_platform forKey:@"platform"];
    [aCoder encodeObject:_uuid forKey:@"uuid"];
}

@end
