//
//  JDMFlowSetViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/23.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMFlowSetViewController.h"

@interface JDMFlowSetViewController ()

@end

@implementation JDMFlowSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];
    [self setUpGroup3];
    
}

// 添加第0组
- (void)setUpGroup0
{
    
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:nil title:@"流量校正"];
    item.subTitle =@"月套餐限额500M,套餐开始日为每月31日.本月已用0.00M";
    item.cellStyle = UITableViewCellStyleSubtitle;
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item]];
    group.headerTitle =@"套餐设置";

    [self.groups addObject:group];
    
    
}
// 添加第1组
- (void)setUpGroup1
{
    
    JDMSettingSwitchItem *item = [JDMSettingSwitchItem itemWithImage:nil title:@"流量使用过猛提醒"];
    item.isOpen = YES;
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item]];
    group.headerTitle =@"日超量智能提醒";
    
    [self.groups addObject:group];
    
    
}
// 添加第2组
- (void)setUpGroup2
{
    
    JDMSettingSwitchItem *item = [JDMSettingSwitchItem itemWithImage:nil title:@"余量不足20%时提醒"];
    
    
    JDMSettingSwitchItem *item1 = [JDMSettingSwitchItem itemWithImage:nil title:@"余量不足10%时提醒"];
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item,item1]];
    group.headerTitle = @"余量预警提醒";
    
    [self.groups addObject:group];
    
    
}
// 添加第3组
- (void)setUpGroup3
{
    
    JDMSettingSwitchItem *item = [JDMSettingSwitchItem itemWithImage:nil title:@"距月结日10天时提醒"];
    item.isOpen = YES;
    
    
    JDMSettingSwitchItem *item1 = [JDMSettingSwitchItem itemWithImage:nil title:@"距月结日5天时提醒"];
    item.isOpen = YES;
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item,item1]];
     group.headerTitle = @"月结前流量剩余提醒";
    [self.groups addObject:group];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (indexPath.section == 0) {
        return 55;
    }
    
    return  44;
}

@end
