//
//  UncaughtExceptionHandler.m
//  iOSCrashDemo
//
//  Created by wzy on 16/1/15.
//  Copyright © 2016年 wzy. All rights reserved.
//

#import "UncaughtExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import <MessageUI/MessageUI.h>

@interface UncaughtExceptionHandler ()<MFMailComposeViewControllerDelegate>

@end
NSString * errorMSg = nil;
NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;


@implementation UncaughtExceptionHandler

+ (NSArray *)backtrace
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (
         i = UncaughtExceptionHandlerSkipAddressCount;
         i < UncaughtExceptionHandlerSkipAddressCount +
         UncaughtExceptionHandlerReportAddressCount;
         i++)
    {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
    return backtrace;
}

//- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex
//{
//
//    if (anIndex == 0)
//    {
//        dismissed = YES;
//    }else if (anIndex==1) {
//        NSLog(@"ssssssss");
//    }
//}

- (void)validateAndSaveCriticalApplicationData
{

}

- (void)handleException:(NSException *)exception
{
    [self validateAndSaveCriticalApplicationData];
    //拼接异常
    NSString *errorContent =[NSString stringWithFormat:NSLocalizedString(
                                                                         @"如果点击继续，程序有可能会出现其他的问题，建议您还是点击退出按钮并重新打开\n\n"
                                                                         @"异常原因如下:\n%@\n%@\n%@", nil),
                              [exception name],
                              [exception reason],
                             [[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]];
    
    
    errorMSg = errorContent;
  

    //弹出UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"抱歉，程序出现了异常"
                                                                             message:errorContent
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    

    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"继续尝试" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"点击了[继续尝试]");
        
    }];

    UIAlertAction *exitBtn = [UIAlertAction actionWithTitle:@"退出并反馈" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [self sendErrorMsg];
        
    }];
    
    [alertController addAction:sure];
    [alertController addAction:exitBtn];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (!dismissed)
    {
        for (NSString *mode in (__bridge NSArray *)allModes)
        {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
    CFRelease(allModes);
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName])
    {
        kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
    }
    else
    {
        [exception raise];
    }
}
//发送反馈邮件
- (void)sendErrorMsg
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    
    //设置主题
    [picker setSubject:@"程序异常反馈报告"];
    
    //设置收件人
    NSArray *toRecipients = [NSArray arrayWithObjects:@"540825129@qq.com",nil];
    //抄送人
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"1010171364@qq.com",nil];
    //密送人
    NSArray *bccRecipients = [NSArray arrayWithObjects:@"1010171364@qq.com",nil];
    
    [picker setToRecipients:toRecipients];
    [picker setCcRecipients:ccRecipients];
    [picker setBccRecipients:bccRecipients];
    
//    //设置附件为图片
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"man"
//                                                     ofType:@"jpg"];
//    NSData *myData = [NSData dataWithContentsOfFile:path];
//    [picker addAttachmentData:myData mimeType:@"image/png"
//                     fileName:@"man"];
    
    // 设置邮件发送内容
    NSString *emailBody = errorMSg;
    [picker setMessageBody:emailBody isHTML:NO];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picker animated:YES completion:nil];
    
}
//邮件反馈代理
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: //取消
            NSLog(@"MFMailComposeResultCancelled-取消");
            break;
        case MFMailComposeResultSaved: // 保存
            NSLog(@"MFMailComposeResultSaved-保存邮件");
            break;
        case MFMailComposeResultSent: // 发送
            NSLog(@"MFMailComposeResultSent-发送邮件");
            break;
        case MFMailComposeResultFailed: // 尝试保存或发送邮件失败
            NSLog(@"MFMailComposeResultFailed: %@...",[error localizedDescription]);
            break;
    }
    
    // 关闭邮件发送视图
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:^{
        //退出动画
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [UIView animateWithDuration:1.0f animations:^{
            window.alpha = 0;
            window.frame = CGRectMake(0, 0, 0, 0);
            
        } completion:^(BOOL finished) {
            exit(0);
        }];
    }];
  
  
    
    
}

@end
// 异常处理
void HandleException(NSException *exception)
{
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum)
    {
        return;
    }
    
    NSArray *callStack = [UncaughtExceptionHandler backtrace];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
    [[[UncaughtExceptionHandler alloc] init] performSelectorOnMainThread:@selector(handleException:)
                                                              withObject:[NSException exceptionWithName:[exception name] reason:[exception reason] userInfo:userInfo]
                                                           waitUntilDone:YES];

}

void SignalHandler(int signal)
{
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    
    if (exceptionCount > UncaughtExceptionMaximum)
    {
        return;
    }
    
    NSMutableDictionary *userInfo =[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey];
    
    NSArray *callStack = [UncaughtExceptionHandler backtrace];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
    
    
    id exception = [NSException exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
                                           reason:[NSString stringWithFormat:NSLocalizedString(@"Signal %d was raised.", nil),signal]
                                         userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey]];
    
    [[[UncaughtExceptionHandler alloc] init]  performSelectorOnMainThread:@selector(handleException:)
                                                               withObject:exception
                                                            waitUntilDone:YES];
}

void InstallUncaughtExceptionHandler(void)
{
    NSSetUncaughtExceptionHandler(&HandleException);
    signal(SIGABRT, SignalHandler);
    signal(SIGILL, SignalHandler);
    signal(SIGSEGV, SignalHandler);
    signal(SIGFPE, SignalHandler);
    signal(SIGBUS, SignalHandler);
    signal(SIGPIPE, SignalHandler);
}


