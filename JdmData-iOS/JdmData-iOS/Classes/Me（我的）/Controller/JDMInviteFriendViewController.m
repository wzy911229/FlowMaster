//
//  JDMInviteFriendViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/1.
//  Copyright © 2015年 jdmdata. All rights reserved.
//
/**
 
 当分享消息类型为图文时，点击分享内容会跳转到预设的链接，设置方法如下
 
 [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
 
 如果是朋友圈，则替换平台参数名即可
 
 [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
 
 注意设置的链接必须为http链接
 
 
 2.4.4  设置title
 设置微信好友title方法为
 
 [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信好友title";
 
 设置微信朋友圈title方法替换平台参数名即可
 
 [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信朋友圈title";
 
 微信朋友圈分享消息只显示title
 
 
 2.4.5  设置分享消息类型
 微信分享消息类型分为图文、纯图片、纯文字、应用三种类型，默认分享类型为图文分享，即展示分享文字及图片缩略图，点击后跳转到预设链接
 
 纯图片分享类型方法为
 
 [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
 
 纯图片分享类型没有文字，点击图片可以查看大图
 
 纯文字分享类型方法为
 
 [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
 
 纯文字分享类型没有图片，点击不会跳转
 
 应用分享类型方法
 
 [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
 
 应用分享类型点击分享内容后跳转到应用下载页面，下载地址自动抓取开发者在微信开放平台填写的应用地址，如果用户已经安装应用，则打开APP
 
 */

#import "JDMInviteFriendViewController.h"
#import "JDMinViteHeaderView.h"
#import "JDMAddressListViewController.h"
#import "UMSocial.h"
@interface JDMInviteFriendViewController ()<UMSocialUIDelegate>

@end

@implementation JDMInviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.title = @"邀请好友";
    self.tableView.estimatedRowHeight = 50;
    [self setupTableView];
    [self setupGroup0];

    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setupTableView
{

    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JDMScreenW, 60)];
    UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [inviteBtn setTitle:@"复制邀请信息" forState:UIControlStateNormal];
    [inviteBtn setTitleColor:JDMColor(0x3492e9) forState:UIControlStateNormal];
    [inviteBtn setBackgroundImage:[UIImage imageNamed:@"my_btn_yqxx"] forState:UIControlStateNormal];
    inviteBtn.frame = CGRectMake(0, 0,JDMScreenW -40, 44);
    inviteBtn.center =View.center;
    [View addSubview:inviteBtn];
    self.tableView.tableFooterView = View;
//    self.tableView.sectionFooterHeight = 50;
    
    
    JDMinViteHeaderView *headerView = [JDMinViteHeaderView viewFromNib];
    headerView.height = JDMScreenH *0.3;
    [self.tableView setTableHeaderView: headerView];
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
}

- (void)setupGroup0
{
    JDMSettingArrowItem *item0 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"my_icon_txl"]title:@"从通讯录邀请"];
    item0.descVc = [JDMAddressListViewController class];
    
    JDMSettingArrowItem *item1 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"my_icon_weibo"] title:@"从微博邀请"];
    [item1 setOperationBlock:^(NSIndexPath * indexpath) {
        
        [[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"icon"] socialUIDelegate:self];        //设置分享内容和回调对象
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }];

    
    JDMSettingArrowItem *item2 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"my_icon_weixin"]title:@"从微信邀请"];
    [item2 setOperationBlock:^(NSIndexPath * indexpath) {
        
        //使用UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite分别代表微信好友、微信朋友圈、微信收藏
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                JDMLog(@"分享成功！");
            }
        }];
        
        
    }];
    
    JDMSettingArrowItem *item3 = [JDMSettingArrowItem itemWithImage:[UIImage imageNamed:@"my_icon_yixin"] title:@"从人人网邀请"];
    [item3 setOperationBlock:^(NSIndexPath * indexpath) {
        [self share:UMShareToRenren];
    }];
    
    JDMGroupItem *group = [JDMGroupItem groupWithItems:@[item0,item1,item2,item3]];
    [self.groups addObject:group];
}

//分享方法
-(void)share:(NSString*)shareName
{
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"icon"] socialUIDelegate:self];
    
    //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:shareName].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}

//分享回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        JDMLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

@end
