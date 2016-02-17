//
//  JDMMsgTableViewCell.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/16.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMMsgTableViewCell.h"

@interface JDMMsgTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;


@end
@implementation JDMMsgTableViewCell

- (void)awakeFromNib {

    [super awakeFromNib];
    self.dateLabel.layer.masksToBounds = YES;
    self.msgLabel.text = @"精迪敏数据科技有限公司是由母公司精迪敏移动互联网科技有限公司注资人民币6000万并控股,于2015年4月成立的高科技企业。";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
