//
//  UIBarButtonItem+JDMExtension.h
//
//
//  Created by apple on 15/8/15.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JDMExtension)
+ (instancetype)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
