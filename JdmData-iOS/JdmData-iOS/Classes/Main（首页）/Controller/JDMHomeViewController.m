//
//  JDMHomeViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/12.
//  Copyright © 2015年 jdmdata. All rights reserved.
/*
 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
 hud.mode = MBProgressHUDModeText;
 hud.labelText = @"世界那么大,请多出去走走";
 hud.margin = 10.f;
 hud.removeFromSuperViewOnHide = YES;
 [hud hide:YES afterDelay:3];

 */

#import "JDMHomeViewController.h"
#import "JDMFunctionView.h"
#import "JDMCommendView.h"
#import "JDMMovieFlowView.h"
#import "JDMLoginViewController.h"
#import "JDMMovieViewController.h"
#import "JDMSqaureBtn.h"
#import "JDMXBViewController.h"
#import "JDMexchangeViewController.h"
#import "JDMGiveFlowViewController.h"
#import "JDMFlowcurlyViewController.h"
#import "JDMStoreViewController.h"
#import "JDMMyFlowViewController.h"
#import "JDMMyMsgViewController.h"
#import "JDMRedBagViewController.h"
#import "JDMActivityCommendViewController.h"
#import "JDMQRCodeViewController.h"
#import "JDMNavigationViewController.h"
#import "JDMSinginViewController.h"
#import "JDMWitchMovieViewController.h"
#import "JDMAFNNetworkTools.h"
#import "JDMBanner.h"
#import "GGBannerView.h"
#import "JDMEarnedViewController.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <MBProgressHUD.h>
#import "JDMNotify.h"
#import "JDMNews.h"
#import "JDMNewsView.h"
#import "JDMMoreNewViewController.h"
#import "JDMMovie.h"
#import "UIViewController+JDMHUD.h"
#import "JDMSwitchStatus.h"
#import "UIImageView+JDMExtension.h"
#import "SwipableViewController.h"

#define degree2angle(angle)  ((angle) * M_PI / 180)
#define signFormatterStyle @"yyyy-MM-dd HH:mm:ss"
#define localNoteAlertBody @"你需要签到了,知道吗? 骚年"
#define localNoteAlertAction @"查看具体的消息"
#define localNoteAlertTitle  @"精迪敏流量宝"

NSString * const newsHistoryPath = @"newsHistoryPath";


@interface JDMHomeViewController () <UIScrollViewDelegate,JDMFunctionDelegate,JDMCommendViewDelegate,JDMMovieFlowViewDelegate,GGBannerViewDelegate>
{
    MBProgressHUD*HUD;
}
/** 首页滚动消息view */
@property(nonatomic,weak)JDMNotify *notify;
/** 内容ScrollView */
@property(nonatomic,weak) UIScrollView *contentView;
/** banner */
@property(nonatomic,weak)GGBannerView * bannerViews;
/** func功能模块 */
@property(nonatomic,weak)JDMFunctionView *functionView;
/** 活动推荐模块 */
@property(nonatomic,weak) JDMCommendView *commendView;
/** 新闻模块 */
@property(nonatomic,weak) JDMCommendView *newsView;
/** 看视频赚流量模块 */
@property(nonatomic,weak) JDMMovieFlowView *movieFlowView;

/** func功能模块按钮模型数组 */
@property(nonatomic,strong) NSArray *sqaures;
/** 保存功能模块按钮 */     
@property(nonatomic,weak) UIButton *sqaureBtn;
/** 保存banner模型数组 */
@property (nonatomic, strong) NSMutableArray * banners;
/** 保存新闻模型数组 */
@property (nonatomic, strong) NSMutableArray * news;
/** 消息按钮 */
@property (nonatomic, weak) UIButton * notifyByn;


@end

@implementation JDMHomeViewController
#pragma mark - 生命周期方法

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNaV];
    [self setupContentView];
    [self setBanner];
    [self addFuncBtnView];
    [self addCommendView];
    [self addNewsView];
    [self addMovieFlowView];
    [self isNeedSignIn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogined) name:@"popToHome" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self userLogined];
     [self addNotify];
  
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.notify removeFromSuperview];
    
}
#pragma mark - 内部控制方法

/**
 *  设置导航栏
 */
