//
//  JDMProgressView.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/7.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMProgressView.h"


@implementation JDMProgressView

- (void)awakeFromNib
{
    self.progressLabel.textColor = [UIColor blackColor];
    self.progressLabel.font = [UIFont boldSystemFontOfSize:60];
    self.trackTintColor = JDMColor(0xF0F0F0);
    self.progressTintColor= JDMColor(0x3492E9);
    self.indeterminateDuration = 4;
    self.roundedCorners = 1;
    self.clockwiseProgress = 0;
    self.thicknessRatio = 0.18;
  
}

- (void)setProgress:(CGFloat)progress
{
    [super setProgress:progress];
    
    NSString *text = [NSString stringWithFormat:@"%.0f", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
}

@end
