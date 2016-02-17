//
//  JDMEarnedFlowCell.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/17.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMEarnedFlowCell.h"
#import "JDMEarnedFlow.h"
#import <UIImageView+WebCache.h>
#import "JDMCommend.h"
#import "JDMSwitchStatus.h"
#import "UIImageView+JDMExtension.h"

@interface JDMEarnedFlowCell ()
/** 注释 */
@property (nonatomic, weak) UIImageView *imgView;
/** 注释 */
@property (nonatomic, weak) UILabel  * flowLabel;

@end

@implementation JDMEarnedFlowCell


- (void)setEaenedFlow:(JDMCommend *)EaenedFlow
{
    _EaenedFlow = EaenedFlow;
    
       NSString*  imageUrl = [NSString stringWithFormat:@"%@%@",JDMBaseURL,EaenedFlow.imageurl];
    
    [self.imgView setImageWithCurrentNetwork:[NSURL URLWithString:imageUrl] isWIFI:[JDMSwitchStatus getCurrentNetwork] isSwitchOn:[JDMSwitchStatus getFlowMangerSwitch] WIFIWithplaceholderImage:[UIImage imageNamed:@"activity_img_02"]];
    
//    [JDMSwitchStatus getCurrentNetwork] ? [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"activity_img_02"]] : [self.imgView setImage:[UIImage imageNamed:@"activity_img_02"]];
    
    self.flowLabel.text = @"流量活动";
    self.flowLabel.text = EaenedFlow.atname;

    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
//    self.imgView.frame = CGRectMake(15, 15, self.width - 30 , JDMEarnedCellH - 30);
    self.flowLabel.frame = CGRectMake(0, 15, self.width * 0.28, self.height * 0.15);
     self.imgView.frame = CGRectMake(0, 0, self.width , self.height);
//    [UIView animateWithDuration:0.4 animations:^{
//
//    }];

}
#pragma mark - 懒加载
- (UIImageView *)imgView
{
    if (!_imgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        _imgView = imgView;

    }
    return _imgView;
}
- (UILabel *)flowLabel
{
    if (!_flowLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = JDMRGBColor(0, 0, 0, 0.5);
        label.textAlignment = NSTextAlignmentCenter;
        //    label.enabled = NO ;
        _flowLabel = label;
        [self.imgView addSubview:label];

    }
    return _flowLabel;
}

@end
