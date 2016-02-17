//
//  FDCalendarItem.m
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "FDCalendarItem.h"
#import <Masonry.h>

@interface FDCalendarCell : UICollectionViewCell
@property (weak, nonatomic)  UIImageView *goldMark;
@property (weak, nonatomic)  UILabel *exChangeLabel;
@property (weak, nonatomic)  UIView *line;
@property (assign, nonatomic) NSInteger isToday;
- (UILabel *)dayLabel;


@end

@implementation FDCalendarCell {
    UILabel *_dayLabel;
   
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.goldMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.exChangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-2);
        make.bottom.equalTo(self.mas_bottom).offset(-2);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];

}
- (void)addViews
{
    UIImageView *image =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"redbag_icon_gold"]];
    image.hidden = YES;
    self.goldMark = image;
    [self addSubview:image];
    UILabel *exChangeLabel =[[UILabel alloc]init];
    exChangeLabel.backgroundColor = [UIColor redColor];
    self.exChangeLabel.text = @"兑换日";
    [self addSubview:exChangeLabel];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    self.line = line;
    [self addSubview:line];
    
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
         self.backgroundColor =[UIColor whiteColor];
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 16, 16)];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_dayLabel];
    }
    return _dayLabel;
}

@end

#define CollectionViewHorizonMargin 5
#define CollectionViewVerticalMargin 5
static NSString *identifier = @"CalendarCell";

typedef NS_ENUM(NSUInteger, FDCalendarMonth) {
    FDCalendarMonthPrevious = 0,
    FDCalendarMonthCurrent ,
    FDCalendarMonthNext  ,
};

@interface FDCalendarItem () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (copy, nonatomic)  NSString *monthHistory;
@property (copy, nonatomic)  NSString *yearHistory;

@property (strong, nonatomic)  NSMutableArray *yearArray;
@property (strong, nonatomic)  NSMutableArray *dayArray;
@property (strong, nonatomic)  NSMutableArray *monthArray;


@end

@implementation FDCalendarItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDateChange:) name:@"titleButtonTextChange" object:nil];
         //签到历史
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSignDateHistory:) name:@"postDateHistory" object:nil];
        //当天签到
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSignDateHistory:) name:@"sign" object:nil];
      
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setupCollectionView];
    
}

//监听签到的通知
-(void)getSignDateHistory:(NSNotification *)note
{
    NSArray *dateArray= note.userInfo[@"dateArray"];
    for (NSString *dateStr in dateArray) {

        [self getDateStr:dateStr];
 }
    [self.collectionView reloadData];
    
}
//转化年月日数组
-(void)getDateStr:(NSString *)str
{
    NSRange rangeYear  = NSMakeRange(0, 4);
    NSRange rangeMonth = NSMakeRange(5, 2);
    NSRange rangeDay = NSMakeRange(8, 2);
    
    [self.yearArray addObject:[str substringWithRange:rangeYear]];
    [self.monthArray addObject:[str substringWithRange:rangeMonth]];
    
    NSString *dayStr = [str substringWithRange:rangeDay];
    if ([dayStr hasPrefix:@"0"]) {
         NSRange day = NSMakeRange(1, 1);
        dayStr =[dayStr substringWithRange:day];
    }
    [self.dayArray addObject:dayStr];
    
//    JDMLog(@"%@",[str substringWithRange:rangeYear]);
//    JDMLog(@"%@",[str substringWithRange:rangeMonth]);
//    JDMLog(@"%@",[str substringWithRange:rangeDay]);
    
}
////转化年月日数组
//-(NSDateComponents*)calculateDate:(NSDate*)date
//{
//    // 获取当前的秒数
//    // 创建日历类
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    // 日期组件（年、月、日、小时、分、秒）
//    NSDateComponents *cmp =  [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear| NSCalendarUnitDay fromDate:date];
//    return cmp;
//    
//    
//}
////将字符转转化为date
//-(NSDate *)changeDate:(NSString *)dateStr
//{
//    NSDateFormatter*  formatter= [[NSDateFormatter alloc]init];
//    formatter.dateFormat = @"yyyy-MM-dd";
//    NSDate *Date = [formatter dateFromString:dateStr];
//    return Date;
//    
//}

- (void)getDateChange:(NSNotification *)note
{

   NSString *str= note.userInfo[@"date"];

    NSRange range = NSMakeRange(0, 4);
    self.yearHistory = [str substringWithRange:range];
 
    str = [str substringFromIndex:5];
    str =  [str substringToIndex:2];
    self.monthHistory = str;
}
#pragma mark - Custom Accessors

- (void)setDate:(NSDate *)date {
    _date = date;
    
    [self.collectionView reloadData];
    
}

#pragma mark - Public 

// 获取date的下个月日期
- (NSDate *)nextMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return nextMonthDate;
    
}

// 获取date的上个月日期
- (NSDate *)previousMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    NSDate *previousMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return previousMonthDate;
}

#pragma mark - Private

// collectionView显示日期单元，设置其属性
- (void)setupCollectionView {
   
        CGFloat itemWidth = self.width /  7;
        JDMLog(@"%@",NSStringFromCGRect(self.frame));
        CGFloat itemHeight = itemWidth - 22;
        
        UICollectionViewFlowLayout *flowLayot = [[UICollectionViewFlowLayout alloc] init];
        flowLayot.itemSize = CGSizeMake(itemWidth, itemHeight);
    
        CGRect collectionViewFrame = CGRectMake(0, 0, self.width , itemHeight * 6 +6 );
        self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayot];
