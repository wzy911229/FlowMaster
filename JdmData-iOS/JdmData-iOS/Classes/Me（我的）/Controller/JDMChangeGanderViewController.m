//
//  JDMChangeGanderViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/15.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMChangeGanderViewController.h"
#import "JDMAFNNetworkTools.h"
#import "JDMUserInfoTools.h"
#import "UIViewController+JDMHUD.h"
@interface JDMChangeGanderViewController ()

@property (weak, nonatomic) IBOutlet UIView *boyView;
@property (weak, nonatomic) IBOutlet UIView *girlView;
@property (weak, nonatomic) IBOutlet UIImageView *chooseBoy;
@property (weak, nonatomic) IBOutlet UIImageView *chooseGirl;

@end

@implementation JDMChangeGanderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGestureRecognizer];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if ([JDMUserInfoTools getUserGender]==1) {
        self.chooseGirl.hidden = YES;
        self.chooseBoy.hidden = NO ;
    }else
    {   self.chooseGirl.hidden = NO;
        self.chooseBoy.hidden = YES;
    }
}
-(void)addGestureRecognizer
{
    UITapGestureRecognizer *boytap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseGander:)];
    [self.boyView addGestureRecognizer:boytap];
     UITapGestureRecognizer *girltap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseGander:)];
    [self.girlView addGestureRecognizer:girltap];
}

-(void)chooseGander:(UITapGestureRecognizer*)tap
{
    
    if (tap.view == self.boyView) {
        self.chooseGirl.hidden = YES;
        self.chooseBoy.hidden = NO ;
        [JDMUserInfoTools updateUserGender:1];
        [self haveChangeUserName:@1];
        
    }else if(tap.view == self.girlView) {
        self.chooseGirl.hidden = NO;
        self.chooseBoy.hidden = YES;
            [JDMUserInfoTools updateUserGender:2];
           [self haveChangeUserName:@2];
    }
    
    
}
//修改性别
- (void)haveChangeUserName:(NSNumber *)gender
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *count = [NSString stringWithFormat:@"%ld",(long)[JDMUserInfoTools getUserloginid]];
    params[@"loginid"] = count;
    params[@"gander"] = gender;
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMChangeUserGanderURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        JDMLog(@"%@",responseObject);
        
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {
           [JDMUserInfoTools updateUserGender:gender.integerValue];
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
