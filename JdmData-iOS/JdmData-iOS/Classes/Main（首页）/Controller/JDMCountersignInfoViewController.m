//
//  JDMCountersignInfoViewController.m
//  JdmData-iOS
//
//  Created by test1 on 16/1/4.
//  Copyright © 2016年 jdmdata. All rights reserved.
//

#import "JDMCountersignInfoViewController.h"

@interface JDMCountersignInfoViewController ()
/**手机号*/
@property (weak, nonatomic) IBOutlet UILabel *accountPhone;
/**购买的sb数*/
@property (weak, nonatomic) IBOutlet UILabel *XBNum;
/**需要花费的金额*/
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
/**选中的按钮*/
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
/**确认付款的按钮*/
@property (weak, nonatomic) IBOutlet UIButton *countersignButton;


@end

@implementation JDMCountersignInfoViewController

- (IBAction)clickSelectButton:(UIButton*)sender {
    
//    self.countersignButton.enabled = sender.selected;
}
- (IBAction)clickCheckProvision {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.XBNum.text = self.num;
    self.accountPhone.text = self.phone;
    self.moneyLabel.text = self.money;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
