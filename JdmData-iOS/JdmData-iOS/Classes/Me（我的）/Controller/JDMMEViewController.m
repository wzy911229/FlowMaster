//
//  JDMMEViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/12.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMEViewController.h"
#import "JDMMeTableHeaderView.h"
#import "JDMsettingViewController.h"
#import "JDMInformationViewController.h"
#import "JDMLoginViewController.h"
#import "JDMFlowcurlyViewController.h"
#import "JDMMyXBViewController.h"
#import "JDMHelpViewController.h"
#import "JDMSinginViewController.h"
#import "JDMMyPayViewController.h"
#import "JDMInviteFriendViewController.h"
#import "JDMMyMsgViewController.h"
#import <Masonry.h>


@interface JDMMEViewController ()<JDMMeTableHeaderViewDelegate>
@property(weak,nonatomic)JDMMeTableHeaderView *headerView;
//消息button
@property(weak,nonatomic) UIButton *button;
//显示签到label
@property(weak,nonatomic) UILabel *label;
@property(assign,nonatomic) bool isLabelArrow;

@end

@implementation JDMMEViewController
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNaV];
    [self setUpGroup0];
    [self setupGroup1];
    [self setupTableView];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //     清空导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:JDMRGBColor(52, 146, 233, 0) width:self.view.width hight:64.0]  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:JDMRGBColor(52, 146, 233, 0) width:self.view.width hight:64.0] ];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"isUserHaveLogined" object:nil];
    [self userLogined];
  
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:JDMColor(0x3492E9) width:self.view.width hight:0]  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:JDMColor(0x3492E9) width:self.view.width hight:64.0]];
}

#pragma mark - 内部控制方法
-(void)setupNaV
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"my_icon_message" ] style:UIBarButtonItemStyleDone target:self action: @selector(clickSmallBellButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"my_icon_setting"] style:UIBarButtonItemStyleDone target:self action: @selector(clickSettingButton)];

}
-(void)setupTableView
{
    self.view.backgroundColor = JDMColor(0xF0F0F0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    JDMMeTableHeaderView *headerView = [JDMMeTableHeaderView viewFromNib];
    headerView.frame = CGRectMake(0, 0, JDMScreenW, 259 +[self sectionHeightProper]);
    headerView.delegate = self;
    self.headerView = headerView;
    self.headerView.width = JDMScreenW;
    [self.tableView setTableHeaderView:headerView];
}

// 添加第0组
- (void)setUpGroup0
{
    JDMSettingArrowItem *item = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"my_icon_xiaoxi"]title:@"我的消息"];
    item.descVc = [JDMMyMsgViewController class];
    item.isNeedLogin = YES;
    item.customAccessoryView =[self buttonArrow];
//    item.cellStyle = UITableViewCellStyleSubtitle;
    
    JDMSettingArrowItem *item1 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"my_icon_zhangdan"] title:@"我的账单"];
    item1.descVc = [JDMMyPayViewController class];
    item1.isNeedLogin = YES;
   
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item,item1]];
    
    [self.groups addObject:group];
    
    
}

- (void)setupGroup1
{
    JDMSettingArrowItem *item0 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"my_icon_qiandao"]title:@"签到"];
    item0.descVc = [JDMSinginViewController class];
    item0.isNeedLogin = YES;
    item0.customAccessoryView = [self labelArrow];
    
    JDMSettingArrowItem *item1 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"my_icon_yaoqing"] title:@"邀请"];
    item1.descVc = [JDMInviteFriendViewController class];
     item1.isNeedLogin = YES;
    
    JDMSettingArrowItem *item2 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"my_icon_bangzhu"]title:@"帮助"];
    item2.descVc = [JDMHelpViewController class];
    
    JDMSettingArrowItem *item3 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"my_icon_shezhi"] title:@"设置"];
    item3.descVc = [JDMsettingViewController class];
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item0,item1,item2,item3]];
      [self.groups addObject:group];
    

}
/**
 * cell的消息右控件
 */
