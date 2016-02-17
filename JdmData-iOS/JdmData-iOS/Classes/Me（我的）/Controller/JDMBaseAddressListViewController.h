//
//  JDMBaseAddressListViewController.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/1.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDMBaseAddressListViewController : UIViewController
@property(nonatomic,weak)UITableView *tableView;
/** 姓名排序数组*/
@property(nonatomic,strong)NSMutableArray *addressArray;

@end
