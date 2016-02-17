//
//  JDMMyXBViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/20.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMyXBViewController.h"
#import "JDMEarnedViewController.h"
#import "JDMGiveFlowViewController.h"
#import "JDMexchangeViewController.h"

@interface JDMMyXBViewController ()

@end

@implementation JDMMyXBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpGroup0];
    [self setupGroup1];
    
    self.title=@"我的流量币";
}


// 添加第0组
- (void)setUpGroup0
{
    
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:nil title:@"赚取"];
    item.descVc = [JDMEarnedViewController class];
    
    
    JDMSettingArrowItem *item1 = [JDMSettingArrowItem itemWithImage:nil title:@"兑换"];
    item1.descVc = [JDMexchangeViewController class];
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item,item1]];
    
    [self.groups addObject:group];
    
    
}

- (void)setupGroup1
{
    
    JDMSettingArrowItem *item0 = [JDMSettingArrowItem itemWithImage:nil title:@"转赠"];
    item0.descVc = [JDMGiveFlowViewController class];
    
    
    JDMSettingArrowItem *item1 = [JDMSettingArrowItem itemWithImage:nil title:@"求助"];
    item1.descVc = [JDMGiveFlowViewController class];
    
    
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item0,item1]];
    [self.groups addObject:group];
    
    
}



@end
