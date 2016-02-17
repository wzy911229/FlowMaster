//
//  PopoverPresentationController.h
//  自定义专场
//
//  Created by test1 on 15/12/17.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDMPopoverPresentationController : UIPresentationController

@property(nonatomic,assign) CGRect  presentedFrame;
/**蒙版颜色*/
@property(nonatomic,strong) UIColor * coverColor;
/**蒙版透明度*/
@property(nonatomic,assign) NSInteger coverAlpha;

@end
