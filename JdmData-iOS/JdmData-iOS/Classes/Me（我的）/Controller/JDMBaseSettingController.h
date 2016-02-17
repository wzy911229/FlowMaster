//
//  JDMBaseSettingController.h
//  JDM 
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDMSettingItem.h"
#import "JDMSettingArrowItem.h"
#import "JDMSettingSwitchItem.h"
#import "JDMSettingCell.h"
#import "JDMGroupItem.h"

@interface JDMBaseSettingController : UITableViewController
// 总共的组数
@property (nonatomic, strong) NSMutableArray *groups;
// 自定义的row
@property (nonatomic, assign) NSInteger  row;


@end
