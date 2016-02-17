//
//  JDMEarnedViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/12.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMEarnedViewController.h"
#import "JDMEarnedViewController.h"
#import "JDMFunctionView.h"
#import "JDMSqaureBtn.h"
#import <MJExtension.h>
#import "JDMEarnedFlowCell.h"
#import "JDMEarnedFlow.h"
#import "JDMSqaureButton.h"
#import "JDMSinginViewController.h"
#import "JDMActivityCommendViewController.h"
#import "JDMPublicViewController.h"
#import "JDMDownLoadAppViewController.h"
#import "JDMWitchMovieViewController.h"
#import "JDMLoginViewController.h"
#import "JDMAFNNetworkTools.h"
#import "JDMCommend.h"
#import "JDMActivityViewController.h"
#import "UIViewController+JDMHUD.h"

@interface JDMEarnedViewController ()<JDMFunctionDelegate>
/** 方块按钮模型数组*/
@property(nonatomic,strong) NSArray  *sqaures;
@property(nonatomic,strong) NSMutableArray  *earnedFlows;

@end

@implementation JDMEarnedViewController
static NSString * const ID = @"EarnedFlowCell";
extern NSString * activeHistoryPath;

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupOldSource];
    [self addFuncBtnView];
    [self setupNav];
    [self loadiVitCommend];
}

-(void)setupOldSource
{
    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey: activeHistoryPath];
    self.earnedFlows = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
#pragma mark - 内部控制方法
- (void)setupNav
{
    [self.tableView setBackgroundColor:JDMColor(0xF0F0F0)]
    ;
    
    [self.tableView registerClass:[JDMEarnedFlowCell class] forCellReuseIdentifier:ID];
    
    //        self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.rowHeight = JDMScreenH *(0.22);
    //   self.tableView.estimatedRowHeight = 150;
}
//设置刷新
-(void)setupRefresh
{
    JDMWeakSelf;
    [self setGetFooterBlock:^{
        
        
        
    }];
    [self setGetHeaderBlock:^{
        [weakSelf loadiVitCommend];
    }];
}
/**
 *  加载方块功能按钮
 */
- (void)addFuncBtnView
{
    JDMFunctionView *functionView = [JDMFunctionView functionView];
    [self loadData:@"otherSqaureBtn.json"];
    functionView.frame = CGRectMake(0,0, self.view.width, CGRectGetMaxY([functionView.subviews lastObject].frame) );
    functionView.totalColCount = 3;
    functionView.delegate = self;
    functionView.squares = self.sqaures;
    [self.view addSubview:functionView];
    [self.tableView setTableHeaderView:functionView];;
    
}

#pragma mark - 外部控制方法
/**
 *  加载数据
 */
- (void)loadData:(NSString *)fileName
{
    
    NSString *response = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData: [NSData dataWithContentsOfFile:response] options:NSJSONReadingMutableContainers error:nil];
    self.sqaures = [JDMSqaureBtn mj_objectArrayWithKeyValuesArray:json];
    
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return self.earnedFlows.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDMEarnedFlowCell * earnedCell = [tableView dequeueReusableCellWithIdentifier:ID];
   
    JDMCommend *commend = self.earnedFlows[indexPath.row];
    earnedCell.EaenedFlow = commend;
    
    earnedCell.selectionStyle = UITableViewCellSelectionStyleNone;
  

    return earnedCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JDMActivityViewController *Vc = [[JDMActivityViewController alloc]init];

    JDMCommend *commend= self.earnedFlows[indexPath.row];
       Vc.linkUrl = commend.linkurl;
    [self.navigationController pushViewController:Vc animated:YES];
    
}



#pragma mark - 代理方法

#pragma mark func功能模块 <JDMFunctionDelegate>
- (void)functionView:(JDMFunctionView *)funcView andSqaureButton:(JDMSqaureButton *)sqaureBtn
{
    
    NSString *str =sqaureBtn.titleLabel.text;
    UIViewController *jumpVc = nil;
    
    if ([str isEqualToString:@"签到"])
    {
        jumpVc = [[JDMSinginViewController alloc]init];
        
    }else if ([str isEqualToString:@"流量活动"])
    {
        jumpVc = [[JDMActivityCommendViewController alloc]init];
    }else if ([str isEqualToString:@"公众号"])
    {
        jumpVc = [[JDMPublicViewController alloc] init];
    }
    else if ([str isEqualToString:@"装应用"])
    {
        jumpVc = [[JDMDownLoadAppViewController alloc] init];
    }else if ([str isEqualToString:@"看视频"])
    {
        jumpVc = [[JDMWitchMovieViewController alloc] init];
    }
        jumpVc.title = str;
    
    if (!isUserLogin) {
        JDMLoginViewController *loginVc = [[JDMLoginViewController alloc]init];
        [self.navigationController pushViewController: loginVc animated:YES];

    }
    else{
        [self.navigationController pushViewController: jumpVc animated:YES];
    if ([str isEqualToString:@"猜一猜"])
    {
        [self showTextMsgHUD: @"请期待" andOffsetY: 0];

    }
    }
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CABasicAnimation *animScale = [CABasicAnimation animation];
    animScale.keyPath = @"transform.scale";
    animScale.fromValue = @0.8;
    animScale.toValue = @1.0;
    animScale.duration = 0.5;
    [cell.layer addAnimation:animScale forKey:nil];
    
//    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
//    rotation.m34 = 1.0/ -600;
//    
//    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    cell.layer.transform = rotation;
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    
//    
//    [UIView beginAnimations:@"rotation" context:NULL];
//    [UIView setAnimationDuration:0.8];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 1;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
    
}

//加载数据
-(void)loadiVitCommend
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNum"] =  @1;
    params[@"pageSize"] = @10;

    
    　  [self showLoadingHUD: JDMLoadingAwake andOffsetY:0];
     [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMActivityURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        if (_iSFirstLoad) {
        self.earnedFlows = [JDMCommend mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
    
   
        [self.tableView.mj_header endRefreshing];
        
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {

            [self.tableView.mj_header endRefreshing];
        }else{
      
        [self showTextMsgHUD: responseObject[@"msg"] andOffsetY: 0];
        }
          [self.tableView reloadData];
        [self hideHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
       
    
        [self showTextMsgHUD:JDMRequestErrorAwake andOffsetY:0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self hideHUD];
        });
        
    }];
    
}

#pragma mark - 懒加载

//- (NSMutableArray *)earnedFlows
//{
//    if (_earnedFlows == nil) {
//        
//        _earnedFlows = [NSMutableArray array];
//        
//        NSString *file = [[NSBundle mainBundle] pathForResource:@"earnedFlowCell.plist" ofType:nil];
//        
//        NSArray *dictArray = [NSArray arrayWithContentsOfFile:file];
//        
//        for (NSDictionary *dict in dictArray) {
//            
//            JDMEarnedFlow *EarnedFlow = [JDMEarnedFlow EarnedFlowWithDict:dict];
//            
//            [_earnedFlows addObject:EarnedFlow];
//        }
//    }
//    return _earnedFlows;
//}


@end
