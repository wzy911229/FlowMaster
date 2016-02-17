//
//  JDMMyInformation.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/7.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDMMyInformation : NSObject
/** 等级 */
@property (nonatomic, copy) NSString *grade;
/** 头像 */
@property (nonatomic, copy) NSString *imageUrl;
/** 昵称 */
@property (nonatomic, copy) NSString *name;
/** 性别 */
@property (nonatomic, assign) NSInteger  gender;
/** phone */
@property (nonatomic, assign) NSInteger phone;
/** 归属地 */
@property (nonatomic, copy) NSString *place;

@end
