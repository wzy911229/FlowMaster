//
//  JDMTools.h
//  JdmData-iOS
//
//  Created by test1 on 15/11/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDMTools : NSObject
/**
 *  标题字体设配
 */
+ (NSInteger)titleScriptProper;
/**
 *  内容字体设配
 */
+ (NSInteger)contentScriptProper;
/**
 *  小内容字体设配
 */
+ (NSInteger)smallContentScriptProper;


/**
 *  适配适配活动cell高度
 */
+ (CGFloat)amusementCellProper;
/**
 *  适配组头部高度
 */
+ (CGFloat)sectionHeightProper;
/**
 *  适配适配普通cell高度
 */
+ (CGFloat)cellProper;


/**
 *  适配MB提醒框offset
 */
+ (CGFloat)MBProgressOffsetY;

@end
