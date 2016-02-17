//
//  JDMWelcomeHomeViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/21.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMWelcomeHomeViewController.h"
#import "JDMMainTabBarController.h"
#import <Masonry.h>
#import <RESideMenu.h>
#import "leftMenuViewController.h"
@interface JDMWelcomeHomeViewController ()

@property (nonatomic, weak) NSTimer *timer;
@property(nonatomic,weak) UIButton *jumpButton;
@property(nonatomic ,assign) NSInteger timeNum;

@end

@implementation JDMWelcomeHomeViewController

- (void)loadView
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BG"]];
    imageView.frame = JDMScreenBounds;
    imageView.userInteractionEnabled = YES;
    self.view = imageView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self addViews];
    [self startTimer];
    
}

/**
 *  添加跳过Button
 */
- (void)addViews
{
    UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumpBtn addTarget:self action:@selector(clickJumpButton) forControlEvents:UIControlEventTouchUpInside];
    
    [jumpBtn setTitle:@"跳过:2秒" forState:UIControlStateNormal];
    [self.view addSubview:jumpBtn];
    jumpBtn.backgroundColor = [UIColor lightGrayColor];
    //    [jumpBtn sizeToFit];
    [jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    self.jumpButton =jumpBtn;
}
/**
 *  开启定时器
 */
- (void)startTimer
{
    // 返回一个自动开始执行任务的定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextTime) userInfo:nil repeats:YES];
    //  主线程不管在处理什么操作，都会抽时间处理STimer
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.timeNum = 2;
}

- (void)nextTime
{
    self.timeNum -=1;
    NSString *str = [NSString stringWithFormat:@"跳过:%ld秒",(long)self.timeNum];
    [self.jumpButton setTitle:str forState:UIControlStateNormal];
    self.timeNum  ? : [self clickJumpButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 点击跳过按钮的时候调用
- (void)clickJumpButton
{
    [self.timer invalidate];
    self.timer = nil;
    self.jumpButton.hidden = YES;
    
    [UIView animateWithDuration: 1 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.25, 1.25);
        self.view.alpha = 0.7;
        
    } completion:^(BOOL finished) {
        
        

        [self setResideMenu];
        
//        JDMMainTabBarController *vc = [[JDMMainTabBarController alloc] init];
//        // 设置窗口的根控制器为主框架控制器
//        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        
        
    }];
}



- (void)setResideMenu
{
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:[[JDMMainTabBarController alloc]init]
                                                                    leftMenuViewController: [[leftMenuViewController alloc]init]
                                                                   rightMenuViewController:nil];
    
    sideMenuViewController.parallaxEnabled = NO;
    sideMenuViewController.scaleContentView = YES;
    sideMenuViewController.contentViewScaleValue = 0.95;
    sideMenuViewController.scaleMenuView = NO;
    sideMenuViewController.contentViewShadowEnabled = YES;
    sideMenuViewController.contentViewShadowRadius = 4.5;
    
    // 设置窗口的根控制器为主框架控制器
    [UIApplication sharedApplication].keyWindow.rootViewController = sideMenuViewController;
    
}
@end
