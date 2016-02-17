//
//  JDMMsgViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/16.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMsgViewController.h"
#import "JDMMsgTableViewCell.h"

@interface JDMMsgViewController ()

@end

@implementation JDMMsgViewController
static NSString *ID =@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
  
     [self.tableView registerNib:[UINib nibWithNibName:@"JDMMsgTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (void)setupRefresh
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JDMMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.contentView.backgroundColor =  JDMColor(0xF0F0F0);;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
