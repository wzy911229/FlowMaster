//
//  JDMFlowcurlyViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMFlowcurlyViewController.h"
#import <Masonry.h>
#import "JDMExchangeHistoryViewController.h"
#import "JDMFlowCoulySettingViewController.h"

@interface JDMFlowcurlyViewController ()
/** 没有优惠劵时中间图片*/
@property(nonatomic,weak)UIImageView *imageView;
/** 没有优惠劵时中间文字*/
@property(nonatomic,weak)UILabel *label;

@end

@implementation JDMFlowcurlyViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNaV];
    [self setupSegment];
    [self setupNone];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}
#pragma mark - 内部控制方法
-(void)setupNaV
{
    UIBarButtonItem *setItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickSetItem) image:@"title_icon_setting"highImage:nil];
    
    setItem.width = 5;
    UIBarButtonItem *bookItem =[UIBarButtonItem itemWithTarget:self action:@selector(clickBookItem) image:@"title_icon_record"highImage:nil];
  
    self.navigationItem.rightBarButtonItems =@[setItem,bookItem];
}

-(void)setupSegment
{
    UISegmentedControl *segment =[[UISegmentedControl alloc] initWithItems:@[@"未使用",@"已使用",@"已过期"]];
    
    segment.width = self.view.width / 1.2;
    segment.center = CGPointMake(self.view.center.x, 100);
    [segment addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    [self.view addSubview:segment];
}
/**
 *  当不存在优惠劵的时候显示
 */
- (void)setupNone
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ticket_icon_note"]];
    imageView.centerX = self.view.centerX;
    imageView.centerY = self.view.centerY - 30;
    
    [self.view addSubview:imageView];
    
    self.imageView =imageView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 10, self.view.width, 30)];
    //    label.centerX = self.view.centerX;
    //    JDMLog(@"%@",NSStringFromCGRect( self.imageView.frame));
    //
    //    label.centerY = CGRectGetMaxY(self.imageView.frame) ;
    //    label.width = 200;
    label.text = @"你目前还没有流量卷";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor =JDMColor(0x666666);
    
    [self.view addSubview:label];
    self.label =label;
    
}

#pragma mark - 外部控制方法
/**
 *  监听segment变化
 */
- (void)clickSegment:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:
            self.label.text = @"你目前还没有流量卷";
            break;
        case 1:
            self.label.text =@"你目前没有使用记录";
            break;
        case 2:
            self.label.text =@"你目前没有过期的流量卷";
            break;
            
        default:
            break;
    }
}

/**
 *  监听书按钮
 */
-(void)clickBookItem
{
    JDMExchangeHistoryViewController *exchangeHistoryVc = [[JDMExchangeHistoryViewController alloc]init];
    [self.navigationController pushViewController:exchangeHistoryVc animated:YES];
}
/**
 *  监听设置按钮
 */
- (void)clickSetItem
{
    JDMFlowCoulySettingViewController *FlowCoulySetVc = [[JDMFlowCoulySettingViewController alloc]init];
    [self.navigationController pushViewController:FlowCoulySetVc animated:YES];
}

@end
