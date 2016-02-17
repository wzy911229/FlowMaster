//
//  JDMSinginViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/26.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMSinginViewController.h"
#import "FDCalendar.h"
#import "JDMAFNNetworkTools.h"
#import <SVProgressHUD.h>
#import "JDMUserInfoTools.h"
#import "JDMexchangeViewController.h"
#import "JDMSign.h"
#import "JDMSignHistory.h"
#import <MJExtension.h>
#import <math.h>

@interface JDMSinginViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *singSwitch;
@property (weak, nonatomic)FDCalendar *calendar;
@property(strong,nonatomic)NSMutableArray *dateArray;
@property(strong,nonatomic)NSMutableArray *signArray;

@end

@implementation JDMSinginViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"每日签到";
    self.view.backgroundColor = JDMColor(0xff5f53);
    self.singSwitch.transform =CGAffineTransformMakeScale(0.75, 0.75);
    [self.singSwitch addTarget:self action:@selector(isNeedToAwakeSigin:) forControlEvents:UIControlEventValueChanged];
    [self setupCalender];
    [self getHistory];
    

}

- (void)getHistory
{
    // 创建日历类
    NSCalendar *calendar = [NSCalendar currentCalendar];
        // 日期组件（年、月、日、小时、分、秒）
        NSDateComponents *cmp =  [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
   [self loadSigninHistory:[NSString stringWithFormat:@"%ld-%ld-01",(long)cmp.year ,cmp.month ]];

   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    //     清空导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self isNeedSignIn];
  
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:JDMColor(0x3492E9) width:self.view.width hight:0]  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:JDMColor(0x3492E9) width:self.view.width hight:64.0] ];
}

#pragma mark - 内部控制方法
-(void)setupCalender
{

    
    FDCalendar *calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    if (JDMScreenW == 375)
    {
        calendar.frame = CGRectMake(15, 186, self.view.width - 7, 250);
    }else if (JDMScreenW == 414)
    {
        calendar.frame = CGRectMake(17, 216, self.view.width + 28 , 250);
        
    }else{
        calendar.frame = CGRectMake(14, 143, self.view.width - 60, 200);
    }
    [self.view addSubview:calendar];
    self.calendar =calendar;
}
- (void)isNeedSignIn
{
   NSNumber * isNeedSignIn = [[NSUserDefaults standardUserDefaults] objectForKey:@"isSignInSwitchOn"];
    bool isOn = isNeedSignIn.boolValue;
    self.singSwitch.on = isOn;
}

#pragma mark - 外部控制方法

//签到
-(void)loadSignin
{
 
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"useruuid"] =  [JDMUserInfoTools getUserUuid];
    
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMSignURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {
            NSDateFormatter*  formatter= [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyy-MM-dd";
            NSString *nowString = [formatter stringFromDate:[NSDate date]];
            [self.dateArray addObject:nowString];
            
            //今天签到
            NSDictionary *dateDict  = [NSDictionary dictionaryWithObject:self.dateArray forKey:@"dateArray"];
           [[NSNotificationCenter defaultCenter] postNotificationName:@"sign" object:self userInfo:dateDict];
            
        }
        
       [SVProgressHUD  showSuccessWithStatus:responseObject[@"msg"]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         JDMLog(@"%@",error);
    }];
}

//签到记录
- (void)loadSigninHistory:(NSString *)dateStr
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"useruuid"] = [JDMUserInfoTools getUserUuid];
      params[@"curdate"] =  dateStr;
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMSignHistoryURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       JDMSign *sign = [JDMSign  mj_objectWithKeyValues:responseObject];
        if (sign.status) {
            for (NSDictionary *dict in sign.dataList) {

                [self.dateArray addObject:dict[@"attenddate"]];
            }

            //请求成功后发送签到历史
            NSDictionary *dateDict  = [NSDictionary dictionaryWithObject:self.dateArray forKey:@"dateArray"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"postDateHistory" object:self userInfo:dateDict];
        }else {
            
             [SVProgressHUD  showSuccessWithStatus:responseObject[@"msg"]];
        }
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        JDMLog(@"%@",error);
    }];

}

- (void)isNeedToAwakeSigin:(UISwitch*)switchStatus
{
      NSNumber *isSwitchOn = [NSNumber numberWithBool:switchStatus.on ];
     [[NSUserDefaults standardUserDefaults] setObject: isSwitchOn forKey:@"isSignInSwitchOn"];
    
}
- (IBAction)clickSignBtn:(UIButton *)sender {
    
    [self loadSignin];
    
}

- (IBAction)clickexChangeBtn:(UIButton *)sender {
    
    JDMexchangeViewController *EXChangeVc = [[JDMexchangeViewController alloc]init];
    [self.navigationController pushViewController:EXChangeVc animated:YES];
}

- (NSMutableArray *)dateArray
{
    if (!_dateArray) {
        _dateArray = [NSMutableArray array];
    }
    return _dateArray;
}

- (NSMutableArray *)signArray
{
    if (!_signArray) {
        _signArray = [NSMutableArray array];
    }
    return _signArray;
}


@end
