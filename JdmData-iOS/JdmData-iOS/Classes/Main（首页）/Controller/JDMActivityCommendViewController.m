//
//  JDMCommendViewController.m
//  JdmData-iOS/Users/test1/Desktop/ZYWuLibrary/OSChinaiphone-app/iosapp/Controllers
//
//  Created by test1 on 15/11/23.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMActivityCommendViewController.h"
#import "JDMCommendCell.h"
#import "JDMAFNNetworkTools.h"
#import "JDMCommend.h"
#import <MJExtension.h>
#import "JDMActivityViewController.h"
#import "UIViewController+JDMHUD.h"

typedef  NS_ENUM(NSUInteger,MyCommendLoadType)
{
    MyCommendLoadTypeFirst = 0,
    MyCommendLoadTypeTop,
    MyCommendLoadTypeBotton
};

static NSString *const ID =@"cell";
NSString * const activeHistoryPath = @"activeHistoryPath";

@interface JDMActivityCommendViewController ()
{
    MBProgressHUD*HUD;
}
/** 活动流量模型数组*/
@property(nonatomic,strong) NSMutableArray *ActiveArray;
/** 记录下拉页数 */
@property(nonatomic,assign)NSInteger pageNum;

/** 上啦下拉数据 */
@property(strong,nonatomic) NSMutableArray*  UpdateMsgArray;
/** 保存不需要的消息key */
@property(strong,nonatomic) NSMutableArray* noNeedArray;
/** 保存我的消息key */
@property(strong,nonatomic) NSMutableArray* originallyMarkArray;
/** 保存刷新后数组key */
@property(strong,nonatomic) NSMutableArray* updateMarkArray;


@end
@implementation JDMActivityCommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupOldSource];
     [self loadiVitCommend:MyCommendLoadTypeFirst];
    [self setuptableView];
    [self setupRefresh];
    self.title = @"活动详情";
    
}

/**
 *  加载缓存的数据
 */
-(void)setupOldSource
{
    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey: activeHistoryPath];
    self.ActiveArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (self.ActiveArray.count ==0) {
        
        [self loadiVitCommend:MyCommendLoadTypeFirst];
    }
}
/**
 *  加载tableView
 */
-(void)setuptableView
{
    self.tableView.backgroundColor = JDMColor(0xF0F0F0);
    self.tableView.rowHeight = [JDMTools amusementCellProper];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JDMCommendCell class]) bundle:nil] forCellReuseIdentifier:ID];
}

-(void)setupRefresh
{
    JDMWeakSelf;
    [self setGetHeaderBlock:^{
        [weakSelf loadiVitCommend:MyCommendLoadTypeTop];
   
    }];
    [self setGetFooterBlock:^{
        weakSelf.pageNum +=1;
        [weakSelf loadiVitCommend:MyCommendLoadTypeBotton];
    }];
 
}

//加载数据
-(void)loadiVitCommend:(MyCommendLoadType)loadType
{
    NSNumber *number = [NSNumber numberWithInteger:self.pageNum];
    NSNumber *num = loadType == MyCommendLoadTypeBotton ? number : @1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNum"] =  num;
    params[@"pageSize"] = @10;
    
   [self showLoadingHUD: JDMLoadingAwake andOffsetY:0];

    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMActivityURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {
            if (loadType == MyCommendLoadTypeFirst)
            {
                self.ActiveArray = [JDMCommend mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
                [self updateActiveArrayKeys:self.ActiveArray WithType:loadType];
                
            }else{
                
                self.UpdateMsgArray  = [JDMCommend mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
                [self updateActiveArrayKeys:self.ActiveArray WithType:loadType];
                [self updateActiveArray:loadType];
                
            }
//            //归档活动数据
//            NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//            NSString *path = [file stringByAppendingString:@"/ActiveArray.plist"];
//            [[NSUserDefaults standardUserDefaults] setObject:path forKey:activeHistoryPath];
//            [NSKeyedArchiver archiveRootObject:self.ActiveArray toFile:path];
            
            //判断使用刷新状态
            NSArray *array = responseObject[@"dataList"];
            array.count < 10 ?[self.tableView.mj_footer endRefreshingWithNoMoreData]:[self.tableView.mj_footer endRefreshing];
            
            [self.tableView reloadData];
            
        }else{
            
            [self showTextMsgHUD: responseObject[@"msg"] andOffsetY: 0];

        }
        [self hideHUD];
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
   [self showTextMsgHUD:JDMRequestErrorAwake andOffsetY:0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHUD];
    });
    
}];
    
}
//选择iOS的消息
- (void)updateActiveArrayKeys:(NSMutableArray *)msgArray WithType:(MyCommendLoadType)loadType{
    [self.updateMarkArray removeAllObjects];
    [msgArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JDMCommend * commend = obj;
            loadType == MyCommendLoadTypeFirst ?  [self.originallyMarkArray addObject:[NSNumber numberWithInteger:commend.ID]]:  [self.updateMarkArray addObject:[NSNumber numberWithInteger:commend.ID]];
    }];
}

//查重重组消息数组
-(void)updateActiveArray:(MyCommendLoadType)loadType
{
    
    for (unsigned i = 0; i < self.updateMarkArray.count; i++){
        
        if (![self.originallyMarkArray containsObject:[self.updateMarkArray objectAtIndex:i]] && loadType == MyCommendLoadTypeBotton){
 
            [self.ActiveArray addObject:[self.UpdateMsgArray objectAtIndex:i]];
            [self.originallyMarkArray addObject:[self.updateMarkArray objectAtIndex:i]];
        
            
        }else if (![self.originallyMarkArray containsObject:[self.updateMarkArray objectAtIndex:i]] && loadType == MyCommendLoadTypeTop)
        {
            [self.ActiveArray insertObject:[self.UpdateMsgArray objectAtIndex:i] atIndex:0];
            [self.originallyMarkArray addObject:[self.updateMarkArray objectAtIndex:i]];
        }
        
    }
  
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.ActiveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDMCommendCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.commend = self.ActiveArray[indexPath.row];
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDMActivityViewController *Vc = [[JDMActivityViewController alloc]init];
    JDMCommend *commend = self.ActiveArray[indexPath.row];
    Vc.linkUrl = commend.linkurl;
    [self.navigationController pushViewController:Vc animated:YES];

}

#pragma mark - 懒加载
-(NSInteger)pageNum
{
    if (!_pageNum) {
        _pageNum = 1;
    }
    return _pageNum;
}
- (NSMutableArray *)originallyMarkArray
{
    if (!_originallyMarkArray) {
        
        _originallyMarkArray = [NSMutableArray array];
    }
    return _originallyMarkArray;
}

- (NSMutableArray *)updateMarkArray
{
    if (!_updateMarkArray) {
        
        _updateMarkArray = [NSMutableArray array];
    }
    return _updateMarkArray;
}
- (NSMutableArray *)UpdateMsgArray
{
    if (!_UpdateMsgArray) {
        
        _UpdateMsgArray = [NSMutableArray array];
    }
    return _UpdateMsgArray;
}
- (NSMutableArray *)noNeedArray
{
    if (!_noNeedArray) {
        
        _noNeedArray = [NSMutableArray array];
    }
    return _noNeedArray;
}
-(NSMutableArray *)ActiveArray
{
    if (!_ActiveArray) {
        _ActiveArray = [NSMutableArray array];
    }
    
    return _ActiveArray;
}
@end
