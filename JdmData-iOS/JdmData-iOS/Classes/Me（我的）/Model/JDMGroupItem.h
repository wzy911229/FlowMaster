//
//  JDMGroupItem.h
//  JDM 
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 JDM. All rights reserved.
//  组模型：描述每一组，描述多少行，描述头部标题，尾部标题

#import <Foundation/Foundation.h>

@interface JDMGroupItem : NSObject

/** 描述当前组有多少行 存放一个行模型数组 */
@property (nonatomic, strong) NSArray *items;

/** 头部标题 */
@property (nonatomic, strong) NSString *headerTitle;

/** 尾部标题 */
@property (nonatomic, strong) NSString *footerTitle;


+ (instancetype)groupWithItems:(NSArray *)items;


@end
