//
//  JDMRegisterViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/16.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMRegisterViewController.h"
#import <AFNetworking.h>
#import "JDMUser.h"
#import <MJExtension.h>
#import  <SVProgressHUD.h>
#import "JDMHomeViewController.h"
#import "JDMUser.h"
#import "JDMAFNNetworkTools.h"

@interface JDMRegisterViewController ()
/** 手机账号 */
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
/** 验证码 */
@property (weak, nonatomic) IBOutlet UITextField *authCode;
/** 密码 */
@property (weak, nonatomic) IBOutlet UITextField *numField;
/** 所有的用户数据 */
@property (nonatomic, strong) NSMutableArray *userMsg;

- (IBAction)clickauthCodeBtn:(UIButton *)sender;
- (IBAction)clickRegisterBtn:(UIButton *)sender;

@end

@implementation JDMRegisterViewController


#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    self.title = @"短信验证码登陆";
    [self.phoneField becomeFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.phoneField becomeFirstResponder];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.phoneField resignFirstResponder];
    [self.numField resignFirstResponder];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneField resignFirstResponder];
    [self.numField resignFirstResponder];
}
#pragma mark - 内部控制方法
- (void)setupView
{
    [self setupTextFieldLeftView:self.phoneField image:[UIImage imageNamed:@"register_icon_user"]];
    
    [self setupTextFieldLeftView:self.numField image:[UIImage imageNamed:@"register_icon_password"]];
    [self setupTextFieldLeftView:self.authCode image:[UIImage imageNamed:@"register_icon_password"]];
    self.view.backgroundColor = JDMColor(0xF0F0F0);
    
}


// 设置文本框左边视图
- (void)setupTextFieldLeftView:(UITextField *)textField image:(UIImage *)image
{
   
    UIImageView *leftV = [[UIImageView alloc] initWithImage:image];
    

    leftV.contentMode = UIViewContentModeCenter;
    
    CGRect frame = leftV.frame;
    frame.size.width += 20;
    leftV.frame = frame;
   
    textField.leftView = leftV;

    textField.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - 外部控制方法
/** 点击验证码按钮 */
- (IBAction)clickauthCodeBtn:(UIButton *)sender {
    
 
    [self getAuthCode];
    
}

/** 点击验证并登陆按钮 */
- (IBAction)clickRegisterBtn:(UIButton *)sender {
    
    [self userRegister];
    
}


//获取验证码
- (void)getAuthCode
{
    // 取消之前的所有请求
    [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginid"] =self.phoneField.text;
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMReisterURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
//用户验证登陆
- (void)userRegister
{
    // 取消之前的所有请求
    [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginid"] = self.phoneField.text;
    params[@"pwd"] = self.numField.text;
    params[@"vcode"] = self.authCode.text;
    JDMLog(@"%@%@%@",self.phoneField.text,self.authCode.text,self.numField.text);
    
//    // 发送请求
//    JDMWeakSelf;
    
   
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMReisterURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        JDMUser *user = [JDMUser mj_objectWithKeyValues:responseObject];
        JDMLog(@"%@",responseObject[@"status"]);
        
        if (user.status) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"msg"]];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [SVProgressHUD showErrorWithStatus:@"请求错误"];
        
    }];
}



@end
