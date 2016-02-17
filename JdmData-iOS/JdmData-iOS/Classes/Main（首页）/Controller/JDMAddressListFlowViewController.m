//
//  JDMAddressListFlowViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/10.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMAddressListFlowViewController.h"
#import "JDMForHelpViewController.h"

@interface JDMAddressListFlowViewController ()<UITableViewDelegate>
@property(nonatomic,copy) NSString * phoneName;
/** 描述*/
@property(nonatomic,strong)JDMForHelpViewController * forHelpVc ;

@end

@implementation JDMAddressListFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的好友";
    self.tableView.delegate =self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    !self.getPhone ?:self.getPhone(cell.detailTextLabel.text);
    self.forHelpVc.phone = cell.detailTextLabel.text;
    self.isPopVc ? [self.navigationController popViewControllerAnimated:YES]: [self.navigationController pushViewController:self.forHelpVc animated:YES];
}
- (JDMForHelpViewController *)forHelpVc
{
    if (!_forHelpVc) {
        _forHelpVc = [[JDMForHelpViewController alloc]init];
        
    }
    return _forHelpVc;
}

@end
