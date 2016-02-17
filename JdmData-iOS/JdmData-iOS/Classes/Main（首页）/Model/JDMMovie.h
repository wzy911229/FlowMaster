//
//  JDMMovie.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/2.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDMMovie : NSObject

/** 开始时间 */
@property (nonatomic, copy) NSString *createtime;
/** 首页图片 */
@property (nonatomic, copy) NSString* listimgurl;
/** 电影彩页 */
@property (nonatomic, copy) NSString* homeimgurl;
/** 参加人数 */
@property (nonatomic, assign) NSInteger playcount;
/** 视频连接 */
@property (nonatomic, copy) NSString *videourl;
/** 标题 */
@property (nonatomic, copy) NSString *name;
/** 详情 */
@property (nonatomic, copy) NSString *info;
/** id */
@property (nonatomic, assign) NSInteger  ID;
@end
