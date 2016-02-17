//
//  JDMUserInfo.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/30.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMUserInfoTools.h"
#import "JDMUser.h"
#import "JDMUserMsg.h"
#import <SSKeychain.h>

NSString * const Kcreatetime = @"createtime";
NSString * const Kgender = @"gender";
NSString * const KuserID = @"ID";
NSString * const kUserName = @"name";
NSString * const kphone = @"phone";
NSString * const kpwd = @"pwd";
NSString * const kuuid = @"uuid";
NSString * const kbigicon = @"bigicon";
NSString * const kloginid= @"loginid";
NSString * const kAccount = @"account ";
/** 设备字符串 */
NSString * const kService = @"com.wzy.JdmData-iOS";


@implementation JDMUserInfoTools

+ (void)saveUserAccount:(NSString *)account andPassword:(NSString *)password
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:account forKey:kAccount];
    [userDefaults synchronize];
    [SSKeychain setPassword:password forService:kService account:account];
}

+ (void)removeUserPasswordWithAccount:(NSString *)account
{
    [SSKeychain deletePasswordForService:kService account:account];
}
+ (NSString *)getAccount
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:kAccount];
}
+ (NSString *)getPasswordWithAccount:(NSString *)account
{
   return [SSKeychain passwordForService:kService account:account];
}



+ (void)saveAllUserInfo:(JDMUser*)user
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:user.dataObj.createtime forKey:Kcreatetime];
    [userDefaults setObject:user.dataObj.name forKey:kUserName];
    [userDefaults setInteger:user.dataObj.phone forKey:kphone];
    [userDefaults setInteger:user.dataObj.gender forKey:Kgender];
    [userDefaults setInteger:user.dataObj.ID forKey:KuserID];
    [userDefaults setObject:user.dataObj.uuid forKey:kuuid];
    NSString *icon = [NSString stringWithFormat:@"%@%@",JDMBaseURL,user.dataObj.bigicon];
    NSURL *bigiconurl = [NSURL URLWithString:icon];
    NSData *data = [NSData dataWithContentsOfURL:bigiconurl];
    [userDefaults setObject:data forKey:kbigicon];
    
    [userDefaults setInteger:user.dataObj.loginid forKey:kloginid];
    [userDefaults synchronize];
}

+ (void)updateUserName:(NSString *)userName
{
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     [userDefaults setObject:userName forKey:kUserName];
     [userDefaults synchronize];
}
+ (void)updateUserGender:(NSInteger)gender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:gender forKey:Kgender];
     [userDefaults synchronize];
}
+ (void)updateBigicon:(NSData *)bigicon
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:bigicon forKey:kbigicon];
     [userDefaults synchronize];
}


+ (JDMUser *)getAllUserInfo
{
    JDMUser *user = [JDMUser new];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    user.dataObj.createtime = [userDefaults objectForKey:Kcreatetime];
    user.dataObj.name = [userDefaults objectForKey:kUserName];
    user.dataObj.phone = [userDefaults integerForKey:kphone];
    user.dataObj.gender = [userDefaults integerForKey:Kgender];
    user.dataObj.ID = [userDefaults integerForKey:KuserID];
    user.dataObj.bigicon = [userDefaults objectForKey:kbigicon];
    user.dataObj.loginid = [userDefaults integerForKey:kloginid];
    
    return user;
}
+ (NSString *)getUserName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:kUserName];
}
+ (NSInteger )getUserGender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults integerForKey:Kgender];
}
+ (NSData *)getUserBigIcon
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:kbigicon];
}
+ (NSInteger)getUserPhoneNumber
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:kphone];
}
+ (NSInteger)getUserloginid
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:kloginid];
}
+ (NSString *)getUserUuid
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:kuuid];
}

@end
