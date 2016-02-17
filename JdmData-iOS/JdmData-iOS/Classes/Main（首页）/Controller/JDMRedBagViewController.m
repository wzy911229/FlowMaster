//
//  JDMRedBagViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/19.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMRedBagViewController.h"
#import "UMSocial.h"

@interface JDMRedBagViewController ()<UMSocialUIDelegate>

@end

@implementation JDMRedBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"play_icon_cyc"] style:UIBarButtonItemStylePlain target:self action:@selector(clickShareBtn)];
    
 
}

- (void)clickShareBtn
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"566a1bff67e58e4e2700337b"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToRenren,UMShareToSms,UMShareToWechatFavorite, nil]
                                       delegate:self];
}



@end
