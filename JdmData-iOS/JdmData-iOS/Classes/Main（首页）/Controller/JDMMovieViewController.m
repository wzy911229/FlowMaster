//
//  ViewController.m
//  01_图片左右缩放
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import "JDMMovieViewController.h"
#import "JDMImageCell.h"
#import "JDMWitchMovieViewController.h"
#import "JDMSimpleMovieViewController.h"
#import "JDMAFNNetworkTools.h"
#import "JDMMovie.h"
#import <MJExtension.h>
#import "UIViewController+JDMHUD.h"


 static NSString *ID = @"Cell";
static NSString *MovieListHistoryPath =@"MovieListHistoryPath";

@interface JDMMovieViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    MBProgressHUD*HUD;
}
/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *movies;
@property(nonatomic,strong)UICollectionView *collectView;
@end

@implementation JDMMovieViewController
#pragma mark - 生命周期方法


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupOldSource];
    [self setupCollection];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMovies) name:@"loadMovies" object:nil];
}

#pragma mark - 内部控制方法
-(void)reloadMovies
{
    [self loadImages];
}
/**
 *  加载缓存的数据
 */
-(void)setupOldSource
{
    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey: MovieListHistoryPath];
    self.movies = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

/**
 *  加载collection
 */
- (void)setupCollection
{
    [self loadImages];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell尺寸
    CGFloat cellWH = (self.view.frame.size.width - 2 * JDMHomeMovieCellMargin) / 3 - 10 ;
    
    flowLayout.itemSize= CGSizeMake(cellWH, cellWH +JDMHomeMovieCellMargin);
    
    // 2.2定义UICollectionView
    CGRect frm = CGRectMake(0, 0, self.view.width, 130);
    
    UICollectionView *colletionView = [[UICollectionView alloc] initWithFrame:frm collectionViewLayout:flowLayout];
    
    colletionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    colletionView.backgroundColor = [UIColor whiteColor];
    // 设置水平排版cell
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    flowLayout.minimumLineSpacing = JDMHomeMovieCellMargin;
    
    [colletionView registerClass:[JDMImageCell class] forCellWithReuseIdentifier:ID];
    
    colletionView.dataSource = self;
    colletionView.delegate = self;
    
    [self.view addSubview:colletionView];
    self.collectView = colletionView;
    
}


#pragma mark - 外部控制方法
/**
 *  请求首页数据
 */
-(void)loadImages
{

    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"showHomeFlag"] = @1 ;
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMMovieURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {

            
            [self.movies removeAllObjects];
            self.movies = [JDMMovie mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
//            //归档电影列表数据
//            NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//            NSString *path = [file stringByAppendingString:@"/movies.plist"];
//            [[NSUserDefaults standardUserDefaults] setObject:path forKey:MovieListHistoryPath];
//            [NSKeyedArchiver archiveRootObject:self.movies toFile:path];
            

//            [self showTextMsgHUD:responseObject[@"msg"] andMargin:10.0f andOffsetY: 0];
            
        }
        [self.collectView reloadData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideHUD];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

       [self showTextMsgHUD:@"请检查你的网络"  andOffsetY: 0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideHUD];
        });
        
    }];
  


}

#pragma mark - 数据源方法

#pragma mark Collection数据源方法 <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

        return self.movies.count;
   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    JDMImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    cell.movie = self.movies[indexPath.row];
    return cell;
    
}

#pragma mark - 代理方法<UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    JDMSimpleMovieViewController *watchMovieVc = [[JDMSimpleMovieViewController alloc]init];
     watchMovieVc.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:watchMovieVc animated:YES];
}

@end
