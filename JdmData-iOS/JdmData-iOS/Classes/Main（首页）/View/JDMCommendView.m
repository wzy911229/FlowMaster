//
//  JDMCommendView.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/13.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMCommendView.h"
#import "JDMActivityCommendViewController.h"
#import "JDMNews.h"


@interface JDMCommendView ()

@property (weak, nonatomic) IBOutlet UIButton *allButton;

@end

@implementation JDMCommendView



- (void)awakeFromNib
{

    self.atnameColors = @[JDMColor(0x7ecef4),JDMColor(0xe88551),JDMColor(0x8c97cb),JDMColor(0xe86877)];
    self.commendButton.titleLabel.font = [UIFont systemFontOfSize: [JDMTools titleScriptProper]];
    self.allButton.titleLabel.font = [UIFont systemFontOfSize: [JDMTools titleScriptProper]];
   
}

- (void)setNewsArray:(NSArray *)NewsArray
{
    _NewsArray = NewsArray;
    [self createSquareBtnsWithArray:NewsArray];
}

-(void)setCommendArray:(NSArray *)CommendArray
{
    _CommendArray = CommendArray;;
    [self createSquareBtnsWithArray:CommendArray];
}
/**
 *  创建方块按钮
 */
- (void)createSquareBtnsWithArray:(NSArray*)array
{
    
    NSUInteger count = array.count > 4 ? 4 :  array.count;
    NSInteger totalColCount = 2;
    CGFloat buttonW = JDMScreenW / totalColCount;
    CGFloat buttonH = self.CommendBtnHProper;
    for (int i = 0; i < count; i++) {
       
        // 创建按钮
        JDMCommendBtn *button = [JDMCommendBtn viewFromNib];
        button.width = buttonW ;
        button.height = buttonH;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClick:)];
        [button addGestureRecognizer:tap];

        //新闻按钮
        if ([array[i]  isKindOfClass: [JDMNews class]]) {
            JDMNews *news = array[i];
            button.name.text = news.title;
            button.atitle.text = news.typeName;
            NSString *str = [NSString stringWithFormat:@"news_%d",i];
            button.CommendImage.image  =[UIImage imageNamed:str];
            button.uuid = news.uuid;
            button.isNews = YES;
        }else//活动按钮
        {
            button.CommendImage.image = [UIImage imageNamed:array[i]];
        }
        
        button.atitle.textColor = JDMColor(0x999999);
        button.name.textColor = self.atnameColors[i];
       
        
        button.x = (i % totalColCount) * buttonW;
        button.y = (i / totalColCount) * buttonH;
        
        [self.view addSubview:button];
        
    }
    
}

//具体活动界面
- (void)buttonClick:(UITapGestureRecognizer*)tap
{
    if ([_delegate respondsToSelector:@selector(commendView:activityButton:)]) {
        [_delegate commendView:self activityButton:(JDMCommendBtn *)tap.view];
    }
}
- (IBAction)clickAllBtn:(UIButton*)sender {
       sender.tag = self.NewsArray.count == 0 ? 0 : 1;
    if ([_delegate respondsToSelector:@selector(commendView:allBtn:)]) {
        [_delegate commendView:self allBtn:sender];
        
    }
}
#pragma mark - 适配

/**
 * 按钮高度适配
 */
- (NSInteger)CommendBtnHProper
{
    if (JDMScreenW == 375)
    {
       return  65;
    }else if (JDMScreenW == 414)
    {   return 70;
        
    }else if (JDMScreenW == 320){
        return  55;;
    }
    return 80;
}


@end


@interface JDMCommendBtn ()


@end
@implementation JDMCommendBtn



-(void)layoutSubviews
{
    [super layoutSubviews];
    self.name.font = [UIFont systemFontOfSize:[JDMTools contentScriptProper]];
    self.atitle.font = [UIFont systemFontOfSize:[JDMTools smallContentScriptProper]];
}

@end