//    self.collectionView.contentSize =CGSizeMake(self.width * 3, 0);
    flowLayot.minimumLineSpacing = 1;
    flowLayot.minimumInteritemSpacing = 0;
        self.collectionView.bounces = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor lightGrayColor];
       [self.collectionView registerClass:[FDCalendarCell class] forCellWithReuseIdentifier:identifier];
//        [self.collectionView registerNib:[UINib nibWithNibName:@"FDCalendarItem" bundle:nil ]forCellWithReuseIdentifier:@"CalendarCell"];
    
        [self addSubview:self.collectionView];

  
    
}

// 获取date当前月的第一天是星期几
- (NSInteger)weekdayOfFirstDayInDate {
  
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    [components setDay:1];
    NSDate *firstDate = [calendar dateFromComponents:components];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDate];
    
    return firstComponents.weekday - 1;
    
}

// 获取date当前月的总天数
- (NSInteger)totalDaysInMonthOfDate:(NSDate *)date
{
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

// 获取某月day的日期
- (NSDate *)dateOfMonth:(FDCalendarMonth)calendarMonth WithDay:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date;
    
    switch (calendarMonth) {
        case FDCalendarMonthPrevious:
            date = [self previousMonthDate];
            break;
            
        case FDCalendarMonthCurrent:
            date = self.date;
            break;
            
        case FDCalendarMonthNext:
            date = [self nextMonthDate];
            break;
        default:
            break;
    }
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:day];
    NSDate *dateOfDay = [calendar dateFromComponents:components];
    return dateOfDay;
}


#pragma mark - UICollectionDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 42;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    FDCalendarCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
     cell.dayLabel.textColor = [UIColor blackColor];
dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    NSInteger totalDaysOfMonth = [self totalDaysInMonthOfDate:self.date];
    NSInteger totalDaysOfLastMonth = [self totalDaysInMonthOfDate:[self previousMonthDate]];

    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (indexPath.row < firstWeekday) {    // 小于这个月的第一天
            NSInteger day = totalDaysOfLastMonth - firstWeekday + indexPath.row + 1;
            cell.dayLabel.text = [NSString stringWithFormat:@"%ld", (long)day];
            cell.dayLabel.textColor = [UIColor grayColor];
            cell.goldMark.hidden = YES;
            
        } else if (indexPath.row >= totalDaysOfMonth + firstWeekday) {    // 大于这个月的最后一天
            NSInteger day = indexPath.row - totalDaysOfMonth - firstWeekday + 1;
            cell.dayLabel.text = [NSString stringWithFormat:@"%ld", (long)day];
            cell.dayLabel.textColor = [UIColor grayColor];
            cell.goldMark.hidden = YES;
            
            
        } else
        {    // 属于这个月
            NSInteger day = indexPath.row - firstWeekday + 1;
            cell.dayLabel.text= [NSString stringWithFormat:@"%ld", (long)day];
            
            
            if (day == [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self.date])
            {
                cell.dayLabel.textColor = [UIColor redColor];
                cell.goldMark.hidden = YES;
            }else
            {
                cell.goldMark.hidden = YES;
            }
            // 如果日期和当期日期同年同月不同天, 注：第一个判断中的方法是iOS8的新API, 会比较传入单元以及比传入单元大得单元上数据是否相等，亲测同时传入Year和Month结果错误
            
            if ([[NSCalendar currentCalendar] isDate:[NSDate date] equalToDate:self.date toUnitGranularity:NSCalendarUnitMonth] && ![[NSCalendar currentCalendar] isDateInToday:self.date]) {
                
                // 将当前日期的那天高亮显示
                if (day == [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]] )
                {
                    cell.dayLabel.textColor = [UIColor redColor];
                    cell.isToday = 1;
                }
                
            }
            /* 判断是否在年份*/
            if ([self.yearArray containsObject:self.yearHistory]) {
                
                /* 判断是否在月份*/
                if ( [self.monthArray containsObject:self.monthHistory]) {
                    
                    /*************************/
                    /* 判断是否该天存在签到*/
                    if ([self.dayArray containsObject:cell.dayLabel.text]) {
                        
                        cell.goldMark.hidden = NO;
                    }else{
                        cell.goldMark.hidden = YES;
                    }
                    /*************************/
                    
                }
            }
            
        }
        
        

        
        
    });
    
});
    

    return cell;
}




#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    

    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    [components setDay:indexPath.row - firstWeekday + 1];
    NSDate *selectedDate = [[NSCalendar currentCalendar] dateFromComponents:components];
  
        if (self.delegate && [self.delegate respondsToSelector:@selector(calendarItem:didSelectedDate:)]) {
            [self.delegate calendarItem:self didSelectedDate:selectedDate];
     
        }
}


-(NSMutableArray *)yearArray
{
    if (!_yearArray) {
        _yearArray =[NSMutableArray array];
    }
    return _yearArray;
}
-(NSMutableArray *)monthArray
{
    if (!_monthArray) {
        _monthArray =[NSMutableArray array];
    }
    return _monthArray;
}
-(NSMutableArray *)dayArray
{
    if (!_dayArray) {
        _dayArray =[NSMutableArray array];
    }
    return _dayArray;
}
@end
