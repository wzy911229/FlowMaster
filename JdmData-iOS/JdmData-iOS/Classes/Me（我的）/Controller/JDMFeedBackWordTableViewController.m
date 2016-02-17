//
//  JDMFeedBackWordTableViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/17.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMFeedBackWordTableViewController.h"

@interface JDMFeedBackWordTableViewController ()

@end

@implementation JDMFeedBackWordTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.helpArray removeAllObjects];
    [self.helpArray addObjectsFromArray:@[@"提意见",@"有错误",@"不会用",@"投诉"]];
    
}


@end
