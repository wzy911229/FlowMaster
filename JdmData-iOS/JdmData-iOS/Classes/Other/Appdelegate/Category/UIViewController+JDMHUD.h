//
//  UIViewController+JDMHUD.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/29.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIViewController (JDMHUD)
- (void)showTextMsgHUD:(NSString *)HUDStr andOffsetY:(CGFloat)offsetY;
- (void)showLoadingHUD:(NSString *)HUDStr andOffsetY:(CGFloat)offsetY;
- (void)hideHUD;


@end
