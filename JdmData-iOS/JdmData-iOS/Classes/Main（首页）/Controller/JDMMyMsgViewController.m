//
//  JDMMyMsgViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/19.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMyMsgViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "JDMUserInfoTools.h"
#import "JDMMsgViewController.h"
#import "JDMAFNNetworkTools.h"
#import <SVProgressHUD.h>
#import "JDMMsgList.h"
#import "UIAlertView+RWBlock.h"

static NSString *MyMsgListHistoryPath = @"MyMsgListHistoryPath";
static NSString *ID = @"cell";

typedef  NS_ENUM(NSUInteger,MyMsyLoadType)
{
    MyMsyLoadTypeFirst = 0,
    MyMsyLoadTypeTop,
    MyMsyLoadTypeBotton
    
};

@interface JDMMyMsgViewController ()
/** 全部我的消息 */
@property(strong,nonatomic) NSMutableArray*  myMsgArray;
/** 全部我的消息 */
@property(strong,nonatomic) NSMutableArray*  UpdateMsgArray;
/** 记录下拉页数 */
@property(assign,nonatomic) NSInteger bottonPushNum;

/** 保存不需要的消息key */
@property(strong,nonatomic) NSMutableArray* noNeedArray;
/** 保存我的消息key */
@property(strong,nonatomic) NSMutableArray* originallyMarkArray;
/** 保存刷新后数组key */
@property(strong,nonatomic) NSMutableArray* updateMarkArray;

@end

@implementation JDMMyMsgViewController

#pragma mark - 生命周期方法

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupOldSource];
 
    [self loadMyMsg:1 LoadType:MyMsyLoadTypeFirst];
  
    [self setupTableViewAndNaV];
    [self setupRefresh];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];
  
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self loadNoReadMyMsgList];
}

#pragma mark - 内部控制方法
/**
 *  加载缓存的数据
 */
-(void)setupOldSource
{
    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey: MyMsgListHistoryPath];
    self.myMsgArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

//设置tableView和Nav
-(void)setupTableViewAndNaV
{
    self.title = @"我的消息";
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"全部已读" style:UIBarButtonItemStylePlain target:self action:@selector(clickAllReadBtn)];
      [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
}

//设置刷新
-(void)setupRefresh
{
    JDMWeakSelf;
    [self setGetFooterBlock:^{
        weakSelf.bottonPushNum += 1;
        [weakSelf loadMyMsg:weakSelf.bottonPushNum LoadType:MyMsyLoadTypeBotton];
    
    }];
    [self setGetHeaderBlock:^{
        [weakSelf loadMyMsg:1 LoadType:MyMsyLoadTypeTop];
    }];
}


#pragma mark - 外部控制方法
//加载我的消息数据
- (void)loadMyMsg:(NSInteger)num LoadType:(MyMsyLoadType)loadType
{
    
    NSNumber *number = [NSNumber numberWithInteger:num];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNum"] =  number;
    params[@"pageSize"] = loadType == MyMsyLoadTypeFirst? @20 : @20;
    params[@"useruuid"] = [JDMUserInfoTools getUserUuid];
    
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMMMsgListURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(!loadType)
        {
         self.myMsgArray = [JDMMsgList mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
               [self chooseMyMsg:self.myMsgArray:loadType];
               [self.tableView reloadData];
        }else{
            
         self.UpdateMsgArray = [JDMMsgList mj_objectArrayWithKeyValuesArray:responseObject[@"dataList"]];
        
              [self chooseMyMsg:self.UpdateMsgArray:loadType];
              [self updateMyMsgListArray:loadType];
        }
//        //判断使用刷新状态
        NSArray *array = responseObject[@"dataList"];
        array.count < 10 ?[self.tableView.mj_footer endRefreshingWithNoMoreData]:[self.tableView.mj_footer endRefreshing];
    
        //归档我的消息数据
//        NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//        NSString *path = [file stringByAppendingString:@"/myMsg.plist"];
//        [[NSUserDefaults standardUserDefaults] setObject:path forKey:MyMsgListHistoryPath];
//        [NSKeyedArchiver archiveRootObject:self.myMsgArray toFile:path];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求错误"];

    }];
    
}

//监听点击全部已读
- (void)clickAllReadBtn
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"useruuid"] = [JDMUserInfoTools getUserUuid];
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMReadAllMsgURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {
            [SVProgressHUD showSuccessWithStatus: responseObject[@"msg"]];
        }
        //设置界面全部消息为0
        userNoReadMsgList = 0;
        //便利消息,并将未读消息标记为已读
        [self.myMsgArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JDMMsgList *myMsgList = obj;
            
            if (!myMsgList.isreadflag)
            {
                myMsgList.isreadflag = YES;
            }
        }];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求错误"];
        
    }];
}

//根据消息id标记已读
- (void)markRead:(NSString *)msgUuid
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"msguuid"] =  msgUuid;
    params[@"useruuid"] = [JDMUserInfoTools getUserUuid];
    
  [[JDMAFNNetworkTools shareNetworkTools] POST:JDMMsgSetReadURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求错误"];
        
    }];
    
}

//加载未读消息数
- (void)loadNoReadMyMsgList
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"useruuid"] = [JDMUserInfoTools getUserUuid];
   [[JDMAFNNetworkTools shareNetworkTools] POST:JDMNoReadMsgURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {
        userNoReadMsgList = ((NSNumber*)responseObject[@"dataObj"][@"unreadCount"]).integerValue;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求错误"];
        
    }];
    
    
    
}

