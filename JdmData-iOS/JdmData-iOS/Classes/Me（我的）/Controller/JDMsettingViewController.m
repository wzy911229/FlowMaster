//
//  JDMsettingViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/16.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMsettingViewController.h"
#import "JDMRemindViewController.h"
#import "JDMFlowSetViewController.h"
#import "JDMAboutViewController.h"
#import "NSString+ZYExtension.h"
#import "JDMSwitchStatus.h"

@interface JDMsettingViewController ()

@end

@implementation JDMsettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];
    [self setUpGroup3];
    [self setUpGroup4];
    
}

// 添加第0组
- (void)setUpGroup0
{
    
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:nil title:nil];
    item.isClearCacheCell = YES;
    JDMGroupItem *groupArray = [JDMGroupItem groupWithItems:@[item]];
    
    [self.groups addObject:groupArray];
    
}
// 添加第0组
- (void)setUpGroup1
{
    
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:nil title:@"提醒设置"];
    item.descVc = [JDMRemindViewController class];

    JDMGroupItem *groupArray = [JDMGroupItem groupWithItems:@[item]];

    [self.groups addObject:groupArray];
    
}
// 添加第0组
- (void)setUpGroup2
{
    
    JDMSettingArrowItem *item1 = [JDMSettingArrowItem itemWithImage:nil title:@"流量监控设置"];
    item1.descVc = [JDMFlowSetViewController class];
    
    
    JDMGroupItem *groupArray = [JDMGroupItem groupWithItems:@[item1]];
    
    
    [self.groups addObject:groupArray];
    
}// 添加第0组

- (void)setUpGroup3
{
    JDMSettingArrowItem *item2 = [JDMSettingArrowItem itemWithImage:nil title:@"关于"];
    item2.descVc = [JDMAboutViewController class];
    
    JDMGroupItem *groupArray = [JDMGroupItem groupWithItems:@[item2]];
    
    [self.groups addObject:groupArray];
    
}
// 添加第0组
- (void)setUpGroup4
{
    JDMSettingSwitchItem *item = [JDMSettingSwitchItem itemWithImage:nil title:@"是否打开流量控制"];
    item.isOpen = [JDMSwitchStatus getFlowMangerSwitch];
    
    [item setDoSomethingWhenSwitchOpen:^(UISwitch * switchView) {
       [JDMSwitchStatus saveFlowMangerSwitch:switchView.on];
        
    }];
    JDMGroupItem *groupArray = [JDMGroupItem groupWithItems:@[item]];
    [self.groups addObject:groupArray];
    
}


@end
