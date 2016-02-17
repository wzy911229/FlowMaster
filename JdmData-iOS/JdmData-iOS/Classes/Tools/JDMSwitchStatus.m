//
//  JDMSwitchStatus.m
//  JdmData-iOS
//
//  Created by test1 on 16/1/5.
//  Copyright © 2016年 jdmdata. All rights reserved.
//

#import "JDMSwitchStatus.h"
NSString * const KFlowMangerSwitch = @"flowMangerSwitch";
NSString * const KCurrentNetwork = @"CurrentNetwork";


@implementation JDMSwitchStatus
+ (void)saveCurrentNetwork:(BOOL)isWIFI
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isWIFI forKey:KCurrentNetwork];
    
}
+ (BOOL)getCurrentNetwork
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults boolForKey:KCurrentNetwork];
}

+ (void)saveFlowMangerSwitch:(BOOL)isOn
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     [userDefaults setBool:isOn forKey:KFlowMangerSwitch];
  
}
+ (BOOL)getFlowMangerSwitch
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults boolForKey:KFlowMangerSwitch];
}
//+ (BOOL )getUserGender
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//   
//}
//+ (BOOL)getUserBigIcon
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//   
//}
//+ (BOOL)getUserPhoneNumber
//{
//   return <#expression#>
//}

@end
