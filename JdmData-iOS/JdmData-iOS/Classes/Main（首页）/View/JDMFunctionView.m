//
//  JDMFunctionView.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/12.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMFunctionView.h"
#import "JDMSqaureButton.h"
#import "JDMSqaureBtn.h"


@implementation JDMFunctionView

+ (instancetype)functionView
{
    return [[self alloc] init];
}


-(void)setSquares:(NSArray *)squares
{
    _squares = squares;
   [self createSquareBtns:_squares];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

/**
 *  创建方块按钮
 */
- (void)createSquareBtns:(NSArray *)squareBtns
{
    NSUInteger count = squareBtns.count;
    NSInteger totalColCount = self.totalColCount;
    CGFloat buttonW = JDMScreenW / totalColCount;
    CGFloat buttonH = JDMScreenW / 4.4;
//    CGFloat ButtonEarrnedH = 70;
    for (int i = 0; i < count; i++) {
        // 创建按钮
        JDMSqaureButton *button = [JDMSqaureButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.range = (totalColCount == 3);
        // 计算frame
        button.width = buttonW ;
        button.height = buttonH;
        button.x = (i % totalColCount) * buttonW;
        button.y = (i / totalColCount) * buttonH;
        
        // 设置数据
        button.squareBtn = squareBtns[i];
       // 设置高度
        self.height = CGRectGetMaxY(button.frame);
    }
    
}

/**
 *  监听那个按钮被点击
 */
- (void)buttonClick:(JDMSqaureButton *)btn
{
    btn.enabled = btn.range;
    if([_delegate respondsToSelector:@selector(functionView:andSqaureButton:)])
    {
        [_delegate functionView:self andSqaureButton:btn];
    }
}

@end
