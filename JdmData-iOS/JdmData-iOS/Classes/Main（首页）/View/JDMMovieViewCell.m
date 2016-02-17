//
//  JDMMovieViewCell.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/2.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMovieViewCell.h"
#import "JDMMovie.h"
#import "JDMSwitchStatus.h"
#import "UIImageView+JDMExtension.h"
#import "NSString+ZYExtension.h"

@interface JDMMovieViewCell ()
/**观看经验*/
@property (weak, nonatomic) IBOutlet UIButton *experience;
/**参加人数 */
@property (weak, nonatomic) IBOutlet UIButton *readCount;
/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *image;
/** 标题*/
@property (weak, nonatomic) IBOutlet UILabel *atName;
/** 描述*/
@property (weak, nonatomic) IBOutlet UILabel *aTitle;


@end

@implementation JDMMovieViewCell

- (void)awakeFromNib {
   
    [super awakeFromNib];
    [self setAttributedStr];
    self.atName.font = [UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.aTitle.font = [UIFont systemFontOfSize:[JDMTools contentScriptProper]];
}

-(void)setMovie:(JDMMovie *)movie
{
    _movie = movie;
   
    [self.readCount setTitle: [NSString setupButtonTextWithCount:self.movie.playcount headerTitle:nil footerTitle:@"次观看"] forState:UIControlStateNormal];
    
     [self.image  setImageWithCurrentNetwork:[NSURL URLWithString:movie.homeimgurl] isWIFI:[JDMSwitchStatus getCurrentNetwork] isSwitchOn:[JDMSwitchStatus getFlowMangerSwitch] WIFIWithplaceholderImage:[UIImage imageNamed:@"activity_img_01"]];
    
//    [self.image sd_setImageWithURL:[NSURL URLWithString:movie.homeimgurl] placeholderImage:[UIImage imageNamed:@"activity_img_01"]];
    
    self.atName.text = movie.name;
    self.aTitle.text = movie.info;
    
}
- (NSMutableAttributedString *)changeString:(NSString *)string WithColor:(UIColor *)color
{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = color;
    return  [[NSMutableAttributedString alloc]initWithString:string attributes:attrs];
    
    
}

-(void)setAttributedStr
{
    NSMutableAttributedString *string =[self changeString:@"观看赚" WithColor:[UIColor lightGrayColor]];
     NSMutableAttributedString *string1 =[self changeString:@"10" WithColor:[UIColor redColor]];
    NSMutableAttributedString *string2 =[self changeString:@"经验" WithColor:[UIColor lightGrayColor]];
    // 拼接另外一个属性文字
    [ string appendAttributedString:string1];
    
    [string appendAttributedString:string2];
    
   [self.experience setAttributedTitle: string forState:UIControlStateNormal];

}

@end
