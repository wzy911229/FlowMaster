//
//  JDPlayViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/12.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMPlayViewController.h"
#import "JDMRedBagViewController.h"

@interface JDMPlayViewController ()

@end

@implementation JDMPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpGroup0];
    self.tableView.contentInset =UIEdgeInsetsMake(- 35, 0, 0, 0);
}

// 添加第0组
- (void)setUpGroup0
{ 
    
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"play_icon_redbag"]title:@"流量红包"];
    item.descVc = [JDMRedBagViewController class];
    item.subTitle = @"红包抢不完";
    item.cellStyle = UITableViewCellStyleSubtitle;
    
    
    JDMSettingArrowItem *item1 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"play_icon_cyc"] title:@"猜一猜"];
    item1.descVc = [JDMRedBagViewController class];
    item1.subTitle = @"好难 好难 谁出的题";
     item1.cellStyle = UITableViewCellStyleSubtitle;
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item,item1]];
    
    [self.groups addObject:group];
    
    
}

@end
