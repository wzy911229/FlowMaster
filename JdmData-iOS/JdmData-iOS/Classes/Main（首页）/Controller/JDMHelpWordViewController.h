//
//  JDMHelpWordViewController.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/17.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDMHelpWordViewController : UITableViewController
@property(nonatomic,copy) void(^didSelectCell)(NSString *word);
@property(nonatomic,strong)NSMutableArray *helpArray;
@end
