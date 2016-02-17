//
//  JDMSwitchStatus.h
//  JdmData-iOS
//
//  Created by test1 on 16/1/5.
//  Copyright © 2016年 jdmdata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDMSwitchStatus : NSObject
/** 保存是否是Wifi*/
+ (void)saveCurrentNetwork:(BOOL)isWIFI;
/** 获取网络状态 */
+ (BOOL)getCurrentNetwork;

/** 保存流量控制的开关 */
+ (void)saveFlowMangerSwitch:(BOOL)isOn;
/** 获取保存流量控制的开关 */
+ (BOOL)getFlowMangerSwitch;

@end
