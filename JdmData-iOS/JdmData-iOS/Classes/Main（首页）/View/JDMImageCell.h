//
//  JDMImageCell.h
//  01_图片左右缩放
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDMMovie;


@interface JDMImageCell : UICollectionViewCell

/** 电影信息模型 */
@property (nonatomic, strong) JDMMovie *movie;



@end

@interface JDMMovieBtn : UIButton

@end
