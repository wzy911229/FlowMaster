//
//  JDMSimpleMovieViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/8.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMSimpleMovieViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "JDMMovie.h"
#import <UIButton+WebCache.h>

static  NSTimeInterval playbackTime = 0;
@interface JDMSimpleMovieViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** 电影介绍 */
@property (weak, nonatomic) IBOutlet UITextView *movieInfo;
/** 电影彩页Button */
@property (weak, nonatomic) IBOutlet UIButton *playMovieView;
/** 观看次数 */
@property (weak, nonatomic) IBOutlet UILabel *playerCount;
/** 播放器 */
@property (nonatomic, strong)MPMoviePlayerViewController *playerVc;

@end

@implementation JDMSimpleMovieViewController
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self notificationcenter];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.playerCount.text = [NSString stringWithFormat:@"%ld次观看",(long)self.movie.playcount];
    self.movieInfo.text = self.movie.info;
    [self.playMovieView sd_setBackgroundImageWithURL:[NSURL URLWithString:self.movie.homeimgurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"153325.91144936_1000X1000"]];
    self.title = self.movie.name;
    
 
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    playbackTime = self.playerVc.moviePlayer.currentPlaybackTime;
}

#pragma mark - 内部控制方法
- (void)notificationcenter
{
    [[ NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(playingStart) name: MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
    
    [[ NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(playingDone) name: MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willExitFullScreen) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    
}
/**
 *  设置数据
 */
- (void)setMovie:(JDMMovie *)movie
{
    _movie = movie;

}

/**
 *  结束全屏
 */
-(void)willExitFullScreen
{
     [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

//开始播放:实现续播放
-(void)playingStart
{
     [_playerVc.moviePlayer setCurrentPlaybackTime:playbackTime];
}

/**
 *  结束播放
 */
-(void)playingDone
{
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    
   [super didReceiveMemoryWarning];
}

#pragma mark - 外部控制方法
- (IBAction)clickMovieButton:(UIButton *)sender {
    self.playerVc.view.frame = CGRectMake(0, 0, JDMScreenW, _playMovieView.height);
    [self.scrollView addSubview: self.playerVc.view];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}
#pragma mark - 懒加载
- (MPMoviePlayerViewController *)playerVc
{
    if (_playerVc == nil) {
        NSURL *url = [NSURL URLWithString:self.movie.videourl];
        //     dispatch_queue_t queue  =   dispatch_get_global_queue(0, 0);
        //        dispatch_async(queue, ^{
        _playerVc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        //        });
        _playerVc.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        _playerVc.moviePlayer.controlStyle = MPMovieControlStyleDefault ;
        [_playerVc.moviePlayer prepareToPlay];
        [_playerVc.moviePlayer  play];
      }
    return _playerVc;
}


@end
