//
//  JDMAddressList.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/1.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDMAddressList : NSObject
/** 通讯录姓名 */
@property (nonatomic, copy) NSString *name;
/** 通讯录电话号码 */
@property (nonatomic, copy) NSString *phoneNumber;
/** 通讯录首字母 */
@property (nonatomic, copy) NSString *title;

@end