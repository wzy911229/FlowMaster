//
//  JDMCheckFlowViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMyFlowViewController.h"
#import "JDMHUBView.h"
#import "JDMUseTrendsViewController.h"
#import "JDMProgressView.h"

static NSString *ID =@"cell";

@interface JDMMyFlowViewController () <JDMHUBViewDelegate,UITableViewDataSource,UITableViewDelegate>
;
/** 加流量tableView*/
@property (weak, nonatomic) IBOutlet UITableView *addFlowTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addFlowLayout;
/** 加流量取消btn*/
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (weak, nonatomic) IBOutlet UIView *contextView;

@property (weak, nonatomic) IBOutlet JDMProgressView *progressView;

@property(nonatomic,assign) bool isLogin;
/** 设置流量蒙版*/
@property (nonatomic,strong) JDMHUBView *HUBView;
/** 懒加载使用趋势控制器*/
@property (nonatomic,weak) JDMUseTrendsViewController *useVc;
/** 加流量layout*/
@property (nonatomic,assign) CGFloat layout;
@property(nonatomic,weak) UIView *addView;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation JDMMyFlowViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view largeScaleProper];
    self.view.backgroundColor =[UIColor whiteColor];
    self.title =@"我的流量";
    self.isLogin = YES;
//    [self setupSegment];
    [self addHUB];
    self.addFlowTableView.delegate = self;
     self.addFlowTableView.dataSource = self;
    [self.addFlowTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    self.progressView.progress = 1;
//    self.progressView.hidden = NO;
}



#pragma mark - 内部控制方法
- (void)addHUB
{
    if (self.isLogin) {
        
        JDMHUBView *HUBView = [JDMHUBView viewFromNib];
        HUBView.delegate = self;
        [self.view addSubview:HUBView];
        self.HUBView = HUBView;

    }

}
-(void)addNSTimer
{
     self.progressView.progress = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(setupProgressView) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer =nil;
    
}
-(void)setupProgressView
{
    self.progressView.progress  += 0.02;

}
#pragma mark - 代理方法

#pragma mark 点击蒙版设置 <JDMHUBViewDelegate>
- (void)HUBView:(JDMHUBView *)HUBView touchSetBtn:(UIButton *)setBtn;
{
    self.HUBView.hidden = YES;
      [self addNSTimer];
    
}
- (void)HUBView:(JDMHUBView *)HUBView touchCancleBtn:(UIButton *)CancleBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 数据源方法

#pragma mark addFlowTableView设置 <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!indexPath.row) {
        cell.imageView.image = [UIImage imageNamed:@"traffic_icon_xtxlqz"];
        cell.textLabel.text =@"我还没准备好";
    }
        cell.imageView.image = [UIImage imageNamed:@"traffic_icon_xtxlqz"];
        cell.textLabel.text =@"我还没准备好";

    return cell;
}
//- (void)setupSegment
//{
//    UISegmentedControl *segment =[[UISegmentedControl alloc] initWithItems:@[@"流量查询",@"使用趋势"]];
//    
//    segment.width = self.view.width / 1.2;
//    segment.center = CGPointMake(self.view.center.x, 100);
//    [segment addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
//    segment.selectedSegmentIndex = 0;
//    [self.view addSubview:segment];
//}

#pragma mark - 外部控制方法

//点击添加Btn
- (IBAction)ClickAddFlowBtn:(UIButton *)sender {
    
    [self setAddFlowView:0 iscancleHidden:NO];
    
    
}
//点击取消Btn
- (IBAction)clickCancleBtn:(UIButton*)sender {
    [self setAddFlowView: - 88 iscancleHidden:YES];
    
}
//设置添加的tableVIew动画
-(void)setAddFlowView:(CGFloat)AddFlowLayout iscancleHidden:(BOOL)isHidden
{
    self.addFlowLayout.constant = AddFlowLayout;
    self.layout = AddFlowLayout;
    self.cancleBtn.hidden = isHidden;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
        self.addView.alpha = AddFlowLayout== 0 ? 0.7 : 0.0;
        
    }];
    
}
//监听segment的变化
- (IBAction)segment:(UISegmentedControl *)sender {


    if (sender.selectedSegmentIndex) {
        
        [self.contextView addSubview: self.useVc.view];
        [self stopTimer];
   
        
    }else
    {
        [self.useVc.view removeFromSuperview];
        [self addNSTimer];
    
    }
}
#pragma mark - 懒加载
- (JDMUseTrendsViewController *)useVc
{
    if (!_useVc) {
        JDMUseTrendsViewController *useVc = [[JDMUseTrendsViewController alloc] init];
        useVc.view.frame = self.contextView.bounds;
        self.useVc = useVc;
        [self addChildViewController:useVc];
    }
    return _useVc;
}

- (UIView *)addView
{
    if (!_addView) {
        UIView*View = [[UIView alloc]initWithFrame:self.view.bounds];
        View.backgroundColor=[UIColor blackColor];
        View.alpha =0.0;
        [self.view insertSubview:View atIndex:4];
        self.addView = View;
    }
    return _addView;
}


@end
