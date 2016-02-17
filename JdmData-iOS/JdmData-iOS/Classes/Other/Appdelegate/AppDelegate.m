//
//  AppDelegate.m
//  JdmData-iOS
//
//  Created by wJDM on 15/11/10.
//  Copyright © 2015年 jdmdata. All rights reserved.
//
/*
                    _ooOoo_
                   o8888888o
                   88" . "88
                   (| -_- |)
                   O\  =  /O
                ____/`---'\____
              .'  \\|     |//  `.
             /  \\|||  :  |||//  \
            /  _||||| -:- |||||-  \
            |   | \\\  -  /// |   |
            | \_|  ''\---/''  |   |
            \  .-\__  `-`  ___/-. /
          ___`. .'  /--.--\  `. . __
       ."" '<  `.___\_<|>_/___.'  >'"".
      | | :  `- \`.;`\ _ /`;.`/ - ` : | |
      \  \ `-.   \_ __\ /__ _/   .-` /  /
 ======`-.____`-.___\_____/___.-`____.-'======
                    `=---='
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
              佛祖保佑       永无BUG
 */

#define IS_iOS8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#define JDMVersionKey @"version"

#import "AppDelegate.h"
#import "JDMMainTabBarController.h"
#import <AddressBook/AddressBook.h>
#import "JDMAFNNetworkTools.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "JDMNewFeatureViewController.h"
#import "JDMWelcomeHomeViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UncaughtExceptionHandler.h"

@interface AppDelegate ()<BMKGeneralDelegate>
{
         BOOL _isFullScreen;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [self loadCookies];
/**-----------------------------百度地图------------------------*/
//    请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"VOvRz8qV2Ut2BSmUMhMWpMQu"  generalDelegate:self];
    if (!ret) {
        JDMLog(@"manager start failed!");
    }
    
/**-----------------------------友盟分享  ------------------------*/
    
    
    [UMSocialData setAppKey:@"566a1bff67e58e4e2700337b"];
       //打开人人网SSO开关,需要 #import "UMSocialRenrenHandler.h"
    //    [UMSocialRenrenData openSSO];
    //  微信分享
    [UMSocialWechatHandler setWXAppId:@"wx708ac7c82b005527" appSecret:@"e879a5a6032304558ebb1cfda675fa31" url:@"http://www.jdmdata.com/"];
    //集成qq和qq空间分享
//    [UMSocialQQHandler setQQWithAppId:@"1105019650" appKey:@"ejVam6m0LGi7lDHM" url:@"http://www.jdmdata.com/"];

    [UMSocialQQHandler setQQWithAppId:@"1105008635" appKey:@"o4K5HV7aDefwn4wG" url:@"http://www.jdmdata.com/"];
    //添加新浪SSO分享
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"4149178782" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    /**-----------------------------获取通讯录授权------------------------*/
    // 1.获取授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    // 2.判断是否已经授权,如果没有决定最终状态,请求授权
    if (status == kABAuthorizationStatusNotDetermined) {
        
        // 2.1.获取通信录对象
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        
        // 2.2.开始请求授权
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (error) return;
            
            if (granted) {
                JDMLog(@"授权成功");
            } else {
                JDMLog(@"授权失败");
            }
        });
    }
/**----------------------------- 本地通知签到------------------------*/
    
    [application setApplicationIconBadgeNumber:0];
    
    if (IS_iOS8) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
        
        [application registerUserNotificationSettings:settings];
    }
    // 如果是正常启动应用程序,那么launchOptions参数是null
    // 如果是通过其它方式启动应用程序,那么launchOptions就值
    //通过本地通知代开程序就选这个key:UIApplicationLaunchOptionsLocalNotificationKey
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        // 当被杀死状态收到本地通知时执行的跳转代码
        [self jumpToSignIn];
      
    }
/**-----------------------------视频模块横竖屏切换通知------------------------*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterFullScreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willExitFullScreen:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    
/**-----------------------------APP界面展示------------------------*/
    //设置状态栏
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //加载主控制器
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
//    self.window.rootViewController = [[JDMNewFeatureViewController alloc] init];

    self.window.rootViewController = [self chooseWindowRootVC];
//     self.window.rootViewController = [[JDMRootViewController alloc]init];

    
    [self.window makeKeyAndVisible];

    InstallUncaughtExceptionHandler();
    return YES;
}

/**
 *  判断是否加载特性界面
 */
- (UIViewController *)chooseWindowRootVC
{

    NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:JDMVersionKey];

    UIViewController *rootVc;
    
    if ([curVersion isEqualToString:lastVersion]) {

        rootVc  = [[JDMWelcomeHomeViewController alloc] init];
        
    }else{
        
        rootVc = [[JDMNewFeatureViewController alloc] init];
        

        [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:JDMVersionKey];
    
    }
    
    return rootVc;
}

//-(void)sendMail
//{
//    
//    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
//    mc.mailComposeDelegate = self;
//    [mc setSubject:@"流量宝--错误日志"];
//    [mc setToRecipients:@[@"540825129@qq.com"]];
//    [mc setMessageBody:str isHTML:NO];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:mc animated:YES completion:nil];
//  
//}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // 在这里写跳转代码
    // 如果是应用程序在前台,依然会收到通知,但是收到通知之后不应该跳转
    if (application.applicationState == UIApplicationStateActive) return;
    
    if (application.applicationState == UIApplicationStateInactive) {
        // 当应用在后台收到本地通知时执行的跳转代码
        [self jumpToSignIn];
    }
    
}


//友盟回调方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//设置屏幕是否允许横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_isFullScreen) {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }else {
        return UIInterfaceOrientationMaskPortrait;
    }

}

//横竖屏切换通知方法
- (void)willEnterFullScreen:(NSNotification *)notification
 {
     _isFullScreen = YES;
 }
- (void)willExitFullScreen:(NSNotification *)notification
 {
     _isFullScreen = NO;

}


//- (void)onGetNetworkState:(int)iError
//{
//    if (0 == iError) {
//        JDMLog(@"联网成功");
//    }
//    else{
//        JDMLog(@"onGetNetworkState %d",iError);
//    }
//    
//}
//
//- (void)onGetPermissionState:(int)iError
//{
//    if (0 == iError) {
//        JDMLog(@"授权成功");
//    }
//    else {
//        JDMLog(@"onGetPermissionState %d",iError);
//    }
//}

//本地通知跳转方法
-(void)jumpToSignIn
{
    
}
- (void)loadCookies
{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
    
}
@end