- (void)setupNaV
{
    self.navigationController.navigationBar.barTintColor = JDMColor(0x3492E9);
    [self.navigationItem setRightBarButtonItem: [UIBarButtonItem itemWithTarget:self
                                                                         action:@selector(QRCodeClick)
                                                                          image:@"title_icon_sys"
                                                                    highImage:nil]];
    
    //设置消息按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(MyMsgClick) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"title_icon_message"] forState:UIControlStateNormal];
    [button sizeToFit];
    UIButton *notifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    notifyBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [notifyBtn setTitle:@"11" forState:UIControlStateNormal];
    [notifyBtn setBackgroundImage:[UIImage imageNamed:@"btn_message_redcircle"] forState:UIControlStateNormal];
    notifyBtn.hidden =YES;
    notifyBtn.frame = CGRectMake(16, -10, 20, 20);
    [button addSubview:notifyBtn];
    self.notifyByn = notifyBtn;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

/**
 *  加载内容ScrollView
 */
- (void)setupContentView
{
 
    UIScrollView * contentView= [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _contentView = contentView;
    [self.view addSubview:contentView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentView.showsHorizontalScrollIndicator = NO;
    self.contentView.backgroundColor = JDMColor(0xF0F0F0);
    self.contentView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.contentView.delegate = self;
    self.contentView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadBannerView];
        [self loadNews];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadMovies" object:nil];
    
    }];

}
/**
 *  添加通知按钮
 */
-(void)addNotify
{
    if (isUserLogin) {
        JDMNotify *notify = [JDMNotify viewFromNib];
        notify.frame = CGRectMake(0, 0, JDMScreenW, 25);
        self.notify = notify;
        [self.contentView addSubview:notify];
    }

}
/**
 *  加载Banner
 */
- (void)setBanner
{
    [self loadBannerView];
    GGBannerView * bannerView = [[GGBannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, JDMScreenH *0.23)];
    [self.contentView addSubview:bannerView];
    bannerView.backgroundColor =[UIColor redColor];
    bannerView.delegate =self;
    bannerView.scrollDirection = GGBannerViewScrollDirectionHorizontal;
    bannerView.interval = 2;
    self.bannerViews = bannerView;
    
}

/**
 *  加载Func功能模块
 */
- (void)addFuncBtnView
{
    [self loadData:@"homeSqaureBtn.json"];
    JDMFunctionView *functionView = [[JDMFunctionView alloc] init];;
    _functionView = functionView;
    [self.contentView addSubview:_functionView];
    self.functionView.totalColCount = 4;
    self.functionView.squares = self.sqaures;
    self.functionView.backgroundColor = [UIColor whiteColor];
    self.functionView.delegate = self;
    // functionView.backgroundColor = [UIColor redColor];
    
    self.functionView.frame = CGRectMake(0,CGRectGetMaxY(self.bannerViews.frame), self.view.width, CGRectGetMaxY([self.functionView.subviews lastObject].frame) + 15);
}

/**
 *  加载活动推荐模块
 */
- (void)addCommendView
{
//  [self loadNews];
    JDMCommendView *commendView = [JDMCommendView viewFromNib];
    _commendView = commendView;
    _commendView.CommendArray = @[@"home_img_activity1",@"home_img_activity2",@"home_img_activity3",@"home_img_activity4"];
    commendView.delegate = self;
    [self.contentView addSubview:_commendView];
     self.commendView.frame = CGRectMake(0, CGRectGetMaxY(self.functionView.frame) + JDMHomeViewMargin, self.view.width,JDMScreenH *0.26);
}
/**
 *  加载新闻模块
 */
- (void)addNewsView
{
//    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey: newsHistoryPath];
//    self.news = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
 
   
    JDMCommendView *commendView2 = [JDMCommendView viewFromNib];
    _newsView = commendView2;
    if(self.news.count !=0)
    {
        _newsView.NewsArray = self.news;
    }
    _newsView.delegate = self;
     [self loadNews];
    [_newsView.commendButton setTitle:@"热点新闻" forState:UIControlStateNormal];
    
    [self.contentView addSubview:_newsView];
    self.newsView.frame = CGRectMake(0, CGRectGetMaxY(self.commendView.frame) + JDMHomeViewMargin, self.view.width, JDMScreenH *0.28);

    
}
/**
 *  加载看视频赚流量模块
 */
