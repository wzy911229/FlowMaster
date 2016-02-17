//
//  JDMXBViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/17.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMXBViewController.h"

@interface JDMXBViewController ()



@end

@implementation JDMXBViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor =[UIColor whiteColor];
    [self setupSegment];
 
    
}
#pragma mark - 内部控制方法
/**
 *  添加segment标签
 */
-(void)setupSegment
{
    UISegmentedControl *segment =[[UISegmentedControl alloc] initWithItems:@[@"流量币介绍",@"如何赚",@"可以兑换什么"]];
    
    segment.width = self.view.width / 1.2;
    segment.center = CGPointMake(self.view.center.x, 100);
    [segment addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    [self.view addSubview:segment];
}
#pragma mark - 外部控制方法
/**
 *  监听segment变化
 */
- (void)clickSegment:(UISegmentedControl *)segment
{
    JDMLog(@"%ld",(long)segment.selectedSegmentIndex);
}


@end
