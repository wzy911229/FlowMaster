//
//  JDMTPublicCell.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/30.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMPublicCell.h"

@implementation JDMPublicCell

-(void)setFrame:(CGRect)frame
{
    frame.origin.y +=1;
    frame.size.height -=1;
//  frame.origin.y -=1;
    [super setFrame:frame];
}

@end
