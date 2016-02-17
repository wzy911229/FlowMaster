//
//  JDMBugFlowInfoViewController.m
//  JdmData-iOS
//
//  Created by test1 on 16/1/4.
//  Copyright © 2016年 jdmdata. All rights reserved.
//

#import "JDMBugFlowInfoViewController.h"
#import "JDMAddressListFlowViewController.h"
#import "JDMCountersignInfoViewController.h"
#import "JDMUserInfoTools.h"
@interface JDMBugFlowInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@end

@implementation JDMBugFlowInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   self.moneyLabel.text = self.money;
    self.phoneTextField.text = [NSString stringWithFormat:@"%ld",(long)[JDMUserInfoTools getUserPhoneNumber]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneTextField resignFirstResponder];
}

- (IBAction)clickAddressBUtton {
    
    JDMAddressListFlowViewController *addressListVc = [[JDMAddressListFlowViewController alloc]init];
    addressListVc.isPopVc = YES;
    [addressListVc setGetPhone:^(NSString *phone) {
        self.phoneTextField.text = phone;
    }];
    [self.navigationController pushViewController:addressListVc animated:YES];
    
}
- (IBAction)clickNextButton {
    
    JDMCountersignInfoViewController *buyFlowInfoVc = [[UIStoryboard storyboardWithName:@"JDMCountersignInfoViewController" bundle:nil] instantiateInitialViewController];
    buyFlowInfoVc.money = self.money;
    buyFlowInfoVc.num = self.num;
    buyFlowInfoVc.phone = self.phoneTextField.text;
    [self.navigationController pushViewController:buyFlowInfoVc animated:YES];


}

@end
