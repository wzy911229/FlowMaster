//
//  PopoverAnimtor.m
//  自定义专场
//
//  Created by test1 on 15/12/17.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMPopoverAnimtor.h"
#import "JDMPopoverPresentationController.h"

@interface JDMPopoverAnimtor ()
@property(nonatomic,assign)bool isPresent;
@end

@implementation JDMPopoverAnimtor

#pragma mark - UIViewControllerTransitioningDelegate

/**
 * 说明负责转场的对象
 */
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    
    JDMPopoverPresentationController *popVc = [[JDMPopoverPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    popVc.presentedFrame = self.presentedFrame ;
    popVc.coverAlpha =self.coverAlpha;
    popVc.coverColor =self.coverColor;
    return popVc;
    
}
/**
 * 说明负责转场样式的对象:即将展现
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    [[NSNotificationCenter defaultCenter] postNotificationName:JDMPopoverAnimatorDidShow object:self];
    self.isPresent =YES;
    return self;
}
/**
 * 说明负责转场消失的样式:即将消失
 */
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:JDMPopoverAnimatorDidDismiss object:self];
    self.isPresent =NO;
    return self;
}

#pragma mark- UIViewControllerAnimatedTransitioning

/**
 *  说明执行转场动画的时间
 */
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}
/**
 *  说明如何执行转场:展现,消失调用
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (_isPresent) {
        
        //拿到被弹出的控制器的View
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

        [transitionContext.containerView addSubview:toView];
        //自定义动画
        !self.customPresentAnimate ? [self defaultPresentAnimate:toView] : self.customPresentAnimate(toView);
        
        toView.transform =CGAffineTransformMakeScale(1.0, 0.0);
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [UIView animateWithDuration: 0.35 animations:^{
            toView.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
             [transitionContext completeTransition:YES];
        }
         ];
        
    }else
    {
        UIView *fromView =  [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        //自定义动画
//        !self.customDismissAnimate ? [self defaultDismissAnimate:fromView] : self.customDismissAnimate(fromView);
        
        [UIView animateWithDuration: 0.35 animations:^{
            fromView.transform = CGAffineTransformMakeScale(1.0, 0.0000001);
        }completion:^(BOOL finished) {
             [transitionContext completeTransition:YES];
        }
         ];
       
     
    }
    
    
}
- (void)defaultPresentAnimate:(UIView *)toView
{

    
    
}
-(void)defaultDismissAnimate:(UIView *)fromView
{

    
}

@end