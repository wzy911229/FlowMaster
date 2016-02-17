//
//  JDMSign.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/7.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDMSignHistory.h"
@interface JDMSign : NSObject
/** 登陆状态 */
@property (nonatomic, assign) bool status;
/** 登陆信息*/
@property (nonatomic, copy) NSString * msg;
/** 签到信息*/
@property (nonatomic,strong) NSArray * dataList;

@end
