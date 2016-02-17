//
//  JDMAddressListFlowViewController.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/10.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMBaseAddressListViewController.h"

@interface JDMAddressListFlowViewController : JDMBaseAddressListViewController
@property (assign, nonatomic)  BOOL isPopVc;
@property(copy,nonatomic) void(^getPhone)(NSString* phoneNum);
@end
