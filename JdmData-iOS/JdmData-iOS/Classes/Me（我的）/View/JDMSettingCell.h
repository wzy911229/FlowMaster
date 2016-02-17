//
//  JDMSettingCell.h
//  JDM 
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDMSettingItem;
@interface JDMSettingCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)cellStyle;


/** item行模型,描述cell的外观 */
@property (nonatomic, strong) JDMSettingItem *item;
/** 显示当前缓存 */
- (void)reset;
@end
