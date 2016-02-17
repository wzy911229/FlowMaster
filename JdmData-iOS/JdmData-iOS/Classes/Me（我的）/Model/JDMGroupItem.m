//
//  JDMGroupItem.m
//  JDM 
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import "JDMGroupItem.h"

@implementation JDMGroupItem
+ (instancetype)groupWithItems:(NSArray *)items
{
    JDMGroupItem *group = [[self alloc] init];
    
    group.items = items;
    
    return group;
}
@end
