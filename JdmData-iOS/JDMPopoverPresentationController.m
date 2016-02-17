//
//  PopoverPresentationController.m
//  自定义专场
//
//  Created by test1 on 15/12/17.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMPopoverPresentationController.h"

@interface JDMPopoverPresentationController ()
/** 蒙版*/
@property(nonatomic,strong) UIView *coverView;

@end

@implementation JDMPopoverPresentationController

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    self.presentedView.frame = self.presentedFrame;
    [self.containerView insertSubview:self.coverView atIndex:0];
    
}
- (UIView *)coverView
{
    if (!_coverView) {
        UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];

        view.backgroundColor = self.coverColor  ? self.coverColor :[UIColor blackColor];
        view.alpha = self.coverAlpha ? self.coverAlpha : 0.03;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCover)];
        [view addGestureRecognizer:tap];
        _coverView = view;
    }
    return _coverView;
}

//点击蒙版退出控制器
-(void)clickCover
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
