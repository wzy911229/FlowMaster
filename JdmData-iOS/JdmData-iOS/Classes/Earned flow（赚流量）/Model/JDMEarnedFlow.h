//
//  JDMEarnedFlow.h
//  JdmData-iOS
//
//  Created by test1 on 15/11/17.
//  Copyright © 2015年 jdmdata. All rights reserved.
// 赚流量模型

#import <Foundation/Foundation.h>

@interface JDMEarnedFlow : NSObject
/** 图片url */
@property (nonatomic, copy) NSString *imageurl;
/** 文字名 */
@property (nonatomic, copy) NSString *name;

//+ (instancetype)EarnedFlowWithDict:(NSDictionary *)dict;

@end
