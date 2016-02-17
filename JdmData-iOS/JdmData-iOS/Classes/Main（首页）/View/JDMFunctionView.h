//
//  JDMFunctionView.h
//  JdmData-iOS
//
//  Created by test1 on 15/11/12.
//  Copyright © 2015年 jdmdata. All rights reserved.
//  func功能模块视图

#import <UIKit/UIKit.h>
@class JDMFunctionView,JDMSqaureButton;

@protocol JDMFunctionDelegate <NSObject>
- (void)functionView:(JDMFunctionView *)funcView andSqaureButton:(JDMSqaureButton *)sqaureBtn;

@end

@interface JDMFunctionView : UIView
/** 功能按钮数组*/
@property (nonatomic, strong) NSArray *squares;
/** 创建每行按钮个数*/
@property (nonatomic, assign) NSInteger totalColCount;

@property (nonatomic,weak) id<JDMFunctionDelegate> delegate;

/**
 *  快速创建
 */
+ (instancetype)functionView;


@end
