//
//  JDMHelpViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/20.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMHelpViewController.h"
#import "JDMFeedbackViewController.h"
#import "JDMSoundHelpViewController.h"
#import "JDMHelpCenterViewController.h"

@interface JDMHelpViewController ()

@end

@implementation JDMHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title =@"帮助";
    [self setUpGroup0];
    [self setupGroup1];
}

// 添加第0组
- (void)setUpGroup0
{
    
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:nil title:@"帮助中心"];
    item.descVc = [JDMHelpCenterViewController class];
    
    
    JDMSettingArrowItem *item1 = [JDMSettingArrowItem itemWithImage:nil title:@"语音介绍"];
    item1.descVc = [JDMSoundHelpViewController class];
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item,item1]];
    
    [self.groups addObject:group];
    
    
}

- (void)setupGroup1
{
    
    JDMSettingArrowItem *item0 = [JDMSettingArrowItem itemWithImage:nil title:@"意见反馈"];
    item0.descVc = [JDMFeedbackViewController class];
    
    
    JDMSettingArrowItem *item1 = [JDMSettingArrowItem itemWithImage:nil title:@"在线客服"];
    item1.descVc = [UITableViewController class];
    
    
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item0,item1]];
    [self.groups addObject:group];
    
    
}

@end
