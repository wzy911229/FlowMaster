//
//  JDMUserInfo.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/30.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDMUser;
@interface JDMUserInfoTools : NSObject
/** 保存账户和密码*/
+ (void)saveUserAccount:(NSString *)account andPassword:(NSString *)password;
/** 根据账户删除密码*/
+ (void)removeUserPasswordWithAccount:(NSString *)account;
/** 获取保存的用户*/
+ (NSString *)getAccount;
/** 根据账户获取密码*/
+ (NSString *)getPasswordWithAccount:(NSString *)account;

/** 本地化所有用户信息*/
+ (void)saveAllUserInfo:(JDMUser*)user;
/** 本地化用户昵称*/
+ (void)updateUserName:(NSString *)userName;
/** 本地化用户性别*/
+ (void)updateUserGender:(NSInteger)gender;
/** 本地化用户头像*/
+ (void)updateBigicon:(NSData *)bigicon;

/** 获取本地所有用户信息*/
+ (JDMUser *)getAllUserInfo;
/** 获取本地用户昵称*/
+ (NSString *)getUserName;
/** 获取本地用户性别*/
+ (NSInteger )getUserGender;
/** 获取本地用户头像*/
+ (NSData *)getUserBigIcon;
/** 获取本地用户手机号*/
+ (NSInteger)getUserPhoneNumber;
/** 获取本地用户loginid*/
+ (NSInteger)getUserloginid;
/** 获取本地用户uuid*/
+ (NSString *)getUserUuid;
@end
