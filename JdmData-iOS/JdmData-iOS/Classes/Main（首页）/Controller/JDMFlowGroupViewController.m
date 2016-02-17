//
//  JDMFlowGroupViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/10.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMFlowGroupViewController.h"
#import "JDMUserInfoTools.h"

@interface JDMFlowGroupViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak) UIScrollView *contentScroll;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

@end

@implementation JDMFlowGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.phoneNum.text = [NSString stringWithFormat:@"%ld",(long)[JDMUserInfoTools getUserPhoneNumber]];
}


-(void)addContentScroll
{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scroll.delegate = self;
    scroll.backgroundColor = JDMColor(0xF0F0F0);
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.alwaysBounceVertical = NO;
    scroll.contentSize = JDMScreenBounds.size;
    [self.view addSubview:scroll];
    self.contentScroll =scroll;
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
