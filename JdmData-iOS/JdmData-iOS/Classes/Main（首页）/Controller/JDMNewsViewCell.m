//
//  JDMNewsViewCell.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/28.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMNewsViewCell.h"
#import "JDMNews.h"
#import "JDMAFNNetworkTools.h"
#import "JDMUserInfoTools.h"
#import "NSDate+JDMExtension.h"
#import "NSString+ZYExtension.h"

@interface JDMNewsViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *typeName;
/**点击数*/
@property (weak, nonatomic) IBOutlet UILabel *hitCount;
/**点赞数*/
@property (weak, nonatomic) IBOutlet UIButton *praiseCount;
/**新闻时间*/
@property (weak, nonatomic) IBOutlet UILabel *creatTime;

@end
@implementation JDMNewsViewCell


-(void)setNews:(JDMNews *)news
{
    _news =news;
    self.name.text = self.news.source;
    self.title.text = self.news.title;
    self.typeName.text = self.news.typeName;
    
    self.hitCount.text = [NSString setupButtonTextWithCount:self.news.hitcount headerTitle:nil footerTitle:@"次点击"];

    [self.praiseCount setTitle:[NSString setupButtonTextWithCount:self.news.praisecount headerTitle:nil footerTitle:@"人点赞"] forState:UIControlStateNormal];
    NSString *str = news.createtime;
    
    self.creatTime.text =str.create_time;
    
}
- (IBAction)clickPraiseCountButton {
    
     !self.clickPraiseCount ?:self.clickPraiseCount();
}


@end
