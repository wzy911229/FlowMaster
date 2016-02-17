//
//  JDMNavigationViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/12.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMNavigationViewController.h"

@interface JDMNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation JDMNavigationViewController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    bar.barTintColor = JDMColor(0x3492E9);
    [bar setTintColor:[UIColor whiteColor]];
    // 设置导航条文字颜色
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    // 设置颜色
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:[self titleFont]];
    [bar setTitleTextAttributes:dict];
    
    // 获取UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    

    // 设置导航条返回按钮的文字的位置
    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];


}
/**
 *  适配NavTitle字体大小
 */
+ (CGFloat)titleFont
{
    if (JDMScreenW == 320) {
        return 17;
    }else if (JDMScreenW == 375)
    {
        return 20;
    }else if (JDMScreenW == 414)
    {
        return 23;
    }
    return 25;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self setupNavGestureRecognizerBack];
    
    
}
-(void)setupNavGestureRecognizerBack
{
     self.interactivePopGestureRecognizer.enabled = NO;
    // 借用系统的滑动手势的功能，当触发自己的滑动手势的时候，调用系统的滑动返回功能
    
    //注意:其实系统手势就是 调用系统手势的代理对象的方法: handleNavigationTransition: 方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    pan.delegate =self;
    
    [self.view addGestureRecognizer:pan];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    
    if (self.childViewControllers.count != 0) { // 非跟控制器
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
 
}

@end
