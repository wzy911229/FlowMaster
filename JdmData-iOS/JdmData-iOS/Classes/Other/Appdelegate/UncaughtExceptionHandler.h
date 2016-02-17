//
//  UncaughtExceptionHandler.h
//  iOSCrashDemo
//
//  Created by wzy on 16/1/15.
//  Copyright © 2016年 wzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UncaughtExceptionHandler : NSObject 
{
    BOOL dismissed;
}

void HandleException(NSException *exception);
void SignalHandler(int signal);
void InstallUncaughtExceptionHandler(void);

@end
