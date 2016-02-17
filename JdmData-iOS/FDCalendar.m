//
//  FDCalendar.m
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "FDCalendar.h"
#import "FDCalendarItem.h"

#define Weekdays @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"]

static NSDateFormatter *dateFormattor;

@interface FDCalendar () <UIScrollViewDelegate, FDCalendarItemDelegate>
/** 头部时间view*/
@property (weak, nonatomic) UIView *titleView;
/** 3个控制时间的btn*/
@property (weak, nonatomic) UIButton *titleButton;
@property (weak, nonatomic) UIButton *leftButton;
@property (weak, nonatomic) UIButton *rightButton;
/** 中部星期neirongView*/
@property (weak, nonatomic) UIView *weekView;
@property (strong, nonatomic) NSDate *date;


@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) FDCalendarItem *leftCalendarItem;
@property (strong, nonatomic) FDCalendarItem *centerCalendarItem;
@property (strong, nonatomic) FDCalendarItem *rightCalendarItem;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *datePickerView;
@property (strong, nonatomic) UIDatePicker *datePicker;

@end

@implementation FDCalendar

- (instancetype)initWithCurrentDate:(NSDate *)date {
    if (self = [super init]) {
    self.date = date;
   
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        JDMLog(@"%@",NSStringFromCGRect(self.frame));
       [self setupTitleBar];
        
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置头部时间控件的frame
    self.titleView.frame = CGRectMake(0, 0, self.width, 33);
    
    self.titleButton.center = self.titleView.center;
    self.titleButton.width = 200;
    self.leftButton.frame = CGRectMake(70 , 5, 32, 24);
 CGFloat x =  self.titleButton.x - CGRectGetMaxX(self.leftButton.frame) + CGRectGetMaxX(self.titleButton.frame);
    self.rightButton.frame = CGRectMake(x , 5, 32, 24);
    
    //设置中部星期控件的frame
     self.weekView.frame = CGRectMake(0, 33, self.width , 33);

    
        [self setupWeekHeader];
        [self setupScrollView];
        [self setupCalendarItems];
    


    
}


#pragma mark - Custom Accessors

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame: self.bounds];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.alpha = 0;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDatePickerView)];
        [_backgroundView addGestureRecognizer:tapGesture];
    }
    
    [self addSubview:_backgroundView];
    return _backgroundView;
}

- (UIView *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, 0)];
        _datePickerView.backgroundColor = [UIColor whiteColor];
        _datePickerView.clipsToBounds = YES;
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 32, 20)];
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelSelectCurrentDate) forControlEvents:UIControlEventTouchUpInside];
        [_datePickerView addSubview:cancelButton];
        
        UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 52, 10, 32, 20)];
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        [okButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [okButton addTarget:self action:@selector(selectCurrentDate) forControlEvents:UIControlEventTouchUpInside];
        [_datePickerView addSubview:okButton];
        
        [_datePickerView addSubview:self.datePicker];
    }
      [self addSubview:_datePickerView];

    
    return _datePickerView;
}

#pragma mark - Private

- (NSString *)stringFromDate:(NSDate *)date {
    if (!dateFormattor) {

        dateFormattor = [[NSDateFormatter alloc] init];
        [dateFormattor setDateFormat:@"yyyy-MM-dd"];
        
    }
    return  [dateFormattor stringFromDate:date];
}
// 设置上层的titleBar
- (void)setupTitleBar {


        UIView * titleView = [[UIView alloc] init];
        titleView.backgroundColor =[UIColor clearColor];
        [self addSubview:titleView];
        self.titleView = titleView;
     UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    titleButton.titleLabel.backgroundColor =[UIColor greenColor];
    titleButton.titleLabel.textColor = [UIColor whiteColor];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [titleButton sizeToFit];
//    [titleButton addTarget:self action:@selector(showDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:titleButton];
    self.titleButton = titleButton;
  
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"icon_previous"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(setPreviousMonthDate) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:leftButton];
    self.leftButton =leftButton;

    UIButton *rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(setNextMonthDate) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:rightButton];
    self.rightButton = rightButton;
    
}


// 设置星期文字的显示
- (void)setupWeekHeader {
    
        NSInteger count = [Weekdays count];
        UIView * View =[[UIView alloc] init];
        View.backgroundColor = JDMColor(0xF0F0F0);
        [self addSubview:View];
        self.weekView = View;
        
        CGFloat offsetX = 5;
        for (int i = 0; i < count; i++) {
            UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 40 , (self.width - 10) / count, 20)];
            
            weekdayLabel.textAlignment = NSTextAlignmentCenter;
