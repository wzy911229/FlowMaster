//
//  JDMSqaureButton.h
// 
//
//  Created by apple on 15/8/19.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDMSqaureBtn;

@interface JDMSqaureButton : UIButton
/** 方块按钮 */
@property (nonatomic, strong) JDMSqaureBtn *squareBtn;
/** 是否是赚流量界面方块按钮*/
@property (nonatomic, assign) bool range;

@end
