//
//  JDMForHelpViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/10.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMForHelpViewController.h"
#import "JDMAddressListFlowViewController.h"
#import "JDMHelpWordViewController.h"
#import "JDMPopoverAnimtor.h"


@interface JDMForHelpViewController ()
/**额度 */
@property (weak, nonatomic) IBOutlet UITextField *positionField;
/**捎句话 */
@property (weak, nonatomic) IBOutlet UITextField *talkField;
/**捎句话容器View */
@property (weak, nonatomic) IBOutlet UIView *sendWordContentView;
/**验证码 */
@property (weak, nonatomic) IBOutlet UITextField *codeField;
/**手机号 */
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
/**转场动画代理对象 */
@property (strong, nonatomic)  JDMPopoverAnimtor *Animtor;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sureButtonLayout;

@end

@implementation JDMForHelpViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"求助好友";
    [self setSource];
}
-(void)setSource
{
    self.phoneField.text = self.phone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTitleBtn:) name:JDMPopoverAnimatorDidDismiss object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTitleBtn:) name:JDMPopoverAnimatorDidShow object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



//点击添加通讯录按钮
- (IBAction)clickAddressListButton {

    JDMAddressListFlowViewController *addresslist = [[JDMAddressListFlowViewController alloc] init];
    addresslist.isPopVc = YES;
     [addresslist setGetPhone:^(NSString * phoneNum) {
        self.phoneField.text = phoneNum;
        
     }];
    
   [self.navigationController  pushViewController:addresslist animated:YES];
   
    
}
//点击获取验证码按钮
- (IBAction)clickCodeButton {
}
//点击确认按钮
- (IBAction)clickSureBUtton {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//点击推荐文字按钮
- (IBAction)clickWordButton:(UIButton*)sender {
//    
    JDMHelpWordViewController *helpWordVc = [[JDMHelpWordViewController alloc]init];
   
    [helpWordVc setDidSelectCell:^(NSString *word) {
        [self dismissViewControllerAnimated:YES completion:nil];
        self.talkField.text = word;
    }];
    
    //定义负责转场的类
    helpWordVc.transitioningDelegate = self.Animtor;
    //定义转场模式
    helpWordVc.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:helpWordVc animated:YES completion:nil];
    
}
-(void)changeTitleBtn:(NSNotification *)noto
{
    CGFloat sureButtonTopLayout = JDMScreenH * 0.26  + 30 - 40 - 40; ;
    self.sureButtonLayout.constant = [noto.name  isEqualToString: JDMPopoverAnimatorDidShow] ? sureButtonTopLayout : 30;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (JDMPopoverAnimtor *)Animtor
{
    if (!_Animtor) {
        JDMLog(@"%f",CGRectGetMaxY(self.talkField.frame));
        JDMPopoverAnimtor *animtor  = [[JDMPopoverAnimtor alloc]init];
        CGRect rect = CGRectMake(0, CGRectGetMaxY(self.sendWordContentView.frame), JDMScreenW, JDMScreenH * 0.26);
        animtor.presentedFrame = rect;
        _Animtor = animtor;
    }
    return _Animtor;
}
@end