- (void)addMovieFlowView
{
    JDMMovieFlowView *movieFlowView = [JDMMovieFlowView viewFromNib];
    _movieFlowView = movieFlowView;
    movieFlowView.delegate =self;
    [self.contentView addSubview:movieFlowView];
    self.movieFlowView.frame = CGRectMake(0, CGRectGetMaxY(self.newsView.frame) + JDMHomeViewMargin,JDMScreenW, JDMScreenH * 0.30);
    
    JDMMovieViewController *MovieFlowVc = [[JDMMovieViewController alloc] init];
    [self addChildViewController:MovieFlowVc];
    [self.movieFlowView addSubview: MovieFlowVc.view];
    self.contentView.contentSize = CGSizeMake(self.view.width, CGRectGetMaxY(movieFlowView.frame) + 70);
    
    
    [MovieFlowVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(movieFlowView.allButton.mas_bottom).offset([self movieViewProper]);
        make.left.equalTo(movieFlowView.mas_left);
        make.right.equalTo(movieFlowView.mas_right);
        make.bottom.equalTo(movieFlowView.mas_bottom);
        
    }];
}

/**
 *  看视频UI设配
 */
- (NSInteger)movieViewProper
{
    if (JDMScreenW == 320) {
        return 2;
    }else if (JDMScreenW == 375)
    {
        return 20;
    }else if (JDMScreenW == 414)
    {
        return 30;
    }
    return 40;
}
/**
 *  加载View显示后的资源
 */
-(void)userLogined
{
    if (userNoReadMsgList && isUserLogin) {
        
        self.notifyByn.hidden = NO;
        // self.tabBarItem.badgeValue=@"11";
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:userNoReadMsgList];
        [self.tabBarController.tabBar showBadgeOnItemIndex:0];
        [self.tabBarController.tabBar showBadgeOnItemIndex:4];
        self.notifyByn.hidden = NO;
        NSString *str = [NSString stringWithFormat:@"%ld",(long)userNoReadMsgList];
        [self.notifyByn setTitle:str forState:UIControlStateNormal];
        
    }else
    {
        [self.tabBarController.tabBar hideBadgeOnItemIndex:0];
        [self.tabBarController.tabBar hideBadgeOnItemIndex:4];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:userNoReadMsgList];
        self.notifyByn.hidden = YES;
    }
    
//    if ( isUserLogin && ![JDMUser shareUser].dataObj.isReadHomeMag) {
//        self.notify.frame = CGRectMake(0, 0, JDMScreenW, 25);
//        [self.contentView addSubview:self.notify];
//    }
    
    
}

/**
 *  判断是否需要通知签到
 */
-(void)isNeedSignIn
{
    static NSDateFormatter *formatter_ ;
    
    NSNumber * isNeedSignIn = [[NSUserDefaults standardUserDefaults] objectForKey:JDMSaveSignInSwitch];
    bool isOn = isNeedSignIn.boolValue;
    
    if (isOn) {
        formatter_ = [[NSDateFormatter alloc]init];
        formatter_.dateFormat = signFormatterStyle;
        
        NSString *nowString = JDMSignInDate;
        
        NSDate *nowDate = [formatter_ dateFromString:nowString];
        

        // 1.创建一个本地通知
        UILocalNotification *localNote = [[UILocalNotification alloc] init];
        
        localNote.fireDate = nowDate;
        
        localNote.repeatInterval = NSCalendarUnitDay;
        
        localNote.alertBody = localNoteAlertBody;
        
        localNote.alertAction = localNoteAlertAction;
        
        localNote.hasAction = YES;
        
        localNote.alertTitle = localNoteAlertTitle;
        
        localNote.soundName = UILocalNotificationDefaultSoundName;
        
        localNote.applicationIconBadgeNumber = 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNote];

    }else
    {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
    
}

#pragma mark - 外部控制方法

/**
 *  请求加载Banner图片数据
 */
- (void)loadBannerView
{
   
//    
 [self showLoadingHUD: JDMLoadingAwake andOffsetY:0];
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMBannerURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {

            self.banners = [JDMBanner mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
            NSMutableArray *arrayUrl = [NSMutableArray array];
            [self.banners enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                JDMBanner *banner = (JDMBanner *)obj;
                NSString *imageUrl = [NSString stringWithFormat:@"%@%@",JDMBaseURL,banner.imageurl];
                [arrayUrl addObject:imageUrl];
                
            }];
            [self.bannerViews configBanner:arrayUrl];
           
        }else{
            
            
        }
        
         
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
      
        
    }];
}
/**
 *  func模块数据请求
 */
- (void)loadData:(NSString *)fileName
{
    
    NSString *response = [[NSBundle mainBundle] pathForResource:fileName
                                                         ofType:nil];
    
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData: [NSData dataWithContentsOfFile:response]
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
    
    self.sqaures = [JDMSqaureBtn mj_objectArrayWithKeyValuesArray:json];
    
}

