//
//  JDMBugXBViewController.m
//  JdmData-iOS
//
//  Created by test1 on 16/1/4.
//  Copyright © 2016年 jdmdata. All rights reserved.
//

#import "JDMBugXBViewController.h"
#import "JDMBugFlowInfoViewController.h"

@interface JDMBugXBViewController ()
@property (weak, nonatomic) IBOutlet UIView *buttonContentView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
/** 选中的Button*/
@property (weak, nonatomic) UIButton *selectButton;
/** 购买量*/
@property(nonatomic,copy) NSString * buyNum;
/** 描述*/
@property(nonatomic,strong) NSArray *squareBtns;

@end

@implementation JDMBugXBViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *squareBtns = @[@"10",@"30",@"50",@"100",@"200",@"500"];
    self.squareBtns = squareBtns;
    [self createSquareBtns:squareBtns WithTotalColCount:3];
    
    self.moneyLabel.text = @"10.00元";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}
/**
 *  创建方块按钮
 */
- (void)createSquareBtns:(NSArray *)squareBtns WithTotalColCount:(NSInteger)totalColCount
{
    
    NSUInteger count = squareBtns.count;
    CGFloat buttonW = (JDMScreenW-15) / totalColCount;
    CGFloat buttonH = (self.buttonContentView.height - 20) / 2;
    for (int i = 0; i < count; i++) {
       
        // 创建按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
       
        [button setTitle: [NSString stringWithFormat:@"%@牛",squareBtns[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(selectButtons:) forControlEvents:UIControlEventTouchUpInside];
        // 计算frame
        button.width = buttonW -15;
        button.height = buttonH - 15;
        button.x = (i % totalColCount) * buttonW +15;
        button.y = (i / totalColCount) * buttonH +15;
        button.tag = i;
        if (i==0)
        {button.selected = YES;
        self.selectButton = button;
        }
     [self.buttonContentView addSubview:button];
    }
    
}
         
-(void)selectButtons:(UIButton *)btn
{
    self.selectButton.selected = NO;
    btn.selected = YES;
    self.selectButton = btn;
    self.buyNum = btn.titleLabel.text;
   self.moneyLabel.text =[NSString stringWithFormat:@"%@.00元",self.squareBtns[btn.tag]];
}

- (IBAction)clickNextButton:(id)sender {
    
    JDMBugFlowInfoViewController *buyFlowInfoVc = [[UIStoryboard storyboardWithName:@"JDMBugFlowInfoViewController" bundle:nil] instantiateInitialViewController];
    buyFlowInfoVc.money = self.moneyLabel.text;
    buyFlowInfoVc.num = self.buyNum;
    [self.navigationController pushViewController:buyFlowInfoVc animated:YES];
}
@end
