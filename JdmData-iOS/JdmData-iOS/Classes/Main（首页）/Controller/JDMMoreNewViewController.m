//
//  JDMMoreNewViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/28.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMoreNewViewController.h"
#import "JDMNewsViewCell.h"
#import "JDMNews.h"
#import <MJRefresh.h>
#import "JDMAFNNetworkTools.h"
#import "UIViewController+JDMHUD.h"
#import <MJExtension.h>
#import "JDMUserInfoTools.h"

@interface JDMMoreNewViewController ()


@property(nonatomic,strong)NSMutableArray *news;

@end
extern NSString *newsHistoryPath;
static NSString *ID = @"cell";
@implementation JDMMoreNewViewController

#pragma mark - 生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupOldScource];
    [self loadNews];
    [self setupTableView];
    [self setupRefresh];
 
}
#pragma mark - 内部控制方法
-(void)setupOldScource
{
    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey: newsHistoryPath];
    self.news = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

-(void)setupTableView
{
    self.title = @"新闻";
    self.tableView.rowHeight = 90;
    

    [self.tableView registerNib:[UINib nibWithNibName:@"JDMNewsViewCell" bundle:nil] forCellReuseIdentifier:ID];

    
}
-(void)setupRefresh
{
    JDMWeakSelf;
    [self setGetFooterBlock:^{
        [weakSelf loadNews];
    }];
    [self setGetHeaderBlock:^{
        
    }];
}

#pragma mark - 外部控制方法
//新闻界面请求
-(void)loadNews
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNum"] =  @1;
    params[@"pageSize"] = @10;
    // 取消之前的所有请求
    //    [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMNewsURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {
            
            [self.news removeAllObjects];
            self.news = [JDMNews mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
            
            //归档活动数据
            NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            NSString *path = [file stringByAppendingString:@"/newsArray.plist"];
            [[NSUserDefaults standardUserDefaults] setObject:path forKey:newsHistoryPath];
            [NSKeyedArchiver archiveRootObject:self.news toFile:path];
            [self.tableView reloadData];
        }else{
            
            [self showTextMsgHUD:responseObject[@"msg"] andOffsetY: 0];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        !(self.news.count == 0) ?:[self showTextMsgHUD:JDMRequestErrorAwake andOffsetY: 0];
        
    }];
    
}


//点击数请求
-(void)readNews:(NSString*)uuid :(NSIndexPath*)indexPath
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uuid"] = uuid;
    // 取消之前的所有请求
//        [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMHitCountURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {

            
            JDMNews*new = self.news[indexPath.row];
            NSNumber* hitcount = responseObject[@"dataObj"][@"hitcount"];
            new.hitcount = hitcount.integerValue;
            NSNumber* praisecount = responseObject[@"dataObj"][@"praisecount"];
            new.praisecount = praisecount.integerValue;
            
      [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }
        [self showTextMsgHUD:responseObject[@"msg"] andOffsetY: 0];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self showTextMsgHUD:JDMRequestErrorAwake andOffsetY: 0];
        
    }];
    
}

//点赞接口
-(void)clickPraiseCount:(NSString*)uuid :(NSIndexPath*)indexPath
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uuid"] = uuid;
    // 取消之前的所有请求
    // [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMPraiseCountURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber* isSuccess = responseObject[@"status"];
        
        if (isSuccess.integerValue) { 
            
            JDMNews*new = self.news[indexPath.row];
            NSNumber* hitcount = responseObject[@"dataObj"][@"hitcount"];
            new.hitcount = hitcount.integerValue;
            NSNumber* praisecount = responseObject[@"dataObj"][@"praisecount"];
            new.praisecount = praisecount.integerValue;
            
            
          [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.news.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDMNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
 
     JDMNews *new = self.news[indexPath.row];
      cell.news = new;
     [cell setClickPraiseCount:^{
        [self clickPraiseCount:new.uuid :indexPath];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    UIViewController *Vc = [[UIViewController alloc]init];
    Vc.view.backgroundColor = [UIColor whiteColor];
    Vc.title = @"新闻";
    JDMNews *new = self.news[indexPath.row];
    NSString *urlstr = [NSString stringWithFormat:@"%@news/newsDetail?uuid=%@",JDMBaseURL,new.uuid];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:JDMScreenBounds];
    //    webView.delegate = self;
    [webView loadRequest:request];
    [Vc.view addSubview:webView];
    [self.navigationController pushViewController:Vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self readNews:new.uuid :indexPath];
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - 代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
