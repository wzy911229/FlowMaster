//
//  JDMPublicViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/30.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMPublicViewController.h"
#import "JDMPublicCell.h"
#import "JDMFunctionView.h"
#import "JDMSqaureButton.h"
#import "JDMSqaureBtn.h"
#import <MJExtension.h>
#import "JDMStepView.h"

@interface JDMPublicViewController ()<JDMFunctionDelegate>
/** 方块按钮模型数组*/
@property(nonatomic,strong) NSArray  *sqaures;

@end

@implementation JDMPublicViewController

static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"公众号";
    [self setupTableView];
    
}



-(void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"JDMPublicCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.estimatedRowHeight = 150;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = JDMColor(0xF0F0F0);
//    self.tableView.sectionHeaderHeight = 150;
//    [self addFuncBtnView];
    [self setupStepView];
    
}
- (void)setupStepView
{
    JDMStepView *stepView = [JDMStepView viewFromNib];
    stepView.height = 150;
    self.tableView.tableHeaderView = stepView;
}



/**
 *  加载方块功能按钮
 */
- (void)addFuncBtnView
{
    JDMFunctionView *functionView = [JDMFunctionView functionView];
    [self loadData:@"PublicSqaureBtn.json"];
    
    functionView.totalColCount = 4;
    functionView.delegate = self;
    functionView.squares = self.sqaures;
    [self.view addSubview:functionView];
  [self.tableView setTableHeaderView:functionView];;
    
}


/**
 *  加载数据
 */
- (void)loadData:(NSString *)fileName
{
    
    NSString *response = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData: [NSData dataWithContentsOfFile:response] options:NSJSONReadingMutableContainers error:nil];
    self.sqaures = [JDMSqaureBtn mj_objectArrayWithKeyValuesArray:json];
    
}



- (void)functionView:(JDMFunctionView *)funcView andSqaureButton:(JDMSqaureButton *)sqaureBtn
{
    JDMLogFunc;
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDMPublicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
