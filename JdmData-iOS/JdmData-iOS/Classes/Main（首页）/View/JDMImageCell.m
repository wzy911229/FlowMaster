//
//  JDMImageCell.m
//  01_图片左右缩放
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import "JDMImageCell.h"
#import "JDMMovie.h"
#import <UIButton+WebCache.h>

@interface JDMImageCell()
/** 图片 */
@property (nonatomic, weak) UIImageView *imgView;

/** 播放按钮 */
@property (nonatomic, weak)JDMMovieBtn *Moviebtn;

@end

@implementation JDMImageCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
        
    }
    return self;
}

- (void)addSubviews
{
    
    JDMMovieBtn *Moviebtn = [JDMMovieBtn buttonWithType:UIButtonTypeCustom];
    [self addSubview:Moviebtn];
    self.Moviebtn = Moviebtn;
  
}


-(void)setMovie:(JDMMovie *)movie
{
    _movie = movie;
    
    [self.Moviebtn  sd_setBackgroundImageWithURL:[NSURL URLWithString:movie.listimgurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"home_videoimage_01"]];
}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.Moviebtn.frame =self.bounds;
}

@end



@interface JDMMovieBtn()

/** 播放按钮图片 */
@property (nonatomic, weak) UIImageView  *playImageView;

@end
@implementation JDMMovieBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *playImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_icon_video"]];
        
        playImageView.userInteractionEnabled = NO;
        self.playImageView =playImageView;
        [self addSubview:playImageView];
        self.userInteractionEnabled = NO;
//      [self addTarget:self action:@selector(clickMovieBtn:) forControlEvents:UIControlEventTouchUpInside];
     
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.playImageView.center = self.center;
}

@end