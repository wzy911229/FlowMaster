//
//  JDMSettingArrowItem.h
//  JDM 
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import "JDMSettingItem.h"

@interface JDMSettingArrowItem : JDMSettingItem

/** 目的控制器的类名 Class:一般用assign */
@property (nonatomic, assign) Class descVc;

/** 描述是否需要登陆才能跳转 */
@property (nonatomic, assign) BOOL  isNeedLogin;

@end
