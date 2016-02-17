//
//  JDMMovieViewCell.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/2.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDMMovie;
@interface JDMMovieViewCell : UITableViewCell
/** 电影信息模型 */
@property (nonatomic, copy) JDMMovie *movie;
@end
