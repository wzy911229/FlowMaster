//
//  JDMRemindViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/23.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMRemindViewController.h"

@interface JDMRemindViewController ()

@end

@implementation JDMRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];
}
// 添加第0组
- (void)setUpGroup0
{
    
    JDMSettingSwitchItem *item = [JDMSettingSwitchItem itemWithImage:nil title:@"推送提醒"];
    item.isOpen = YES;

    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item]];
    
    [self.groups addObject:group];
    
    
}
// 添加第1组
- (void)setUpGroup1
{
    
    JDMSettingSwitchItem *item = [JDMSettingSwitchItem itemWithImage:nil title:@"推送活动"];
    
    
    JDMSettingSwitchItem *item1 = [JDMSettingSwitchItem itemWithImage:nil title:@"系统通知"];
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item,item1]];
    
    [self.groups addObject:group];
    
    
}
// 添加第2组
- (void)setUpGroup2
{
    
    JDMSettingSwitchItem *item = [JDMSettingSwitchItem itemWithImage:nil title:@"提示音"];
    item.isOpen = YES;
    
    
    JDMSettingSwitchItem *item1 = [JDMSettingSwitchItem itemWithImage:nil title:@"振动"];
    item.isOpen = YES;
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item,item1]];
    
    [self.groups addObject:group];
    
    
}

@end
