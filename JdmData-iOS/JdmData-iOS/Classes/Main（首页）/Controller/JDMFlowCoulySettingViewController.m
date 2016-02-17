//
//  JDMFlowCoulySettingViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMFlowCoulySettingViewController.h"

@interface JDMFlowCoulySettingViewController ()

@end

@implementation JDMFlowCoulySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpGroup0];
    [self setUpGroup1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
// 添加第0组
- (void)setUpGroup0
{
    
    JDMSettingSwitchItem *item = [JDMSettingSwitchItem itemWithImage:nil title:@"到期提醒"];
//    item.AccessoryViewType = AccessoryViewTypeSwitch;
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item]];
    group.footerTitle = @"每月1日将提醒您泵月带起但未使用的流量卷";
    [self.groups addObject:group];
    
    
}
// 添加第0组
- (void)setUpGroup1
{
    
    JDMSettingSwitchItem *item = [JDMSettingSwitchItem itemWithImage:nil title:@"自动兑换"];
//     item.AccessoryViewType = AccessoryViewTypeSwitch;
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item]];
    group.footerTitle = @"开启后,所有剩余的未使用的流量卷将在过期当月5日自动为您兑换成手机流量";
    [self.groups addObject:group];
    
    
}

@end
