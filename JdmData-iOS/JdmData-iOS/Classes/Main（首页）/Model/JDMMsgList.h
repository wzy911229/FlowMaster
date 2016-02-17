//
//  JDMMsyList.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/16.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDMMsgList : NSObject
/** 登陆时间 */
@property (nonatomic, copy) NSString *createtime;
/** 标题*/
@property (nonatomic, copy) NSString *msgtitle;
/** 内容 */
@property (nonatomic, copy) NSString *msgtext;
/** 是否已读 */
@property (nonatomic, assign) bool  isreadflag;
/** 消息类型 */
@property (nonatomic, copy) NSString* msgtype;
/** 推送机型 */
@property (nonatomic, copy) NSString *platform;
/** 消息id */
@property (nonatomic, assign) NSInteger  ID;
/** 消息uuid */
@property (nonatomic, copy) NSString *uuid;

@end
