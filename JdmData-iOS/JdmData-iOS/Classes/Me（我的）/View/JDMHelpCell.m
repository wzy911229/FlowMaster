//
//  JDMHelpCell.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/21.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMHelpCell.h"
#import <Masonry.h>

@implementation JDMHelpCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        [self addViews];
    }
    return self;
}
-(void)addViews
{
    UILabel *label = [[UILabel alloc]init];
    [self addSubview:label];
    self.textlabel =label;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_rightarrow"]];
    [self addSubview:imageView];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-8);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
}
@end
