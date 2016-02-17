//
//  JDMMainTabBarController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/12.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMainTabBarController.h"
#import "JDMNavigationViewController.h"
#import "JDMEarnedViewController.h"
#import "JDMHomeViewController.h"
#import "JDMMEViewController.h"
#import "JDMHotMapViewController.h"
#import "JDMPlayViewController.h"
#import <AFNetworking.h>
#import "UIViewController+JDMHUD.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "JDMSwitchStatus.h"
#import "UIViewController+JDMHUD.h"
#import "JDMMoreNewViewController.h"
#import "SwipableViewController.h"
#import "JDMWitchMovieViewController.h"

@interface JDMMainTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic,weak)UIImageView *imageView;

@end

@implementation JDMMainTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupChildVc];
    [self setupTabBar];

    [self setupAFNReachability];
 
    
    self.tabBar.translucent = YES;
//    UIImage *image = [UIImage imageNamed:@"tabBar.png"];
//    [self.tabBar setBackgroundImage:image];
//    //设置选中后的图标和文字的颜色
//    self.tabBar.tintColor = [UIColor whiteColor];
    
    //设置代理
    self.delegate = self;
    //添加绿色的背景
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithColor:JDMColor(0x3492E9) width:50 hight:44]];
   
    imageView.frame = CGRectMake(0, 0, JDMScreenW/5, 49);
    [self.tabBar addSubview:imageView];
    self.imageView = imageView;

}
-(void)setupAFNReachability
{
    // 1.创建网络监听管理者对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 2.设置监听
    /*
     AFNetworkReachabilityStatusUnknown          = -1,  未识别
     AFNetworkReachabilityStatusNotReachable     = 0,   未连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   手机网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,  wifi
     */
    [manager setReachabilityStatusChangeBlock:^ void(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [self showTextMsgHUD:@"未连接" andOffsetY:180];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [JDMSwitchStatus saveCurrentNetwork:NO];
    
                [self showTextMsgHUD:@"正在使用窝蜂网络" andOffsetY:180];
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [JDMSwitchStatus saveCurrentNetwork:YES];
                [self showTextMsgHUD:[NSString stringWithFormat:@"您正在使用WI-FI网络(%@)",[self wifiName]] andOffsetY:180];
            }
                break;
            default:
                [self showTextMsgHUD:@"未识别" andOffsetY:[JDMTools MBProgressOffsetY]];
                break;
        }
    }];
    
    // 3.开启监听
    [manager startMonitoring];
    
}

- (NSString *)wifiName
{
    CFArrayRef myArray = CNCopySupportedInterfaces();
    
    if (myArray != nil) {
        
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            return  [dict valueForKey:@"SSID"];
            
        }
        return nil;
    }
    return nil;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
 
    NSInteger tabBarCount = tabBarController.selectedIndex;
  
    _imageView.frame = CGRectMake(tabBarCount* JDMScreenW/5, 0, JDMScreenW/5, 49);
}

- (void)setupTabBar
{
//    self.selectedIndex = 4;
//     self.selectedIndex = 0;
    self.tabBar.translucent = YES;
   
    [self.tabBar setBarTintColor: JDMColor(0x545454)];
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    normalAttrs[NSForegroundColorAttributeName] = JDMColor(0x999999);
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    

}



- (void)setupChildVc
{

    [self setupChildVc:[[JDMHomeViewController alloc] init] title:@"首页" image:@"tab_home_normal" selectedImage:@"tab_home_press"];
    [self setupChildVc:[[JDMEarnedViewController alloc] init] title:@"赚流量" image:@"tab_make_normal" selectedImage:@"tab_make_press"];
    
    
    JDMMoreNewViewController * new1 = [[JDMMoreNewViewController alloc]init];
    JDMWitchMovieViewController * new2 = [[JDMWitchMovieViewController alloc]init];
    JDMMoreNewViewController * new3 = [[JDMMoreNewViewController alloc]init];
    JDMWitchMovieViewController * new4 = [[JDMWitchMovieViewController alloc]init];
    JDMMoreNewViewController * new5 = [[JDMMoreNewViewController alloc]init];
    SwipableViewController *newsSVC = [[SwipableViewController alloc] initWithTitle:@"热点新闻"andSubTitles:@[@"全部", @"体育", @"科技", @"娱乐",@"段子",@"全部", @"体育", @"科技", @"娱乐",@"段子"] andControllers:@[new1,new2,new3,new4,new5,new1,new2,new3,new4,new5]  underTabbar:YES];
    [self setupChildVc:newsSVC title:@"新闻" image:@"tab_play_normal" selectedImage:@"tab_play_press"];

    
    [self setupChildVc:[[JDMHotMapViewController alloc] init] title:@"流量地图" image:@"tab_map_normal" selectedImage:@"tab_map_press"];
    [self setupChildVc:[[JDMMEViewController alloc] init] title:@"我的" image:@"tab_my_normal" selectedImage:@"tab_my_press"];
   
    
}


- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
   
    JDMNavigationViewController *nav = [[JDMNavigationViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];

    
}

@end
