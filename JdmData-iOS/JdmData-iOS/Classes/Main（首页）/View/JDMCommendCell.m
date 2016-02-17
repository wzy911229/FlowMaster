//
//  JDMCommendCell.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/23.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMCommendCell.h"
#import "JDMCommend.h"
#import "JDMSwitchStatus.h"
#import "UIImageView+JDMExtension.h"
#import "NSString+ZYExtension.h"

@interface JDMCommendCell ()
/**剩余天数*/
@property (weak, nonatomic) IBOutlet UIButton *lastDays;
/**参加人数 */
@property (weak, nonatomic) IBOutlet UIButton *readCount;
/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *image;
/** 标题*/
@property (weak, nonatomic) IBOutlet UILabel *atName;
/** 描述*/
@property (weak, nonatomic) IBOutlet UILabel *aTitle;

@end

@implementation JDMCommendCell
-(void)awakeFromNib
{
    self.atName.font = [UIFont systemFontOfSize: [JDMTools titleScriptProper]];
    self.aTitle.font = [UIFont systemFontOfSize: [JDMTools contentScriptProper]];

   
}
- (void)setCommend:(JDMCommend *)commend
{
    
    _commend = commend;
    NSString *imageUrl =nil;
    if (!commend.isLoadFullPath) {imageUrl = [NSString stringWithFormat:@"%@%@",JDMBaseURL,commend.imageurl];}
   
    [self.readCount setTitle:[NSString setupButtonTextWithCount:commend.readcount headerTitle:nil footerTitle:@"人参加"] forState:UIControlStateNormal];
    //获得活动剩余天数
    NSInteger lastday = [self haveDays];
    
     lastday =  lastday < 0 ? 0 :lastday;
    
    [self.lastDays setTitle:[NSString stringWithFormat:@"还剩%ld天",(long)lastday] forState:UIControlStateNormal];
    self.atName.text = self.commend.atname;
    self.aTitle.text = self.commend.atitle;
    
    [self.image setImageWithCurrentNetwork:[NSURL URLWithString:imageUrl] isWIFI:[JDMSwitchStatus getCurrentNetwork] isSwitchOn:[JDMSwitchStatus getFlowMangerSwitch] WIFIWithplaceholderImage:[UIImage imageNamed:@"activity_img_01"]];
    
     [self haveDays];
  }

static NSDateFormatter *formatter_ ;

- (NSInteger)haveDays
{
    formatter_ = [[NSDateFormatter alloc]init];
    formatter_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *nowString = [formatter_ stringFromDate:[NSDate date]];
  
    NSDate *nowDate = [formatter_ dateFromString:nowString];
    
    NSDate *selfDate = [formatter_ dateFromString:self.commend.enddate];

    // 获得2个日期之间的差值
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:nowDate toDate:selfDate options:0];

    return cmps.day;
    
}



- (void) setFrame:(CGRect)frame
{

    frame.size.height -= 20;
    [super setFrame:frame];
}

@end
