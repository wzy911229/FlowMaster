//
//  JDMBaseRefreshViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/15.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMBaseRefreshViewController.h"
@interface JDMBaseRefreshViewController ()

@end

@implementation JDMBaseRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeaderRefresh];
    [self setFooterRefresh];
}

//设置头部下拉刷新
-(void)setHeaderRefresh
{
    JDMWeakSelf;
    // 下拉刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
       
        !weakSelf.getHeaderBlock ? : weakSelf.getHeaderBlock();
        
    }];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<= 60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [header setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [header setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
//    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
        // 隐藏状态
        header.stateLabel.hidden = YES;
    
     self.tableView.mj_header = header;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_header endRefreshing];
        
    });
}

//设置底部上拉刷新
- (void)setFooterRefresh
{
    JDMWeakSelf;
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    // 刷新的时候做某事
        !weakSelf.getFooterBlock?: weakSelf.getFooterBlock();
        
    }];
}

#pragma mark ScrollView代理<UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.tableView.mj_header endRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