//监听刷新结束
- (void)loadActiVitMyMsg
{
    
}

#pragma mark - 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myMsgArray.count;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell ;
    if (!cell) {
       cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    JDMMsgList *msgList = self.myMsgArray[indexPath.row];
    //设置标题
    cell.textLabel.text = msgList.msgtitle;
    //设置描述文字
    cell.detailTextLabel.text =msgList.msgtext;
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    
//  设置右边时间控件
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    label.textAlignment = NSTextAlignmentRight;
    label.text = [self getDateStr:msgList.createtime];;
    cell.accessoryView = label;
    
    
//    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    label.layer.borderWidth = 1;
    
//  设置消息提示按钮
    UIButton *btn =[self getNotifyButton:1];
    btn.hidden = msgList.isreadflag;
    [cell.imageView addSubview:btn];
    cell.imageView.image =[UIImage imageNamed:@"activity_icon_logo"];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1 ;
    
}


#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDMMsgViewController *msgVc = [[JDMMsgViewController alloc]init];
    [self.navigationController pushViewController:msgVc animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self markReadMsg:indexPath];
    
}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewRowAction * read = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"已读" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self markReadMsg:indexPath];
    }];
    
     return @[read];
}
#pragma mark - 辅助方法
//选择iOS的消息
- (void)chooseMyMsg:(NSArray *)msgArray :(MyMsyLoadType)loadType
{
       [self.updateMarkArray removeAllObjects];
    [msgArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JDMMsgList* msgList = obj;
        
        if ([msgList.platform isEqualToString:@"Android"]) {
            //保存不需要的消息
            [self.noNeedArray addObject:obj];
            
        }else {
            
            loadType == MyMsyLoadTypeFirst ? [self.originallyMarkArray addObject:[NSNumber numberWithInteger:msgList.ID]]:  [self.updateMarkArray addObject:[NSNumber numberWithInteger:msgList.ID]];
        }
        
    }];
    [(NSMutableArray*)msgArray removeObjectsInArray:self.noNeedArray];
}

//查重重组消息数组
- (void)updateMyMsgListArray:(MyMsyLoadType)loadType
{
    
    for (unsigned i = 0; i < self.UpdateMsgArray.count; i++){
        if (![self.originallyMarkArray containsObject:[self.updateMarkArray objectAtIndex:i]] && loadType == MyMsyLoadTypeBotton){
            
            //请求下来未重复的数据中,判断是否已读.
              JDMMsgList* msgList = [self.UpdateMsgArray objectAtIndex:i];
              userNoReadMsgList += (msgList.isreadflag == 0);
            [self.myMsgArray addObject:[self.UpdateMsgArray objectAtIndex:i]];
            
        }else if (![self.originallyMarkArray containsObject:[self.updateMarkArray objectAtIndex:i]] && loadType == MyMsyLoadTypeTop)
        {
            [self.myMsgArray insertObject:[self.UpdateMsgArray objectAtIndex:i] atIndex:0];
         
        }
    }
    [self.tableView reloadData];
    
}

//截取时间
- (NSString *)getDateStr:(NSString *)str
{
    NSRange dateRange = NSMakeRange(5, 5);
    return  [str substringWithRange:dateRange];
}

//标记已读
- (void)markReadMsg:(NSIndexPath *)indexPath
{
    JDMMsgList *msgList = self.myMsgArray[indexPath.row];
    if (!msgList.isreadflag) {
        msgList.isreadflag = YES;
        [self markRead:msgList.uuid];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        userNoReadMsgList -= 1;

    }
    
}

//设置消息提示红色按钮
-(UIButton *)getNotifyButton:(NSInteger)msgNum
{
    UIButton *notifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    notifyBtn.titleLabel.font =[UIFont systemFontOfSize:12];
    
    NSString *str = [NSString stringWithFormat:@"%ld",(long)msgNum];
    [notifyBtn setTitle:str forState:UIControlStateNormal];
    
    [notifyBtn setBackgroundImage:[UIImage imageNamed:@"btn_message_redcircle"] forState:UIControlStateNormal];
    notifyBtn.frame = CGRectMake(23, -3, 15, 15);
    
    return notifyBtn;
}

#pragma mark - 懒加载
-(NSInteger)bottonPushNum
{
    if (!_bottonPushNum) {
        _bottonPushNum = 1;
    }
    return _bottonPushNum;
}
- (NSMutableArray *)myMsgArray
{
    if (!_myMsgArray) {
        
        _myMsgArray = [NSMutableArray array];
    }
    return _myMsgArray;
}
- (NSMutableArray *)UpdateMsgArray
{
    if (!_UpdateMsgArray) {
        
        _UpdateMsgArray = [NSMutableArray array];
    }
    return _UpdateMsgArray;
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
- (NSMutableArray *)noNeedArray
{
    if (!_noNeedArray) {
        
        _noNeedArray = [NSMutableArray array];
    }
    return _noNeedArray;
}



- (void)longPressGestureRecognized:(id)sender
{
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshoFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.tableView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                [self.myMsgArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // ... move the rows.
                [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
            
        default: {
            // Clean up.
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            
            break;
        }
    }
}


- (UIView *)customSnapshoFromView:(UIView *)inputView
{
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}



@end
