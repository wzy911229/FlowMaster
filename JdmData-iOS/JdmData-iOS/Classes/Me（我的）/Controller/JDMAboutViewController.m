//
//  JDMAboutViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/30.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMAboutViewController.h"
#import "JDMAFNNetworkTools.h"
#import "UIViewController+JDMHUD.h"
//#import  <MBProgressHUD.h>

@interface JDMAboutViewController ()
{
    MBProgressHUD * HUD;
}

@end

@implementation JDMAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self update];
    [self setupTableVIew];
    [self setUpGroup0];
    [self setUpGroup1];

}


-(void)setupTableVIew
{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, JDMScreenW, 180)];
//    view.backgroundColor =[UIColor grayColor];
    UIImageView *imagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_ico_coupon"]];
    imagView.center= view.center;
//    imagView.frame =view.bounds;
    [view addSubview:imagView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view.centerX, CGRectGetMaxY(imagView.frame) + 10, 250, 50)];
    label.centerX =view.centerX;
    
  
    label.text = (NSString *)[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
   label.textAlignment = NSTextAlignmentCenter;
//    label.y =  imagView.y + 5;
    [view addSubview:label];
    self.tableView.tableHeaderView = view;
    
    
    UILabel *lastlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, JDMScreenW, 200)];
    lastlabel.center =view.center;
    lastlabel.text = @"流量宝:精迪敏数据有限公司";
    lastlabel.font =[UIFont systemFontOfSize:12];
    lastlabel.textAlignment = NSTextAlignmentCenter;
    
    lastlabel.textColor = [UIColor lightGrayColor];
//    lastlabel.backgroundColor =[UIColor redColor];
    [view addSubview:lastlabel];
    
    
    self.tableView.tableFooterView = lastlabel;

}
// 添加第0组
- (void)setUpGroup0
{
    
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:nil title:@"公众号"];
    item.descVc = [UITableViewController class];
    
    
    JDMGroupItem *groupArray = [JDMGroupItem groupWithItems:@[item]];
    
    
    [self.groups addObject:groupArray];
    
}
// 添加第0组
- (void)setUpGroup1
{
    
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:nil title:@"用户协议"];
    item.descVc = [UITableViewController class];
    JDMSettingArrowItem *item1 = [JDMSettingArrowItem itemWithImage:nil title:@"欢迎页"];
    item1.descVc = [UITableViewController class];

    JDMSettingArrowItem *item2 = [JDMSettingArrowItem itemWithImage:nil title:@"评价应用"];
    item2.descVc = [UITableViewController class];

    
    
    JDMGroupItem *groupArray = [JDMGroupItem groupWithItems:@[item,item1,item2]];
    
    
    [self.groups addObject:groupArray];
    
}
- (void)update
{
    [self showLoadingHUD: JDMLoadingAwake andOffsetY:0];
     
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMUpdateURL parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        JDMLog(@"%@",responseObject);
        NSNumber* isSuccess = responseObject[@"status"];
        if (!isSuccess.integerValue) {
        
             [self showTextMsgHUD: responseObject[@"msg"] andOffsetY: 0];
        }
           [self hideHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self showTextMsgHUD:JDMRequestErrorAwake andOffsetY:0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideHUD];
        });
    }];
    
}
@end
