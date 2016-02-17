//
//  JDMDownLoadAppViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/2.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMDownLoadAppViewController.h"
#import "JDMAppHeaderView.h"
#import "JDMAppViewCell.h"

@interface JDMDownLoadAppViewController ()<UITableViewDataSource,UITableViewDelegate>
//tableView
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong) NSMutableDictionary *showDic;//用来判断分组展开与收缩的
@property(nonatomic,strong)UITapGestureRecognizer *recognizer;
@end

@implementation JDMDownLoadAppViewController
static NSString *ID =@"cell";

#pragma mark -生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSegment];
    [self setupNav];
    [self setupTableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark -内部控制方法
-(void)setupSegment
{

    UISegmentedControl *segment =[[UISegmentedControl alloc] initWithItems:@[@"精品应用",@"最新应用"]];
    
    segment.width = self.view.width / 1.5;
    segment.center = CGPointMake(self.view.center.x, 100);
    [segment addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    [self.view addSubview:segment];
}

-(void)setupTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 135 , JDMScreenW, JDMScreenH) style:UITableViewStyleGrouped];
    tableView.backgroundColor =  JDMColor(0xF0F0F0);
    tableView.delegate =self;
    tableView.dataSource =self;
    tableView.contentInset =UIEdgeInsetsMake(20, 0, 0, 0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"JDMAppViewCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView =tableView;
    [self.view addSubview:tableView];
    
}

-(void)setupNav
{
    UIBarButtonItem *helpItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickHelpItem) image:@"title_icon_help"highImage:nil];
    
    helpItem.width = 5;
    UIBarButtonItem *bookItem =[UIBarButtonItem itemWithTarget:self action:@selector(clickBookItem) image:@"title_icon_record"highImage:nil];
    
    self.navigationItem.rightBarButtonItems =@[helpItem,bookItem];
    
}

// 展开收缩section中cell 手势监听
-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{    self.recognizer = recognizer;
    NSInteger didSection = recognizer.view.tag;
    
    if (!_showDic) {
        _showDic = [[NSMutableDictionary alloc]init];
    }
    
    NSString *key = [NSString stringWithFormat:@"%ld",(long)didSection];
    if (![_showDic objectForKey:key]) {
        [_showDic setObject:@"1" forKey:key];
        
    }else{
        
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:didSection] withRowAnimation:UITableViewRowAnimationFade];
   
        [_showDic removeObjectForKey:key];
   
    
// [self.tableView reloadData];
}


#pragma mark -外部控制方法
-(void)clickSegment:(UISegmentedControl*)segment
{
     JDMLogFunc;
}

-(void)clickHelpItem
{
    JDMLogFunc;
}
-(void)clickBookItem
{
    JDMLogFunc;
}


#pragma mark -tableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset=UIEdgeInsetsZero;
    cell.clipsToBounds = YES;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JDMAppHeaderView *headerView = [JDMAppHeaderView viewFromNib];
    
    
    // 单击的 Recognizer ,收缩分组cell
    headerView.tag = section;
    
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    singleRecognizer.numberOfTapsRequired = 1; //点击的次数 =1:单击
    [singleRecognizer setNumberOfTouchesRequired:1];//1个手指操作
    [headerView addGestureRecognizer:singleRecognizer];//添加一个手势监测；

    return headerView;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_showDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]) {
        return 120;
    }
    return 0;
}

//section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.recognizer.view.tag = indexPath.section;
  [self SingleTap:self.recognizer];
}
@end
