//
//  UIView+ZYExtension.m
//
//
//  Created by apple on 15/8/15.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import "UIView+JDMExtension.h"

@implementation UIView (JDMExtension)

+ (instancetype)viewFromNib {
    
    return  [[[NSBundle mainBundle]loadNibNamed: NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}
- (void)largeScaleProper
{
    if (JDMScreenW == 414) {
        self.transform = CGAffineTransformMakeScale(1.12, 1.12);
    }
        
}
- (void)smallScaleProper
{
    if (JDMScreenW == 320){
        self.transform = CGAffineTransformMakeScale(0.9 , 0.9);
    }
    
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

@end