//新闻界面请求
-(void)loadNews
{
//   [self showLoadingHUD:HUD andStr: JDMLoadingAwake andOffsetY:0];
  
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNum"] =  @1;
    params[@"pageSize"] = @10;
    // 取消之前的所有请求
//    [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMNewsURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {

            [self.news removeAllObjects];
            self.news = [JDMNews mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
            _newsView.NewsArray = self.news;
            
            //归档活动数据
//            NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//            NSString *path = [file stringByAppendingString:@"/newsArray.plist"];
//            [[NSUserDefaults standardUserDefaults] setObject:path forKey:newsHistoryPath];
//            [NSKeyedArchiver archiveRootObject:self.news toFile:path];
            
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self showTextMsgHUD:responseObject[@"msg"] andOffsetY: 0];
            });
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
       !(self.news.count == 0) ?:[self showTextMsgHUD:JDMRequestErrorAwake andOffsetY: 0];
        
    }];

}

//我的信息跳转业务
- (void)MyMsgClick
{

    if(isUserLogin)
      {
          JDMLog(@"%d",isUserLogin);

//          JDMXBViewController *XBVc = [[JDMXBViewController alloc]init];
//          [self.navigationController pushViewController:XBVc animated:YES];
          JDMMyMsgViewController *myMSgVc = [[JDMMyMsgViewController alloc]init];
          [self.navigationController pushViewController:myMSgVc animated:YES];
       
      }else{
     JDMLoginViewController *LoginVc= [[JDMLoginViewController alloc]init];
     [self.navigationController pushViewController:LoginVc animated:YES];
      }
    
}
//二维码界面跳转
- (void)QRCodeClick
{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"JDMQRCodeViewController" bundle:nil];
    
    JDMQRCodeViewController *QRCodeVc =[sb instantiateInitialViewController];

    [self.navigationController pushViewController:QRCodeVc animated:YES];
}

#pragma mark - 代理方法

#pragma mark func功能模块 <JDMFunctionDelegate>
- (void)functionView:(JDMFunctionView *)funcView andSqaureButton:(UIButton *)sqaureBtn
{
    // 创建一个动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    // 缩放
    CABasicAnimation *animScale = [CABasicAnimation animation];
    animScale.keyPath = @"transform.scale";
    animScale.toValue = @1.5;

    CABasicAnimation *animAlpha = [CABasicAnimation animation];
    animAlpha.keyPath = @"opacity";
    animAlpha.fromValue = @1.0;
    animAlpha.toValue = @0.0;

   
    group.animations = @[animScale,animAlpha];

    group.duration = 0.35;
    group.delegate = self;
    
    [sqaureBtn.layer addAnimation:group forKey:nil];
    self.sqaureBtn = sqaureBtn;
    
}

#pragma mark 动画代理<CAAnimationDelegate>
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *str = self.sqaureBtn.titleLabel.text;
    UIViewController *jumpVc = nil;
    if ([str isEqualToString:@"兑换"]) {
        jumpVc = [[JDMexchangeViewController alloc]init];
        jumpVc.title = str;
        
    }else if([str isEqualToString:@"赠流量"])
    {
        jumpVc = [[JDMGiveFlowViewController alloc] init];
    }else if ([str isEqualToString:@"优惠劵"])
    {
        jumpVc = [[JDMFlowcurlyViewController alloc]init];
    }
    else if ([str isEqualToString:@"商场"])
    {
        jumpVc = [[JDMStoreViewController alloc]init];
    }
    else if ([str isEqualToString:@"查流量"])
    {
        jumpVc = [[JDMMyFlowViewController alloc]init];
    }
    else if ([str isEqualToString:@"红包"])
    {
        jumpVc = [[JDMRedBagViewController alloc]init];
    }
    else if ([str isEqualToString:@"签到"])
    {
        jumpVc = [[JDMSinginViewController alloc]init];
    }else if ([str isEqualToString:@"流量圈"])
    {
        jumpVc = [[JDMEarnedViewController alloc]init];
    }
    jumpVc.title = str;
    
    if (!isUserLogin) {
        JDMLoginViewController *loginVc = [[JDMLoginViewController alloc]init];
    [self.navigationController pushViewController: loginVc animated:YES];
    }
    else
    [self.navigationController pushViewController: jumpVc animated:YES];
    self.sqaureBtn.enabled =YES;
    
}

