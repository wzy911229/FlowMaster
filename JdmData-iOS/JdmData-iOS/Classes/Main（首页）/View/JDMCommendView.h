//
//  JDMCommendView.h
//  JdmData-iOS
//
//  Created by test1 on 15/11/13.
//  Copyright © 2015年 jdmdata. All rights reserved.
//  活动推荐

#import <UIKit/UIKit.h>
@class JDMCommendView,JDMCommendBtn;
@protocol JDMCommendViewDelegate <NSObject>

- (void)commendView:(JDMCommendView *)commendView  allBtn:(UIButton *)AllBtn;
- (void)commendView:(JDMCommendView *)commendView  activityButton:(JDMCommendBtn *)activeBtn;

@end


@interface JDMCommendView : UIView
@property (weak, nonatomic) IBOutlet UIView *view;

/** 标题颜色 */
@property (nonatomic, strong) NSArray *atnameColors;
/** 新闻模型数组 */
@property (nonatomic, strong) NSArray *NewsArray;
/** 推荐活动数组 */
@property (nonatomic, strong) NSArray *CommendArray;

@property (weak, nonatomic) IBOutlet UIButton *commendButton;

@property(nonatomic,weak) id<JDMCommendViewDelegate> delegate;

@end

@interface JDMCommendBtn : UIButton
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *atitle;
@property (weak, nonatomic) IBOutlet UIImageView *CommendImage;
/**是否是新闻模块*/
@property(nonatomic,assign) BOOL isNews;
/** uuid */
@property (nonatomic, copy) NSString *uuid;

@end
