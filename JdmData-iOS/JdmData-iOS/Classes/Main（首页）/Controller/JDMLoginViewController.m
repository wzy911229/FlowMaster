//
//  JDMLoginViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/16.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMLoginViewController.h"
#import "JDMRegisterViewController.h"
#import <AFNetworking.h>
#import "UIViewController+JDMHUD.h"
#import "JDMUser.h"
#import <MJExtension.h>
#import "JDMUserMsg.h"
#import "JDMHomeViewController.h"
#import "JDMAFNNetworkTools.h"
#import "JDMResetPwdViewController.h"
#import "JDMRegisterViewController.h"
#import "JDMMsgList.h"
#import "JDMUserInfoTools.h"
#import  <SVProgressHUD.h>
#import "UMSocial.h"
#import "JDMHomeViewController.h"

@interface JDMLoginViewController ()
/** 账号信息:电话 */
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
/** 密码 */
@property (weak, nonatomic) IBOutlet UITextField *numField;
/** 基本内容View */
@property (weak, nonatomic) IBOutlet UIView *comminuteLine;
/** user模型数组 */
@property (nonatomic, strong) NSMutableArray *usersArray;
/** user模型 */
@property (nonatomic, strong) JDMUser *user;

@property (weak, nonatomic) IBOutlet UISwitch *isKeepPwd;

/** 登陆读取全部我的消息 */
@property(strong,nonatomic) NSMutableArray*  myMsgArray;

@end

@implementation JDMLoginViewController

- (IBAction)QQLoginIn:(UIButton *)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQzone];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
              [self userlogined];
        }});
}
- (IBAction)weiXinLoginIn:(UIButton *)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
              [self userlogined];
        }
        
    });

}


- (IBAction)sinaWeibo:(UIButton *)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            [self userlogined];
            
        }});
}

- (void)userlogined
{
    isUserLogin = YES;
//    JDMHomeViewController *homeVc = [[JDMHomeViewController alloc]init];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNaV];
    [self setupView];
   [self isHaveKeepPwd];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

-(void)setupNaV
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target: self action:@selector(clickRegisterBtn) ];
    self.title = @"登陆";
   
}

- (void)isHaveKeepPwd
{
   
    bool isSwitchOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"isSwitchOn"];
    self.isKeepPwd.on = isSwitchOn;
    if (isSwitchOn) {
        self.numField.text = [JDMUserInfoTools getPasswordWithAccount:[JDMUserInfoTools getAccount]];
    }
       self.phoneField.text =[JDMUserInfoTools getAccount];
  
}


/**
 *  设置界面文本框
 */
- (void)setupView
{
    [self setupTextFieldLeftView:self.phoneField image:[UIImage imageNamed:@"register_icon_user"]];
     [self setupTextFieldLeftView:self.numField image:[UIImage imageNamed:@"register_icon_password"]];
    
    self.view.backgroundColor = JDMColor(0xF0F0F0);
    self.comminuteLine.backgroundColor = JDMColor(0xF0F0F0);
    
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
/**
 *  点击注册按钮
 */
- (void)clickRegisterBtn
{

    JDMRegisterViewController *regVc = [[JDMRegisterViewController alloc] init];
    [self.navigationController pushViewController:regVc animated:YES];
   
}
/**
 *  点击登陆按钮
 */
- (IBAction)clickLoginBtn:(UIButton *)sender {
 [[NSUserDefaults standardUserDefaults] setObject: self.phoneField.text forKey:@"userCount"];
         [self userLogin];
    
}
/**
 *  点击忘记密码
 */
- (IBAction)forgetPwd {
    
    JDMResetPwdViewController *resetVc = [[JDMResetPwdViewController alloc]init];
    [self.navigationController pushViewController:resetVc animated:YES];
    
}
/**
 *  点击短信验证码登陆
 */
- (IBAction)codeLogin:(id)sender {
    
    JDMRegisterViewController *resetVc = [[JDMRegisterViewController alloc]init];
    [self.navigationController pushViewController:resetVc animated:YES];
}

- (IBAction)isKeeppwd:(UISwitch *)sender {
      NSNumber *isSwitchOn = [NSNumber numberWithBool:sender.on];
    
     [[NSUserDefaults standardUserDefaults] setObject: isSwitchOn forKey:@"isSwitchOn"];
    if (!sender.on) {
       [JDMUserInfoTools removeUserPasswordWithAccount:[JDMUserInfoTools getAccount]];
        
    }

}

/**
 *  请求登陆
 */
- (void)userLogin
{
    // 取消之前的所有请求
    [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginid"] = self.phoneField.text;
    params[@"pwd"] = self.numField.text;
    params[@"ismd5"] = @0;
   // 发送请求
        JDMWeakSelf;
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMLoginURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {
            JDMUser *user = [JDMUser mj_objectWithKeyValues:responseObject];
            weakSelf.user = user;
            isUserLogin = user.status;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userisLogined" object:nil];
            //如果开关是打开,并登陆成功就保存密码
            if (self.isKeepPwd.on) {
//                [SSKeychain deletePasswordForService:JDMSaveService account:self.phoneField.text];
//                [SSKeychain setPassword:self.numField.text forService:JDMSaveService account:self.phoneField.text];
                [JDMUserInfoTools saveUserAccount:self.phoneField.text andPassword:self.numField.text];
                [JDMUserInfoTools saveAllUserInfo:user];
            }
            
              [SVProgressHUD showSuccessWithStatus:@"登陆成功哦"];
            [self saveCookies];
             //如果登陆成功,再请求我的全部未读消息
            [self loadNoReadMyMsgList];
            //发送修改侧边栏的通知
           [[NSNotificationCenter defaultCenter] postNotificationName:@"isUserHaveLogined" object:nil];
            
        }else{
            [SVProgressHUD showErrorWithStatus:JDMRequestProblemAwake];
          
        }
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [self showTextMsgHUD:JDMRequestErrorAwake  andOffsetY: 0];
    }];
}

//加载未读消息数
- (void)loadNoReadMyMsgList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"useruuid"] = [JDMUserInfoTools getUserUuid];
    
    AFHTTPSessionManager *manager = [JDMAFNNetworkTools shareNetworkTools];
    [manager POST: JDMNoReadMsgURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
       userNoReadMsgList = ((NSNumber*)responseObject[@"dataObj"][@"unreadCount"]).integerValue;
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self showTextMsgHUD:JDMRequestErrorAwake andOffsetY: 0];
        
    }];
    
}
- (void)saveCookies
{
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"sessionCookies"];
    [defaults synchronize];
    
}

@end
