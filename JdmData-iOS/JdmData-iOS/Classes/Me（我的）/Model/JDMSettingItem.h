//
//  JDMSettingItem.h
//  JDM 
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 JDM. All rights reserved.
// 描述设置界面的cell控件

#import <Foundation/Foundation.h>

// 根据行模型确定cell右边辅助视图
// 1.提供一个类型枚举，箭头，开头
// 2.用子类去判断cell的类型
typedef enum : NSUInteger {
    AccessoryViewTypeArrow,
    AccessoryViewTypeSwitch,
}  AccessoryViewType;


@interface JDMSettingItem : NSObject

/** 描述cell图片 */
@property (nonatomic, strong) UIImage *image;
/** 描述cell文字 */
@property (nonatomic, copy) NSString *title;

/** 描述cell子标题 */
@property (nonatomic, strong) NSString *subTitle;

/** 保存点击cell做的事情 */
@property (nonatomic, strong) void(^operationBlock)(NSIndexPath *indexPath);

/** 描述cell的样式 */
@property (nonatomic, assign) UITableViewCellStyle cellStyle;

/** 描述右边的控件 */
@property (nonatomic, assign) AccessoryViewType AccessoryViewType;

/** 自定义的控件 */
@property (nonatomic, strong) UIView * customAccessoryView;


///**------------- AccessoryViewTypeArrow需要跳转的箭头控制器---------------*/
//
///** 目的控制器的类名 Class:一般用assign */
//@property (nonatomic, assign) Class descVc;
//
///** 描述是否需要登陆才能跳转 */
//@property (nonatomic, assign) BOOL  isNeedLogin;
//
///**------------- AccessoryViewTypeSwitch需要跳转的箭头控制器---------------*/
///** 开关值 */
//@property (nonatomic, assign) BOOL isOpen;
/** 开关值 */
@property (nonatomic, assign) BOOL isClearCacheCell;


+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title;

@end
