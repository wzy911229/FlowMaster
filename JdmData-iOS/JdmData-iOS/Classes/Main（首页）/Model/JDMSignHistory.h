//
//  JDMSignHistory.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/7.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDMSignHistory : NSObject

/** 登陆时间 */
@property (nonatomic, copy) NSString *createtime;
/** id */
@property (nonatomic, assign) NSInteger * ID;
/**签到时间*/
@property (nonatomic, copy) NSString *attenddate;
/** uuid */
@property (nonatomic, copy) NSString *uuid;
@end
