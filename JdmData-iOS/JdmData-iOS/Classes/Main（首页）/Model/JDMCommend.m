//
//  JDMCommend.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/23.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMCommend.h"

@implementation JDMCommend
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id",
             };
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self= [super init]) {
        
        _imageurl = [aDecoder decodeObjectForKey:@"imageurl"];
        _readcount = [aDecoder decodeIntegerForKey:@"readcount"];
        _createtime = [aDecoder decodeObjectForKey:@"createtime"];
        _enddate = [aDecoder decodeObjectForKey:@"enddate"];
        _linkurl = [aDecoder decodeObjectForKey:@"linkurl"];
        _atname = [aDecoder decodeObjectForKey:@"atname"];
        _atitle = [aDecoder decodeObjectForKey:@"atitle"];
        _isLoadFullPath = [aDecoder decodeBoolForKey:@"isLoadFullPath"];
      
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_imageurl forKey:@"imageurl"];
    [aCoder encodeInteger:_readcount forKey:@"readcount"];
    [aCoder encodeObject:_createtime forKey:@"createtime"];
    [aCoder encodeObject:_enddate forKey:@"enddate"];
    [aCoder encodeObject:_linkurl forKey:@"linkurl"];
    [aCoder encodeObject:_atname forKey:@"atname"];
    [aCoder encodeObject:_atitle forKey:@"atitle"];
    [aCoder encodeBool:_isLoadFullPath forKey:@"isLoadFullPath"];
}
@end
