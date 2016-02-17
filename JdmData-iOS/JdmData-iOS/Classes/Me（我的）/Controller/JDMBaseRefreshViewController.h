//
//  JDMBaseRefreshViewController.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/15.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

@interface JDMBaseRefreshViewController : UITableViewController

/** 这个block的作用：传递头部下拉刷新该做某事 */
@property (nonatomic, copy) void (^getHeaderBlock)();

/** 这个block的作用：传递底部上拉刷新该做某事 */
@property (nonatomic, copy) void (^getFooterBlock)();

@end
