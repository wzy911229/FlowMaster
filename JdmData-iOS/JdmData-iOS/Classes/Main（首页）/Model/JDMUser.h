//
//  JDMUser.h
//  JdmData-iOS
//
//  Created by test1 on 15/11/19.
//  Copyright © 2015年 jdmdata. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>
@class JDMUserMsg;

@interface JDMUser : NSObject

/** 登陆状态 */
@property (nonatomic, assign) BOOL status;
/** 登陆信息*/
@property (nonatomic, copy) NSString * msg;
/** 用户信息*/
@property (nonatomic,strong) JDMUserMsg * dataObj;

//+ (instancetype)shareUser;

@end