//            JDMLog(@"%f",self.width);
            weekdayLabel.text = Weekdays[i];
            
            if (i == 0 || i == count - 1) {
                weekdayLabel.textColor = [UIColor redColor];
            } else {
                weekdayLabel.textColor = [UIColor grayColor];
            }
            
            [self addSubview:weekdayLabel];
            
            offsetX += weekdayLabel.frame.size.width;
        }
  

}

// 设置包含日历的item的scrollView
- (void)setupScrollView {
   
        UIScrollView * scroll =[[UIScrollView alloc] init];
        scroll = scroll;
        scroll.delegate = self;
        scroll.pagingEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.alwaysBounceVertical = NO;
        scroll.contentSize = CGSizeMake(3 * self.width, 0);
        scroll.contentOffset = CGPointMake(self.width , 0);
        scroll.frame = CGRectMake(0, 66, self.width , self.height );
        [self addSubview:scroll];
        self.scrollView = scroll;
   
    
}

// 设置3个日历的item
- (void)setupCalendarItems {
  
        
        self.leftCalendarItem = [[FDCalendarItem alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height)];
        self.leftCalendarItem.delegate = self;
        [self.scrollView addSubview:self.leftCalendarItem];
        
        CGRect itemFrame = self.leftCalendarItem.frame;
        itemFrame.origin.x = self.width;
        self.centerCalendarItem = [[FDCalendarItem alloc] init];
        self.centerCalendarItem.frame = itemFrame;
        self.centerCalendarItem.delegate = self;
        [self.scrollView addSubview:self.centerCalendarItem];
        
        itemFrame.origin.x = self.width * 2;
        self.rightCalendarItem = [[FDCalendarItem alloc] init];
        self.rightCalendarItem.frame = itemFrame;
        self.rightCalendarItem.delegate = self;
        [self.scrollView addSubview:self.rightCalendarItem];
          [self setCurrentDate:[NSDate date]];
   
    
}

// 设置当前日期，初始化
- (void)setCurrentDate:(NSDate *)date {
    self.centerCalendarItem.date = date;
    self.leftCalendarItem.date = [self.centerCalendarItem previousMonthDate];
    self.rightCalendarItem.date = [self.centerCalendarItem nextMonthDate];
    [self.titleButton setTitle:[self stringFromDate:self.centerCalendarItem.date] forState:UIControlStateNormal];
    
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:self.titleButton.titleLabel.text forKey:@"date"];
    // 发布通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"titleButtonTextChange"object:nil userInfo:dict];
    
}

// 重新加载日历items的数据
- (void)reloadCalendarItems {
    CGPoint offset = self.scrollView.contentOffset;
 
    if (offset.x  > self.scrollView.frame.size.width ) {
        [self setNextMonthDate];
      
    } else {
        [self setPreviousMonthDate];
    }
}

- (void)showDatePickerView {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.alpha = 0.4;
        self.datePickerView.frame = CGRectMake(0, 44, self.frame.size.width, 250);
    }];
}

- (void)hideDatePickerView {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.alpha = 0;
        self.datePickerView.frame = CGRectMake(0, 44, self.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self.datePickerView removeFromSuperview];
    }];
}

#pragma mark - SEL

// 跳到上一个月
- (void)setPreviousMonthDate {
    [self setCurrentDate:[self.centerCalendarItem previousMonthDate]];
}

// 跳到下一个月
- (void)setNextMonthDate {
    [self setCurrentDate:[self.centerCalendarItem nextMonthDate]];
}

- (void)showDatePicker {
//    [self showDatePickerView];

}

// 选择当前日期
- (void)selectCurrentDate {
    [self setCurrentDate:self.datePicker.date];
    [self hideDatePickerView];
}

- (void)cancelSelectCurrentDate {
    [self hideDatePickerView];
}

#pragma mark - UIScrollViewDelegate

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self reloadCalendarItems];
//    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
//}

//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{   [self reloadCalendarItems];
//    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
//    
//}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    
//    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
//    
//    
//}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadCalendarItems];
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
//    [self reloadCalendarItems];
}
#pragma mark - FDCalendarItemDelegate

- (void)calendarItem:(FDCalendarItem *)item didSelectedDate:(NSDate *)date {

    self.date = date;
    [self setCurrentDate:self.date];
}

@end