- (UIView *)buttonArrow
{
    UIView *labelArrow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_rightarrow"]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font =[UIFont systemFontOfSize:13];
    
     NSString *str = [NSString stringWithFormat:@"%ld",(long)userNoReadMsgList];
    [button setTitle:str forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:@"btn_message_redcircle"]   forState:UIControlStateNormal];
         button.hidden = YES;
    [labelArrow addSubview:arrow];
    [labelArrow addSubview:button];
    self.button = button;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labelArrow.mas_centerY);
        make.right.equalTo(arrow.mas_right).offset(-20);
    }];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labelArrow.mas_centerY);
        make.right.equalTo(labelArrow.mas_right);
    }];
    return labelArrow;
}
/**
 * cell的签到显示右控件
 */
- (UIView *)labelArrow
{
    UIView *labelArrow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_rightarrow"]];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"未签到";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:13];
    self.label =label;
    [labelArrow addSubview:arrow];
    [labelArrow addSubview:label];

    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labelArrow.mas_centerY);
        make.right.equalTo(arrow.mas_right).offset(-20);
    }];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labelArrow.mas_centerY);
        make.right.equalTo(labelArrow.mas_right);
    }];
    
    return labelArrow;
    
}

/**
 *  每次展现界面的时候加载界面元素
 */
-(void)userLogined
{

    if (userNoReadMsgList && isUserLogin) {
        self.button.hidden = NO;
           [[UIApplication sharedApplication] setApplicationIconBadgeNumber:userNoReadMsgList];
        [self.tabBarController.tabBar showBadgeOnItemIndex:0];
        [self.tabBarController.tabBar showBadgeOnItemIndex:4];
        NSString *str = [NSString stringWithFormat:@"%ld",(long)userNoReadMsgList];
        [self.button setTitle:str forState:UIControlStateNormal];
    }else
    {
        self.button.hidden = YES;
        [self.tabBarController.tabBar hideBadgeOnItemIndex:0];
        [self.tabBarController.tabBar hideBadgeOnItemIndex:4];
           [[UIApplication sharedApplication] setApplicationIconBadgeNumber:userNoReadMsgList];
    }
 
}

#pragma mark - 外部控制方法
/**
 *  监听设置按钮
 */
- (void)clickSettingButton
{
    JDMsettingViewController *setVc = [[JDMsettingViewController alloc]init];
    [self.navigationController pushViewController:setVc animated:YES];
}

/**
 *  监听声音按钮
 */
-(void)clickSmallBellButton
{
    JDMHelpViewController *helpVc = [[JDMHelpViewController alloc]init];
    [self.navigationController pushViewController:helpVc animated:YES];
}

#pragma mark  - 代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat alpha = scrollView.contentOffset.y * (1 / (self.headerView.height *0.6));
   alpha =  alpha < 0 ?  - alpha : alpha ;

    if (alpha >= 1) {
        alpha = 0.99;
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:JDMRGBColor(52, 146, 233, alpha) width:self.view.width hight:64.0]  forBarMetrics:UIBarMetricsDefault];
  
}

/**
 *  跳转到我的信息
 */
- (void)meTableHeaderView:(JDMMeTableHeaderView *)MeTableHeaderView
{
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"JDMInformationViewController" bundle:nil];
   JDMInformationViewController * InforVc  =[SB instantiateInitialViewController];
    
    [self pushToViewController:InforVc];
    
}
/**
 *  跳转到我的X币
 */
- (void)meTableHeaderViewClickBuyFlowBtn:(JDMMeTableHeaderView *)MeTableHeaderView
{
    
    JDMMyXBViewController *XBVc = [[JDMMyXBViewController alloc]init];
    [self pushToViewController:XBVc];

}
/**
 *  跳转到我的流量卷
 */
- (void)meTableHeaderViewClickExChangeFlowBtn:(JDMMeTableHeaderView *)MeTableHeaderView
{
  
    JDMFlowcurlyViewController *FlowCurlyVc = [[JDMFlowcurlyViewController alloc]init];
    [self pushToViewController:FlowCurlyVc];
    
}

- (void)pushToViewController:(UIViewController *)Vc
{
    if (isUserLogin) {
        [self.navigationController pushViewController: Vc animated:YES];
        return;
    }
    [self.navigationController pushViewController:[[JDMLoginViewController alloc]init] animated:YES];

}

/**
 *  适配组头部控件高度
 */
- (CGFloat)sectionHeightProper
{
    if (JDMScreenW == 320) {
        return 20;
    }else if (JDMScreenW == 375)
    {
        return 26;
    }else if (JDMScreenW == 414)
    {
        return 38;
    }
    return 30;
}

@end
