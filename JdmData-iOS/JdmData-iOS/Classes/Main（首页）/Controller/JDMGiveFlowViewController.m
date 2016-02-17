//
//  JDMGiveFlowViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMGiveFlowViewController.h"
#import "JDMAddressListFlowViewController.h"
#import "JDMForHelpViewController.h"

@interface JDMGiveFlowViewController ()

@end

@implementation JDMGiveFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setUpGroup0];
  
}

-(void)setupNav
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"记录" style:UIBarButtonItemStylePlain target:self action:@selector(clickHistoryButton)];
    self.title = @"求助";
}
// 添加第0组
- (void)setUpGroup0
{
    
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"traffic_icon_xtxlqz"]title:@"向通讯录好友转增"];
    item.descVc = [JDMAddressListFlowViewController class];
  
    
    
    JDMSettingArrowItem *item1 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"traffic_icon_xshjqz"] title:@"转到自定义手机"];
    item1.descVc = [JDMForHelpViewController class];
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item,item1]];
    
    [self.groups addObject:group];
    
    
}

-(void)clickHistoryButton
{
    JDMLogFunc;
}
@end
