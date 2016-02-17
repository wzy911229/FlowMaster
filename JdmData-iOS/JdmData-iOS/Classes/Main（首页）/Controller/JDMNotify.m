//
//  JDMNotify.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/10.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMNotify.h"

@interface JDMNotify ()
/** */
@property (weak, nonatomic) IBOutlet UILabel *notify;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLayout;
@property (weak, nonatomic) IBOutlet UIView *view;

@end
@implementation JDMNotify

- (void)awakeFromNib
{
    self.notify.text = @"精迪敏数据是一家中国本土的、以国际化为导向的，专注于移动网络数据流量智能管理和优化领域,提供完整的移动数据产品和整体解决方案的提供商";
        [self msgAnimation];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickCancleButton) name:@"isUserHaveLogined" object:nil];

}
//消息动画
-(void)msgAnimation
{
    CGSize titleSize = [ self.notify.text sizeWithFont:self.notify.font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
     self.alpha = 0;
    self.y = -self.height;
    [UIView animateWithDuration:0.8 animations:^{
        self.alpha = 1;
        self.y =0;
    } completion:^(BOOL finished) {
        
        self.labelLayout.constant = - titleSize.width - (JDMScreenW - 2.0 * self.view.width);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationRepeatCount:MAXFLOAT];
        [UIView setAnimationDuration:titleSize.width/30];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [self layoutIfNeeded];
        self.alpha =1;
        [UIView commitAnimations];
        
    }];
   

}
//删除首页消息
- (IBAction)clickCancleButton {
    [UIView animateWithDuration:0.8 animations:^{
            self.alpha =0;
        self.y = - self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
//        [JDMUser shareUser].dataObj.isReadHomeMag = YES;
        
    }];
//    [JDMUser shareUser].dataObj.isReadMsg = YES;
}

@end
