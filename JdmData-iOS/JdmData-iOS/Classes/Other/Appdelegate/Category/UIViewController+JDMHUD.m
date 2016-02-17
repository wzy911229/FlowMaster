//
//  UIViewController+JDMHUD.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/29.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "UIViewController+JDMHUD.h"
//typedef  NS_ENUM(NSUInteger,HUDType)
//{
//    HUDTypeAnnularDeterminate = MBProgressHUDModeAnnularDeterminate,
//    HUDTypeModeDeterminate = MBProgressHUDModeDeterminate,
//    HUDTypeDeterminateHorizontalBar = MBProgressHUDModeDeterminateHorizontalBar
//    
//};
@implementation UIViewController (JDMHUD)
- (void)showTextMsgHUD:(NSString *)HUDStr andOffsetY:(CGFloat)offsetY
{
  
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = HUDStr;
    hud.yOffset = offsetY;
    hud.margin = 10.0f;
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
  
}
- (void)showLoadingHUD:(NSString *)HUDStr andOffsetY:(CGFloat)offsetY
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES];
     hud.labelText =  HUDStr;
     hud.yOffset = offsetY;
     hud.margin = 10.0f;
    hud.userInteractionEnabled = NO;
     hud.removeFromSuperViewOnHide = YES;
}

//- (void)showProgressWith:(CGFloat)Progress andType:(HUDType)HUDMode
//{
//     MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [self.navigationController.view addSubview:HUD];
//    // Set determinate mode
//     HUD.mode = (MBProgressHUDMode)HUDMode;
////     HUD.labelText = @"Loading";
//    [HUD showWhileExecuting:@selector(myProgressTask:) onTarget:self withObject:HUD animated:YES];
//}
//
//-(void)myProgressTask:(MBProgressHUD*)HUD
//{
//    HUD
//    
//}

- (void)hideHUD
{
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES];
}

@end
