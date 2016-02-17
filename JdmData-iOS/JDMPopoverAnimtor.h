//
//  PopoverAnimtor.h
//  自定义专场
//
//  Created by test1 on 15/12/17.
//  Copyright © 2015年 jdmdata. All rights reserved.
//



#import <UIKit/UIKit.h>

#define JDMPopoverAnimatorDidShow  @"JDMPopoverAnimatorDidShow"
#define JDMPopoverAnimatorDidDismiss  @"JDMPopoverAnimatorDidDismiss"
@interface JDMPopoverAnimtor : UIPresentationController<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
/**蒙版透明度*/
@property(nonatomic,assign) NSInteger coverAlpha;
/**蒙版颜色*/
@property(nonatomic,strong) UIColor * coverColor;
/**展现尺寸*/
@property(nonatomic,assign) CGRect presentedFrame;
/**展现动画*/
@property(nonatomic,copy)void(^customPresentAnimate)(UIView *toView);
/**消失动画*/
@property(nonatomic,copy)void(^customDismissAnimate)(UIView *fromView);

@end
