//
//  UIBarButtonItem+JDMExtension.m
//
//
//  Created by apple on 15/8/15.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import "UIBarButtonItem+JDMExtension.h"


@implementation UIBarButtonItem (JDMExtension)
+ (instancetype)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    
   
    return [[self alloc] initWithCustomView:button];
}
@end
