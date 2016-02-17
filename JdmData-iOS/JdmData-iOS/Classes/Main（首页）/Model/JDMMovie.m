//
//  JDMMovie.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/2.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMovie.h"

@implementation JDMMovie
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id",
             };
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self= [super init]) {
        
        _listimgurl = [aDecoder decodeObjectForKey:@"listimgurl"];
        _playcount = [aDecoder decodeIntegerForKey:@"playcount"];
        _createtime = [aDecoder decodeObjectForKey:@"createtime"];
        _videourl = [aDecoder decodeObjectForKey:@"videourl"];
        _name = [aDecoder decodeObjectForKey:@"name"];
        _info = [aDecoder decodeObjectForKey:@"info"];
        _homeimgurl = [aDecoder decodeObjectForKey:@"homeimgurl"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_listimgurl forKey:@"listimgurl"];
    [aCoder encodeInteger:_playcount forKey:@"playcount"];
    [aCoder encodeObject:_createtime forKey:@"createtime"];
    [aCoder encodeObject:_videourl forKey:@"videourl"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_info forKey:@"info"];
    [aCoder encodeObject:_homeimgurl forKey:@"homeimgurl"];
}
@end
