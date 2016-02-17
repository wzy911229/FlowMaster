//
//  JDMSqaureButton.m
// 
//
//  Created by apple on 15/8/19.
//  Copyright (c) 2015年 JDM. All rights reserved.


#import "JDMSqaureButton.h"
#import "JDMSqaureBtn.h"
#import <UIButton+WebCache.h>

@implementation JDMSqaureButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
      self.titleLabel.numberOfLines= 3;
        self .titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:[JDMTools contentScriptProper]];
     [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}



- (void)setSquareBtn:(JDMSqaureBtn *)squareBtn
{
    _squareBtn = squareBtn;

    [self setTitle:squareBtn.name forState:UIControlStateNormal];

    [self setImage:[UIImage imageNamed:squareBtn.icon ] forState:UIControlStateNormal];
  
//    [self sd_setImageWithURL:[NSURL URLWithString:squareBtn.icon] forState:UIControlStateNormal];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.height =  self.range ?  self.width * JDMEarnedFuncBtnH : self.width * JDMHomeFuncBtnH;
    
    // 图片
    self.imageView.y = self.height* 0.15  ;
    // self.imageView.height = self.height * 0.55;
    self.imageView.width = self.imageView.height  ;
    self.imageView.centerX = self.width * 0.5;
    
    // 文字
    self.titleLabel.width = self.width;
    self.titleLabel.y = self.range ? CGRectGetMaxY(self.imageView.frame) - 10 : CGRectGetMaxY(self.imageView.frame)+5;
    self.titleLabel.height = self.height - self.titleLabel.y;
    self.titleLabel.x = 0;

//     self.contentEdgeInsets = UIEdgeInsetsMake(1, 1, 1, 1);

    if (self.range) {
    [self setBackgroundColor:[UIColor whiteColor]];
    }else{
        [self setBackgroundColor:[UIColor clearColor]];
    }

   
}

- (void)setFrame:(CGRect)frame
{
    
//    frame.origin.y +=1;
//    frame.origin.x +=1;
//    if (!self.isNeedLine) {
      frame.size.height -= 0.5;
      frame.size.width -= 0.5;
//    }
  
    [super setFrame:frame];
}

@end
