//
//  JDMStoreViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMStoreViewController.h"
#import "JDMGroupItem.h"
#import "JDMFlowGroupViewController.h"
#import "JDMBugXBViewController.h"
@interface JDMStoreViewController ()

@end

@implementation JDMStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupNav];
    [self setUpGroup0];
    [self setUpGroup1];
}


- (void)setUpGroup0
{
    
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"traffic_icon_redcircle"]title:@"订购流量包"];
    item.descVc = [JDMFlowGroupViewController class];
    
    
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item]];
     group.footerTitle = @"使用你的话费订购叠加包、加餐包或闲时包";
    [self.groups addObject:group];
    
    
}
- (void)setUpGroup1
{
 
    
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"traffic_icon_orangecircle"] title:@"购买流量币"];
    item.descVc = [JDMBugXBViewController class];
    
    
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item]];
    group.footerTitle = @"在线支付购买流量币,流量币可以用于兑换流量包、Wifi时长";
    
    [self.groups addObject:group];
    
    
}



@end
