//
//  JDMNews.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/28.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDMNews : NSObject<NSCoding>
/** author */
@property (nonatomic, copy) NSString *author;
/** source */
@property (nonatomic, copy) NSString *source;
/** 详情 */
@property (nonatomic, copy) NSString *title;
/** 新闻类型 */
@property (nonatomic, copy) NSString * typeName;
/** 点击数 */
@property (nonatomic, assign) NSInteger hitcount;
/** 点赞数 */
@property (nonatomic, assign) NSInteger praisecount;
/** uuid */
@property (nonatomic, copy) NSString *uuid;
/** 开始时间 */
@property (nonatomic, copy) NSString *createtime;

@end
