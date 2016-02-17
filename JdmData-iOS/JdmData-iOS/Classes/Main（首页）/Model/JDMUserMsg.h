//
//  JDMUserMsg.h
//  JdmData-iOS
//
//  Created by test1 on 15/11/19.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDMUserMsg : NSObject

/** 登陆时间 */
@property (nonatomic, copy) NSString *createtime;
/** 性别 */
@property (nonatomic, assign) NSInteger  gender;
/** id */
@property (nonatomic, assign) NSInteger  ID;
/** name */
@property (nonatomic, copy) NSString *name;
/** phone */
@property (nonatomic, assign) NSInteger phone;
/** 密码 */
@property (nonatomic, copy) NSString *pwd;
/** uuid */
@property (nonatomic, copy) NSString *uuid;
/** bigicon */
@property (nonatomic, strong) NSString *bigicon;
/** loginid */
@property (nonatomic, assign) NSInteger loginid;



@end
