//
//  JDMMeTableHeaderView.h
//  JdmData-iOS
//
//  Created by test1 on 15/11/16.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDMMeTableHeaderView;
@protocol JDMMeTableHeaderViewDelegate <NSObject>

-(void)meTableHeaderView:(JDMMeTableHeaderView *)MeTableHeaderView;
-(void)meTableHeaderViewClickExChangeFlowBtn:(JDMMeTableHeaderView *)MeTableHeaderView;
-(void)meTableHeaderViewClickBuyFlowBtn:(JDMMeTableHeaderView *)MeTableHeaderView;

@end


@interface JDMMeTableHeaderView : UIView

@property (nonatomic,weak) id<JDMMeTableHeaderViewDelegate> delegate;
/** 头部视图高度约束对象 */
@property (nonatomic, strong)  NSLayoutConstraint *headViewHCons;

@end
