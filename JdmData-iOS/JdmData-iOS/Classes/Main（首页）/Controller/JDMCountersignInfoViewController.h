//
//  JDMCountersignInfoViewController.h
//  JdmData-iOS
//
//  Created by test1 on 16/1/4.
//  Copyright © 2016年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDMCountersignInfoViewController : UIViewController
/** 金额*/
@property(nonatomic,copy) NSString * money;
/** 购买量*/
@property(nonatomic,copy) NSString * num;
/** 购买手机号*/
@property(nonatomic,copy) NSString * phone;

@end
