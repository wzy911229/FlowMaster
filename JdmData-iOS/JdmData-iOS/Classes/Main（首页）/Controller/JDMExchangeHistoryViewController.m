//
//  JDMExchangeHistoryViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMExchangeHistoryViewController.h"
#import <Masonry.h>

@interface JDMExchangeHistoryViewController ()

@end

@implementation JDMExchangeHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"兑换记录";
    [self addViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

-(void)addViews
{
    self.view.backgroundColor =[UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"ticket_icon_note"]];
    [self.view addSubview:imageView];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"您没有相关的记录";
    [self.view addSubview:label];


    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(imageView.mas_bottom).offset(20);
        
    }];
}

@end
