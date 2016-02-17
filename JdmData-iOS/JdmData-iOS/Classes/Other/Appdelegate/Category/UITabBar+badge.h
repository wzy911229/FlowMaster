//
//  UITabBar+badge.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/3.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index;
@end
