//
//  YZNewFeatureViewController.m
//
//
//  Created by yz on 15/6/28.
//  Copyright (c) 2015年 wzy. All rights reserved.
//

#import "JDMNewFeatureViewController.h"
#import "JDMNewFeatureCell.h"
#import "JDMWelcomeHomeViewController.h"
#define JDMGuidePageCount 4



@interface JDMNewFeatureViewController ()

@end

@implementation JDMNewFeatureViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const ID = @"home";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [self initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.collectionView registerClass:[JDMNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
}

#pragma mark <UICollectionViewDataSource>
//
//// 添加guide
//- (void)setUpGuide
//{
//    
//    UIImageView *guideView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
//    
//    guideView.centerX = self.view.centerX;
//    _guideView = guideView;
//    
//    [self.collectionView addSubview:guideView];
//}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    // 获取当前偏移量
//    CGFloat offsetX = scrollView.contentOffset.x;
//    
//    
//    // 获取偏移量差
//    CGFloat offsetGap = offsetX - _offsetX;
//    
//
//    // guideView
//    _guideView.x += 2 * offsetGap;
//    
//    // largeText
//    _largeText.x += 2 * offsetGap;
//    
//    // smallText
//    _smallText.x += 2 * offsetGap;
//    
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        
//        _guideView.x -= offsetGap;
//        
//        _largeText.x -= offsetGap;
//        
//        _smallText.x -= offsetGap;
//        
//    }];
//    
//    // 切换图片
//    int page = offsetX / self.view.width + 1;
//    
//    _guideView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d",page]];
//    
//    _largeText.image = [UIImage imageNamed:[NSString stringWithFormat:@"guideLargeText%d",page]];
//    
//    _smallText.image = [UIImage imageNamed:[NSString stringWithFormat:@"guideSmallText%d",page]];
//    
//    _offsetX = offsetX;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return JDMGuidePageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JDMNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.row == 3) {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        JDMWelcomeHomeViewController *welVc = [[JDMWelcomeHomeViewController alloc] init];
        [self addChildViewController:welVc];
        [cell addSubview:welVc.view];
        return cell;
      
    }else
    {
       cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"user_guide%d",indexPath.row + 1]];
    }
    
    
    return cell;
}



@end
