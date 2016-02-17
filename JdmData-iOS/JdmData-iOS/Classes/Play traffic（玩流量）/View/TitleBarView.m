//
//  TitleBarView.m
//  iosapp
//
//  Created by chenhaoxiang on 14-10-20.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import "TitleBarView.h"


@interface TitleBarView ()

@end

@implementation TitleBarView

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    
    if (self) {

        _currentIndex = 0;
        _titleButtons = [NSMutableArray array];
        
        CGFloat buttonWidth = 40;
        CGFloat buttonHeight = frame.size.height;
        
        [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.backgroundColor = [UIColor titleBarColor];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[UIColor colorWithHex:0x909090] forState:UIControlStateNormal];
            [button setTitle:title forState:UIControlStateNormal];
            
            button.frame = CGRectMake((buttonWidth + 30)*idx, 0, buttonWidth, buttonHeight);
            button.tag = idx;
            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [_titleButtons addObject:button];
            [self addSubview:button];
            [self sendSubviewToBack:button];
        self.contentSize = CGSizeMake( CGRectGetMaxX(button.frame) , 25);
        }];
        
//        self.contentSize = CGSizeMake(frame.size.width, 25);
        self.showsHorizontalScrollIndicator = NO;
        self.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
        self.contentOffset = CGPointMake(- 20, 0);
        UIButton *firstTitle = _titleButtons[0];
        [firstTitle setTitleColor:[UIColor colorWithHex:0x3492E9] forState:UIControlStateNormal];
        firstTitle.transform = CGAffineTransformMakeScale(1.15, 1.15);
    }
    
    return self;
}


- (void)onClick:(UIButton *)button
{
    if (_currentIndex != button.tag) {
        UIButton *preTitle = _titleButtons[_currentIndex];
        
        [preTitle setTitleColor:[UIColor colorWithHex:0x909090] forState:UIControlStateNormal];
        preTitle.transform = CGAffineTransformIdentity;
        
        [button setTitleColor:[UIColor colorWithHex:0x3492E9] forState:UIControlStateNormal];
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        _currentIndex = button.tag;
        _titleButtonClicked(button.tag);
        
        if (_currentIndex >= 3 && _currentIndex <= (self.titleButtons.count-3)) {
            
            [self setContentOffset:CGPointMake( button.x - JDMScreenW/2 +button.width/2  , 0) animated:YES];
        }else if(_currentIndex <= 3)
        {
            [self setContentOffset:CGPointMake(-20 , 0) animated:YES];
            
        }else
        {
            CGSize size = self.contentSize;
            [self setContentOffset:CGPointMake( size.width -JDMScreenW+20 , 0) animated:YES];
        }
    }
}

- (void)setTitleButtonsColor
{
    for (UIButton *button in self.subviews) {
        button.backgroundColor = [UIColor titleBarColor];
    }
}

@end
