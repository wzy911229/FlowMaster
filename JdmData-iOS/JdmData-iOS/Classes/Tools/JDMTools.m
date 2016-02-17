//
//  JDMTools.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/18.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMTools.h"
#import <SVProgressHUD.h>

@implementation JDMTools

+ (NSInteger)titleScriptProper
{
    if (JDMScreenW == 320) {
        return 15;
    }else if (JDMScreenW == 375)
    {
        return 16;
        
    }else if (JDMScreenW == 414)
    {
        return 17;
    }
    return 22;
}

+ (NSInteger)contentScriptProper
{
    if (JDMScreenW == 320) {
        return 10;
    }else if (JDMScreenW == 375)
    {
        return 13;
    }else if (JDMScreenW == 414)
    {
        return 15;
    }
    return 18;

}
+ (NSInteger)smallContentScriptProper
{
    if (JDMScreenW == 320) {
        return 9;
    }else if (JDMScreenW == 375)
    {
        return 11;
    }else if (JDMScreenW == 414)
    {
        return 13;
    }
    return 18;
    
}
/**
 *  适配cell高度
 */
+ (CGFloat)amusementCellProper
{
    if (JDMScreenW == 320) {
        return 220;
    }else if (JDMScreenW == 375)
    {
        return 270;
    }else if (JDMScreenW == 414)
    {
        return 300;
    }
    return 330;
}
/**
 *  适配组头部高度
 */
+ (CGFloat)sectionHeightProper
{
    if (JDMScreenW == 320) {
        return 16;
    }else if (JDMScreenW == 375)
    {
        return 20;
    }else if (JDMScreenW == 414)
    {
        return 30;
    }
    return 35;
}
/**
 *  适配cell高度
 */
+ (CGFloat)cellProper
{
    if (JDMScreenW == 320) {
        return 35;
    }else if (JDMScreenW == 375)
    {
        return 44;
    }else if (JDMScreenW == 414)
    {
        return 55;
    }
    return 65;
}
/**
 *  适配MB提醒框offset
 */
+ (CGFloat)MBProgressOffsetY
{
    if (JDMScreenW == 320) {
        return 180;
    }else if (JDMScreenW == 375)
    {
        return 180;
    }else if (JDMScreenW == 414)
    {
        return 180;
    }
    return 65;
}
@end
