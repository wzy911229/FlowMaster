//
//  UIView+ZYExtension.h
//  
//
//  Created by apple on 15/8/15.
//  Copyright (c) 2015年 JDM. All rights reserved.
// 快捷设置frame,center

#import <UIKit/UIKit.h>

@interface UIView (JDMExtension)
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

+ (instancetype)viewFromNib;
- (void)largeScaleProper;
- (void)smallScaleProper;
@end


