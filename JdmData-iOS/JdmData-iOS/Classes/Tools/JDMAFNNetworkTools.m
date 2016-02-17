//
//  JDMNetworkTools2.m
//
//
//  Created by apple on 15/8/12.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import "JDMAFNNetworkTools.h"

@implementation JDMAFNNetworkTools

+ (instancetype)shareNetworkTools
{
    static JDMAFNNetworkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *cfg  = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURL *url = [NSURL URLWithString:JDMBaseURL];
        
        instance = [[self alloc] initWithBaseURL:url sessionConfiguration:cfg];
        //设置网络请求超时时间:默认60s
        
        instance.requestSerializer.timeoutInterval = 20.0;
        
        instance.requestSerializer.cachePolicy =  NSURLRequestReloadRevalidatingCacheData;
    });
    return instance;
}
@end
