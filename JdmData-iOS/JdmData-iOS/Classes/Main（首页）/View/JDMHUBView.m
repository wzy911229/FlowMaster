//
//  JDMHUBView.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMHUBView.h"
@interface JDMHUBView ()
@property (weak, nonatomic) IBOutlet UILabel *awakeLabel;


@end
@implementation JDMHUBView

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.awakeLabel.font = [UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.y =  - 20;
}
- (IBAction)clickSetBtn:(UIButton*)sender {
    
    if ([_delegate respondsToSelector:@selector(HUBView:touchSetBtn:)])
    {
        [_delegate HUBView:self touchSetBtn:sender];
    }
    
}
- (IBAction)clickCancleBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(HUBView:touchCancleBtn:)])
         {
             [_delegate HUBView:self touchCancleBtn:sender];
         }
         
}



@end
