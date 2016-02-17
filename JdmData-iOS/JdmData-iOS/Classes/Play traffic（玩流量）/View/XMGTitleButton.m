//
//  XMGTitleButton.m
//  2期-百思不得姐
//
//  Created by apple on 15/8/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGTitleButton.h"

@implementation XMGTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

/**
*  重写这个方法的目的：去掉父类在highlighted时做的一切操作
*/
- (void)setHighlighted:(BOOL)highlighted {}

@end
