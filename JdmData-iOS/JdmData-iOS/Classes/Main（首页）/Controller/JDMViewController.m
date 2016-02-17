//
//  JDMViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/24.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMViewController.h"
#import "ANDLineChartView.h"

@interface JDMViewController () <ANDLineChartViewDataSource,ANDLineChartViewDelegate>
{
    
    NSArray *_elements;
    NSUInteger _numbersCount;
    NSUInteger _maxValue;
    ANDLineChartView *_chartView;
    
}
@end

@implementation JDMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupConstraints{
    
    id topLayoutGuide = [self topLayoutGuide];
    NSDictionary *viewsDict = NSDictionaryOfVariableBindings(topLayoutGuide,_chartView);
    
    [[self view] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide][_chartView]|"
                                                                        options:0 metrics:nil views:viewsDict]];
    [[self view] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_chartView]|" options:0 metrics:nil views:viewsDict]];
    
}

- (void)setupView
{
    CGRect frame = CGRectZero;
    if(JDMScreenW < 350)
    {
        frame = CGRectMake(0, 0, JDMScreenW -30, 100);
    }else
    {
        frame = CGRectMake(0, 0, JDMScreenW -50, 150);
    }
    _chartView = [[ANDLineChartView alloc] initWithFrame:frame];
    //    [self.chaView setTranslatesAutoresizingMaskIntoConstraints:YES];
    //    [_chartView setTranslatesAutoresizingMaskIntoConstraints: YES];
    [_chartView setDataSource:self];
    [_chartView setDelegate:self];
    //  [_chartView setAnimationDuration:0.4];
    [self.view addSubview: _chartView];
    _elements = [self arrayWithRandomNumbers];
    
    [self setupConstraints];
    
    
    
    _chartView.chartBackgroundColor =[UIColor whiteColor];
    _chartView.gridIntervalLinesColor = [UIColor lightGrayColor];
    _chartView.gridIntervalFontColor = [UIColor grayColor];
    _chartView.elementFillColor = [UIColor clearColor];
    _chartView.elementStrokeColor = [UIColor colorWithRed:116 /255.0 green:196/255.0  blue:225/255.0  alpha:1];
    _chartView.lineColor = [UIColor colorWithRed:116 /255.0 green:196/255.0  blue:225/255.0  alpha:1];
   
}

//数值
- (NSArray*)arrayWithRandomNumbers{
    _numbersCount = 20;//arc4random_uniform(MAX_NUMBER_COUNT + 1) + 1;
    _maxValue = 71;//arc4random_uniform(MAX_NUMBER + 1);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:_numbersCount];
    
    for(NSUInteger i = 0;i<_numbersCount;i++){
        NSUInteger r = arc4random_uniform((u_int32_t)_maxValue + 1) ;
        [array addObject:@(r)];
    }
    return array;
}

- (BOOL)automaticallyAdjustsScrollViewInsets{
    
    return NO;
}

#pragma mark
#pragma mark - ANDLineChartViewDataSource methods
//多少个点
- (NSUInteger)numberOfElementsInChartView:(ANDLineChartView *)graphView{
    return _numbersCount;
}

//提供具体数值取法
- (CGFloat)chartView:(ANDLineChartView *)graphView valueForElementAtRow:(NSUInteger)row{
    return [(NSNumber*)_elements[row] floatValue];
}

//最大刻度
- (CGFloat)maxValueForGridIntervalInChartView:(ANDLineChartView *)graphView{
    return _maxValue;
}
//最小刻度
- (CGFloat)minValueForGridIntervalInChartView:(ANDLineChartView *)graphView{
    return 0;
}
//纵向刻度个数
- (NSUInteger)numberOfGridIntervalsInChartView:(ANDLineChartView *)graphView{
    return 4;
}

//提供点的具体数值
- (NSString*)chartView:(ANDLineChartView *)graphView descriptionForGridIntervalValue:(CGFloat)interval{
    return [NSString stringWithFormat:@"%.0f",interval];
}

#pragma mark
#pragma mark - ANDLineChartViewDelegate method
//横向刻度距离
- (CGFloat)chartView:(ANDLineChartView *)graphView spacingForElementAtRow:(NSUInteger)row{
    return 30;
}

@end
