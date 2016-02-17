//
//  JDMsearchResultViewController.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/2.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDMsearchResultViewController ;
@protocol JDMsearchResultViewControllerDelegate <NSObject>
-(void)searchResultViewController:(JDMsearchResultViewController*)searchResultVc selectName:(NSString*)selectName;
@end

@interface JDMsearchResultViewController : UITableViewController
@property(nonatomic,strong)NSMutableArray *searchBooks;
@property(nonatomic,strong)NSMutableArray *addressBookArray;
@property(nonatomic,weak)id<JDMsearchResultViewControllerDelegate> delegate;
@end
