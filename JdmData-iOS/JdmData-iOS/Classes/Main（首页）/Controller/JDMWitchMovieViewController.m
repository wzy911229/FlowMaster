//
//  JDMWitchMovieViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/2.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMWitchMovieViewController.h"
#import "JDMMovieViewCell.h"
#import "JDMSimpleMovieViewController.h"
#import "JDMAFNNetworkTools.h"
#import "JDMMovie.h"
#import <MJExtension.h>

static NSString *HomeMovieHistoryPath =@"HomeMovieHistoryPath";
@interface JDMWitchMovieViewController ()
/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *movies;
@end

@implementation JDMWitchMovieViewController

static NSString *ID = @"cell";

#pragma -mark 生命周期方法
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupRefresh];
//    [self setupOldSource];
    [self loadImages];
    self.title = @"看视频赚流量";
    [self.tableView registerNib:[UINib nibWithNibName:@"JDMMovieViewCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.rowHeight = [JDMTools amusementCellProper];
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    
}
//设置刷新
-(void)setupRefresh
{
    JDMWeakSelf;
    [self setGetFooterBlock:^{
        
    
        
    }];
    [self setGetHeaderBlock:^{
        [weakSelf loadImages];
    }];
}
/**
 *  加载缓存的数据
 */
-(void)setupOldSource
{
    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey: HomeMovieHistoryPath];
    self.movies = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
}

/**
 *  请求全部数据
 */
-(void)loadImages
{
    // 取消之前的所有请求
    [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"showHomeFlag"] = @0 ;
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMMovieURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         [self.movies removeAllObjects];
        self.movies = [JDMMovie mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
//          //归档首页电影数据
//        NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//        NSString *path = [file stringByAppendingString:@"/witchMovies.plist"];
//        [[NSUserDefaults standardUserDefaults] setObject:path forKey:HomeMovieHistoryPath];
//        [NSKeyedArchiver archiveRootObject:self.movies toFile:path];
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    
        
    }];
    
    
}

#pragma -mark 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDMMovieViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    cell.movie =self.movies[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDMSimpleMovieViewController *simpleVc = [[JDMSimpleMovieViewController alloc]init];
    simpleVc.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:simpleVc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
