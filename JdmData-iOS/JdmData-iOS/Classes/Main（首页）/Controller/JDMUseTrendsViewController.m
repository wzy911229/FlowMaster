//
//   JDMUseTrendsViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMUseTrendsViewController.h"
#import "JDMViewController.h"

@interface  JDMUseTrendsViewController ()<UITableViewDataSource>

/** 当前中间显示时间Label*/
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
/** 当前日期数组*/
@property (weak, nonatomic) IBOutlet UITableView *timeTableView;
/** 当前日期数组*/
@property(nonatomic,strong) NSArray * dateArray;
/** 保存当前年份*/
@property(nonatomic,assign) NSInteger  checkYear;
/** 保存当前月份*/
@property(nonatomic,assign) NSInteger   checkMonth;
/** 图表内容View*/
@property (weak, nonatomic) IBOutlet UIView *chaView;
/** 保存返回过去的按钮*/
@property(nonatomic,weak) UIButton *backBtn;
/** 保存前进时间的按钮*/
@property(nonatomic,weak) UIButton *avBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeViewHeight;

@end

@implementation  JDMUseTrendsViewController
static NSString *ID =@"cell";

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    
    [super viewDidLoad];
     [self getTime];
    self.timeTableView.dataSource = self;

    [self.timeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    [self setupChat];
    
}
#pragma mark - 内部控制方法
//添加图表
-(void)setupChat
{
    JDMViewController *vc =[[JDMViewController alloc]init];
    [self addChildViewController:vc];
    vc.view.frame = self.chaView.bounds;
    [self.chaView addSubview:vc.view];
    if(JDMScreenW > 350)
    {
      self.timeViewHeight.constant =250 ;
    }
}
//获取当前时间
-(void)getTime
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *cmp =  [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
  
//    NSLog(@"%ld---%ld---%ld",(long)cmp.year,(long)cmp.month,(long)cmp.day);
    NSMutableArray *dateArray = [NSMutableArray arrayWithCapacity:cmp.day];
    for (NSInteger i = cmp.day; i >= 1 ; i--) {
        
    NSString *dateString = [NSString stringWithFormat:@"%ld月%ld日",(long)cmp.month,(long)i];
        [dateArray addObject:dateString];
    }
    self.dateArray = dateArray;
    self.checkYear = cmp.year;
    self.checkMonth = cmp.month;
    
}

#pragma mark - 外部控制方法
- (IBAction)clickbackBtn:(UIButton *)backBtn {
   
    self.backBtn = backBtn;
    if (self.checkMonth > 1) {
        self.avBtn.enabled =YES;
        self.checkMonth = self.checkMonth -1;
        self.dateLabel.text = [NSString stringWithFormat:@"%ld-%ld",(long)self.checkYear,(long)self.checkMonth ];
    }else{
        backBtn.enabled = NO;
    }
 
  
}
- (IBAction)clickAdvanceBtn:(UIButton *)AdvanceBtn {
     self.avBtn = AdvanceBtn;
    if (self.checkMonth < 12) {
         self.backBtn.enabled =YES;
        self.checkMonth = self.checkMonth  + 1;
        self.dateLabel.text = [NSString stringWithFormat:@"%ld-%ld",(long)self.checkYear,(long)self.checkMonth ];
    }else{
        AdvanceBtn.enabled = NO;
    }
  
    
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell;
    //    = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dateArray[indexPath.row];
    cell.detailTextLabel.text = @"20M";
    
    return cell;
}


//-(NSMutableArray *)dateArray
//{
//    if (!_dateArray) {
//        _dateArray =[NSMutableArray array];
//    }
//    return _dateArray;
//}

@end
