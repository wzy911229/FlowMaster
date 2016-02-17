//
//  XMGPlaceholderTextView.h
//
//
//  Created by apple on 15/8/20.
//  Copyright (c) 2015年 wzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDMPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
