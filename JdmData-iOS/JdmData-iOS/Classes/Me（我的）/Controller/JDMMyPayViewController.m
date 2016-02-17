//
//  JDMMyPayViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/27.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMyPayViewController.h"

@interface JDMMyPayViewController ()

@end

@implementation JDMMyPayViewController
static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, JDMScreenW, 40)];
    label.text =@"没有更多消息";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor lightGrayColor];
    self.tableView.tableFooterView = label;
    self.tableView.sectionHeaderHeight = 40;
    self.tableView.estimatedRowHeight = 50;

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    cell.textLabel.text = @"流量管家每日签到";
    cell.detailTextLabel.text = @"11-29";
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.font =[UIFont systemFontOfSize:12];
    cell.accessoryView =[self setupAccessoryView];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"10月";
}


- (UIView*)setupAccessoryView
{
    UIView *AccessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50 , 25)];
    numLabel.text =@"+1G";
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.textColor = [UIColor redColor];
    [AccessoryView addSubview:numLabel];
    UILabel *statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 50 , 25)];
    statusLabel.text =@"已完成";
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = [UIColor lightGrayColor];
    statusLabel.font =[UIFont systemFontOfSize:12];
     [AccessoryView addSubview:statusLabel];
    return AccessoryView;
}
@end
