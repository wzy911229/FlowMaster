//
//  JDMexchangeViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMexchangeViewController.h"

@interface JDMexchangeViewController ()

@end

@implementation JDMexchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpGroup0];
    self.tableView.sectionHeaderHeight =10;
}

// 添加第0组
- (void)setUpGroup0
{
    
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"traffic_icon_dll"]title:@"兑流量"];
    item.descVc = [UIViewController class];
    
    
    JDMSettingArrowItem *item1 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"traffic_icon_chf"] title:@"兑话费"];
    item1.descVc = [UIViewController class];
    
    JDMSettingArrowItem *item2 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"traffic_icon_dhwllk"]title:@"兑海外流量卡"];
    item2.descVc = [UIViewController class];
    
    JDMSettingArrowItem *item3 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"traffic_icon_dwifi"]title:@"兑Wifi上网时长"];
    item3.descVc = [UIViewController class];
    
    JDMSettingArrowItem *item4 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"traffic_icon_lltqm"]title:@"流量提取码"];
    item4.descVc = [UIViewController class];
    
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item,item1,item2,item3,item4]];
    
    [self.groups addObject:group];
    
    
}

@end
