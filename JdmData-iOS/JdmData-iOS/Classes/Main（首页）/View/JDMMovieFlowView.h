//
//  JDMMovieFlowView.h
//  JdmData-iOS
//
//  Created by test1 on 15/11/13.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDMMovieFlowView;
@protocol JDMMovieFlowViewDelegate <NSObject>

-(void)movieFlowView:(JDMMovieFlowView*)movieFlowView;

@end

@interface JDMMovieFlowView : UIView
@property (weak, nonatomic) IBOutlet UIButton *allButton;

//@property (weak, nonatomic) IBOutlet UIView *contextView;
@property (weak, nonatomic) id<JDMMovieFlowViewDelegate> delegate;
@end
