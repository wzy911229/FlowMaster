//
//  JDMNews.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/28.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMNews.h"

@implementation JDMNews
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id",
             @"typeName" :@"typename"
             };
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self= [super init]) {
    
        _author = [aDecoder decodeObjectForKey:@"author"];
        _hitcount = [aDecoder decodeIntegerForKey:@"hitcount"];
           _praisecount = [aDecoder decodeIntegerForKey:@"praisecount"];
        _source = [aDecoder decodeObjectForKey:@"source"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _typeName = [aDecoder decodeObjectForKey:@"typeName"];
        _uuid = [aDecoder decodeObjectForKey:@"uuid"];
        _createtime = [aDecoder decodeObjectForKey:@"createtime"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:_praisecount forKey:@"praisecount"];
    [aCoder encodeObject:_author forKey:@"author"];
    [aCoder encodeInteger:_hitcount forKey:@"hitcount"];
    [aCoder encodeObject:_source forKey:@"source"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_typeName forKey:@"typeName"];
    [aCoder encodeObject:_uuid forKey:@"uuid"];
    [aCoder encodeObject:_createtime forKey:@"createtime"];

}
@end
