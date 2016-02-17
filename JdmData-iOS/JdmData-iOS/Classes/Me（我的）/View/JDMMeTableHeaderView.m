//
//  JDMMeTableHeaderView.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/16.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMeTableHeaderView.h"
#import "JDMUserInfoTools.h"

@interface JDMMeTableHeaderView ()
/**  整个头部控件 */
@property (weak, nonatomic) IBOutlet UIView *headerBtn;
/**  登陆后显示的View */
@property (weak, nonatomic) IBOutlet UIView *loginView;
/**  未登陆后显示的View */
@property (weak, nonatomic) IBOutlet UILabel *beforeLoginView;
/**   用户昵称 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/**   用户手机号 */
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
/**  用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;
/** 设置字体设配*/
@property (weak, nonatomic) IBOutlet UILabel *FlowLabel;
/** 设置字体设配*/
@property (weak, nonatomic) IBOutlet UILabel *G;
/** 设置字体设配*/
@property (weak, nonatomic) IBOutlet UILabel *flowUnit;
/** 设置字体设配*/
@property (weak, nonatomic) IBOutlet UILabel *GUnit;
/** 设置字体设配*/
@property (weak, nonatomic) IBOutlet UILabel *flowNum;
/** 设置字体设配*/
@property (weak, nonatomic) IBOutlet UILabel *GNum;


@end

@implementation JDMMeTableHeaderView


- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickHeaderBtn)];
    [self addGestureRecognizer:tap];
    self.loginView.hidden = YES;
    [self userLogined];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogined) name:@"isUserHaveLogined" object:nil];
    [self proper];
   
}
/**
 *  界面字体设配
 */
-(void)proper
{
    self.userName.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.userPhone.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.FlowLabel.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.G.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.flowUnit.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.GUnit.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.flowNum.font =[UIFont systemFontOfSize:[self flowProper]];
    self.GNum.font =[UIFont systemFontOfSize:[self flowProper]];
}
/**
 *  流量信息,G币适配
 */
-(NSInteger)flowProper
{
    if (JDMScreenW == 320) {
        return 18;
    }else if (JDMScreenW == 375)
    {
        return 22;
    }else if (JDMScreenW == 414)
    {
        return 25;
    }
    return 28;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, self.width,260);
    
}

//判断加载的启动时的资源
- (void)userLogined
{
    
    if (isUserLogin) {
        [self reloadUserInfo];
        self.beforeLoginView.hidden = YES;
        self.loginView.hidden = NO;
        self.userPhone.text =  [NSString stringWithFormat:@"%ld",(long)[JDMUserInfoTools getUserPhoneNumber]];
    }else{
        self.beforeLoginView.hidden = NO;
        self.loginView.hidden = YES;
        self.userName.text = @"未登录";
        self.userHeadImage.image = [UIImage imageNamed:@"my_icon_people"];

    }
   
}
-(void)reloadUserInfo
{
    NSData *data = [JDMUserInfoTools getUserBigIcon];
    if (data) {
         self.userHeadImage.image = [UIImage imageWithData:data];
    }
     self.userName.text = [JDMUserInfoTools getUserName];
}

- (IBAction)clickBuyFlowBtn {
   
    if ([_delegate  respondsToSelector:@selector(meTableHeaderViewClickBuyFlowBtn:)]) {
        [_delegate meTableHeaderViewClickBuyFlowBtn:self];
    }
    
}

- (IBAction)ClickExChangeFlowBtn {
    if ([_delegate  respondsToSelector:@selector(meTableHeaderViewClickExChangeFlowBtn:)]) {
        [_delegate meTableHeaderViewClickExChangeFlowBtn:self];
    }
    
}

- (void)ClickHeaderBtn
{
    if ([_delegate  respondsToSelector:@selector(meTableHeaderView:)]) {
        [_delegate meTableHeaderView:self];
    }
    
}
//- (void)setFrame:(CGRect)frame
//{
//    [super frame];
//    
//}
@end
