//
//  JDMSettingItem.m
//  JDM 
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 JDM. All rights reserved.
//  

#import "JDMSettingItem.h"

@implementation JDMSettingItem

+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title
{
    JDMSettingItem *item = [[self alloc] init];
    
    item.image = image;
    item.title = title;
    
    return item;
}



@end
