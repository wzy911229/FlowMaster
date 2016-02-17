//
//  JDMResetPwdViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/8.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMChangePwdViewController.h"
#import "JDMAFNNetworkTools.h"
#import "JDMUser.h"
#import "JDMUserMsg.h"

#import "JDMUserInfoTools.h"
#import "UIViewController+JDMHUD.h"

@interface JDMChangePwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *originallyPwd;
@property (weak, nonatomic) IBOutlet UITextField *newpwd;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;


@end

@implementation JDMChangePwdViewController

- (IBAction)ConfirmButton:(UIButton *)sender {
    [self changepwd];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  

}
- (void)changepwd
{
    // 取消之前的所有请求
    [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSString *count = [NSString stringWithFormat:@"%ld",(long)[JDMUserInfoTools getUserloginid]];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginid"] =  count;
    params[@"oldpwd"] = self.originallyPwd.text;
    params[@"newpwd"] = self.newpwd.text;
    
    JDMLog(@"%ld",(long)[JDMUserInfoTools getUserloginid]);
    JDMLog(@"%@",self.originallyPwd.text);
    JDMLog(@"%@",self.newpwd.text);

    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMLoginURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         NSInteger isChanged = (long)responseObject[@"status"];
        if (isChanged) {
            [JDMUserInfoTools saveUserAccount:count andPassword:self.newpwd.text];
            [self.navigationController popViewControllerAnimated:YES];
        }
         [self showTextMsgHUD: responseObject[@"msg"] andOffsetY: 0];
       
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self showTextMsgHUD:JDMRequestErrorAwake andOffsetY:0];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
}

@end
