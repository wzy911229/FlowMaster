//
//  JDMNewsViewCell.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/28.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDMNews;
@interface JDMNewsViewCell : UITableViewCell
/** block：点赞Block*/
@property (nonatomic, copy) void (^clickPraiseCount)();
/** 新闻模型*/
@property(nonatomic,strong) JDMNews *news;
@end
