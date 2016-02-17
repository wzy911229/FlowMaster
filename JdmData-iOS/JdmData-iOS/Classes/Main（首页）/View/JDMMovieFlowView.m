//
//  JDMMovieFlowView.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/13.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMovieFlowView.h"

#import "JDMMovieViewController.h"

@interface JDMMovieFlowView ()
@property (weak, nonatomic) IBOutlet UILabel *movie;


@end

@implementation JDMMovieFlowView

- (IBAction)clickAllBtn {
    
    
    if ([_delegate respondsToSelector:@selector(movieFlowView:)]) {
        [_delegate movieFlowView:self];
    }
}

-(void)awakeFromNib
{
    
    self.movie.font = [UIFont systemFontOfSize: [JDMTools titleScriptProper]];
    self.allButton.titleLabel.font = [UIFont systemFontOfSize: [JDMTools titleScriptProper]];
}


@end
