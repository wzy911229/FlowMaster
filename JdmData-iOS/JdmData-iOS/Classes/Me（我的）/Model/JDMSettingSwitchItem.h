//
//  JDMSettingSwitchItem.h
//  JDM 
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import "JDMSettingItem.h"

@interface JDMSettingSwitchItem : JDMSettingItem
/** 开关值 */
@property (nonatomic, assign) BOOL isOpen;
/** 当开关打开时候做的事 */
@property (nonatomic, strong) void(^doSomethingWhenSwitchOpen)(UISwitch*switchView);
@end
