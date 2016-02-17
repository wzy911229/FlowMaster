//
//  JDMHUBView.h
//  JdmData-iOS
//
//  Created by test1 on 15/11/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//  我的流量蒙版

#import <UIKit/UIKit.h>
@class JDMHUBView;

@protocol JDMHUBViewDelegate <NSObject>

- (void)HUBView:(JDMHUBView *)HUBView touchSetBtn:(UIButton *)setBtn;
- (void)HUBView:(JDMHUBView *)HUBView touchCancleBtn:(UIButton *)CancleBtn;

@end

@interface JDMHUBView : UIView
@property (nonatomic,weak) id<JDMHUBViewDelegate> delegate;

@end
