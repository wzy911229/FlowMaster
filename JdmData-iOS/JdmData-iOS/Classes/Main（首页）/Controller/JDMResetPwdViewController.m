//
//  JDMResetPwdViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/8.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMResetPwdViewController.h"
#import "JDMAFNNetworkTools.h"
#import <SVProgressHUD.h>
#import "JDMUserInfoTools.h"


@interface JDMResetPwdViewController ()

@property (weak, nonatomic) IBOutlet UITextField *codeNum;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation JDMResetPwdViewController
- (IBAction)clickGetCodeButton {
    [self getAuthCode];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

//获取验证码
- (void)getAuthCode
{
    // 取消之前的所有请求
    [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginid"] = [NSString stringWithFormat:@"%ld",(long)[JDMUserInfoTools getUserloginid]];
    
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMLoginURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {

            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }else{
            [SVProgressHUD showSuccessWithStatus:responseObject[@"msg"]];
        }
        
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求错误"];
    }];
    
}

-(void)changepwd
{
    // 取消之前的所有请求
    [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginid"] =  [NSString stringWithFormat:@"%ld",(long)[JDMUserInfoTools getUserloginid]];
    params[@"pwd"] = self.pwd.text;
    params[@"vcode"] = self.codeNum.text;
  
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMLoginURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {

            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }else{
            [SVProgressHUD showSuccessWithStatus:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [SVProgressHUD showErrorWithStatus:@"请求错误"];
    }];
}
- (IBAction)confirm:(UIButton *)sender {
    [self changepwd];
}

@end
