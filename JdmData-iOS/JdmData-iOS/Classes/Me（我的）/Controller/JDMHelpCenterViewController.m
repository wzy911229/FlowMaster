//
//  JDMHelpCenterViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/21.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMHelpCenterViewController.h"
#import "JDMHelpCell.h"

@interface JDMHelpCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *collectView;
@end

@implementation JDMHelpCenterViewController
static NSString *ID =@"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollection];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

/**
 *  加载collection和scrollView
 */
- (void)setupCollection
{
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:JDMScreenBounds];
    scroll.contentSize = CGSizeMake(0, JDMScreenH);
    scroll.backgroundColor =JDMColor(0xF0F0F0);
    [self.view addSubview:scroll];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell尺寸
    flowLayout.itemSize= CGSizeMake(JDMScreenW / 2-1, JDMScreenH / 2 / 7);
    
    // 设置水平排版cell
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 1;

    UICollectionView *colletionView = [[UICollectionView alloc] initWithFrame:JDMScreenBounds collectionViewLayout:flowLayout];
    colletionView.backgroundColor = JDMColor(0xF0F0F0);
    [colletionView registerClass:[JDMHelpCell class] forCellWithReuseIdentifier:ID];
    colletionView.dataSource = self;
    colletionView.delegate = self;
    [scroll addSubview:colletionView];
    self.collectView = colletionView;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 10;
    
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JDMHelpCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
       cell.textlabel.text = @"产品介绍";
    cell.backgroundColor = [UIColor whiteColor];
    return cell;

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewController *vc = [[UITableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