#pragma mark  commend代理<JDMCommendViewDelegate>
- (void)commendView:(JDMCommendView *)commendView allBtn:(UIButton *)AllBtn
{
    if (AllBtn.tag) {
        JDMMoreNewViewController * new1 = [[JDMMoreNewViewController alloc]init];
        JDMWitchMovieViewController * new2 = [[JDMWitchMovieViewController alloc]init];
        JDMMoreNewViewController * new3 = [[JDMMoreNewViewController alloc]init];
        JDMWitchMovieViewController * new4 = [[JDMWitchMovieViewController alloc]init];
        JDMMoreNewViewController * new5 = [[JDMMoreNewViewController alloc]init];
        SwipableViewController *newsSVC = [[SwipableViewController alloc] initWithTitle:@"热点新闻"andSubTitles:@[@"全部", @"体育", @"科技", @"娱乐",@"段子",@"全部", @"体育", @"科技", @"娱乐",@"段子"] andControllers:@[new1,new2,new3,new4,new5,new1,new2,new3,new4,new5]  underTabbar:NO];
        
        [self.navigationController pushViewController: newsSVC  animated:YES];


    }else{
    JDMActivityCommendViewController*activeVc = [[JDMActivityCommendViewController alloc] init];
          [self.navigationController pushViewController: activeVc  animated:YES];
    }
    
  
}

- (void)commendView:(JDMCommendView *)commendView activityButton:(JDMCommendBtn *)activeBtn
{
    if (activeBtn.isNews) {
        
        UIViewController *Vc = [[UIViewController alloc]init];
        Vc.view.backgroundColor = [UIColor whiteColor];
        Vc.title = @"新闻";
        NSString *urlstr = [NSString stringWithFormat:@"%@news/newsDetail?uuid=%@",JDMBaseURL,activeBtn.uuid];
        NSURL *url = [NSURL URLWithString:urlstr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        //    webView.delegate = self;
        [webView loadRequest:request];
        [Vc.view addSubview:webView];
        [self.navigationController pushViewController:Vc animated:YES];
     
    }else{
    JDMActivityCommendViewController *actiVc = [[JDMActivityCommendViewController alloc]init];
    [self.navigationController pushViewController:actiVc animated:YES];
    }
    
}

#pragma mark ScrollView代理<UIScrollViewDelegate>


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self.contentView.mj_header  endRefreshing];
    });
  
   
}


#pragma mark movieFlow代理<JDMMovieFlowViewDelegate>
- (void)movieFlowView:(JDMMovieFlowView *)movieFlowView
{
    JDMWitchMovieViewController *witchMovieVc = [[JDMWitchMovieViewController alloc]init];
    [self.navigationController pushViewController:witchMovieVc animated:YES];
}

#pragma mark banner功能模块 <GGBannerViewDelegate>
//自己选择imageView的加载方式
- (void)imageView:(UIImageView *)imageView loadImageForUrl:(NSString *)url
{
    
    [imageView setImageWithCurrentNetwork:[NSURL URLWithString:url] isWIFI:[JDMSwitchStatus getCurrentNetwork] isSwitchOn:[JDMSwitchStatus getFlowMangerSwitch] WIFIWithplaceholderImage:[UIImage imageNamed:@"home_banner_01"]];
 
    

//    imageView.image = [UIImage imageNamed:url];
    
}

/*  banner的点击回调*/
- (void)bannerView:(GGBannerView *)bannerView didSelectAtIndex:(NSUInteger)index;
{
    UIViewController *Vc = [[UIViewController alloc]init];
    Vc.view.backgroundColor = [UIColor whiteColor];
//    Vc.title = CurrentBannerBtn.titleLabel.text;
    Vc.title = @"活动详情";
    JDMBanner *banner =  self.banners[index];
    NSURL *url = [NSURL URLWithString:banner.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    webView.delegate = self;
    [webView loadRequest:request];
    [Vc.view addSubview:webView];
    [self.navigationController pushViewController:Vc animated:YES];
    
    
}


#pragma mark -懒加载
//-(JDMNotify *)notify
//{
//    if (!_notify) {
//        JDMNotify *notify =[JDMNotify viewFromNib];
//        _notify = notify;
//    }
//    return _notify;
//}
-(NSMutableArray *)news
{
    if (!_news) {
        _news = [NSMutableArray array];
    }
    return _news;
}
@end