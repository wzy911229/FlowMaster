//
//  JDMActivityViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMActivityViewController.h"
#import "JDMCommend.h"
@interface JDMActivityViewController ()

@end

@implementation JDMActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
    // Vc.title = CurrentBannerBtn.titleLabel.text;
    self.title = @"活动详情";

    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
  
    [self.view addSubview:webView];
    
    NSURL *url =  [NSURL URLWithString:self.linkUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    webView.delegate = self;
    [webView loadRequest:request];
}

-(void)setLinkUrl:(NSString *)linkUrl
{
     _linkUrl = linkUrl;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
