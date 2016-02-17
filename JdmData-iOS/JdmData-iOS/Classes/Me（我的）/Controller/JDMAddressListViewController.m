//
//  JDMAddressListViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/1.
//  Copyright © 2015年 jdmdata. All rights reserved.
//


#import "JDMAddressListViewController.h"
#import <AddressBook/AddressBook.h>
#import "JDMAddressList.h"
#import "NSString+PinYin.h"
#import "JDMsearchResultViewController.h"



@interface JDMAddressListViewController ()<JDMAllSelectViewDelegate>
/** 选中数组*/
@property(strong,nonatomic)NSMutableArray *SelectCellArray;
/** 全选视图*/
@property(weak,nonatomic)JDMAllSelectView *allSelectView;

@end

@implementation JDMAddressListViewController


#pragma mark -生命周期方法
- (void)viewDidLoad
{
    [super viewDidLoad];
 [self.tableView setEditing:YES animated:NO];
    
      [self setupAllSelectView];
   
}

#pragma mark -内部控制方法

-(void)setupAllSelectView
{
    JDMAllSelectView *selectView= [JDMAllSelectView viewFromNib];
    selectView.frame = CGRectMake(0, JDMScreenH -44, JDMScreenW, 44);
     self.allSelectView = selectView;
    selectView.delegate =  self;
    self.allSelectView.hidden = YES;
    [self.view addSubview:selectView];
}


#pragma mark -代理方法

#pragma mark tableView代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      self.allSelectView.hidden = NO;
    [self.SelectCellArray addObject:indexPath];
  

    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
      [self.SelectCellArray removeObjectAtIndex:0];
    if (self.SelectCellArray.count == 0)
    {
        self.allSelectView.hidden = YES;
    }
    
}

#pragma mark AllSelectView<JDMAllSelectViewDelegate>

-(void)allSelectView:(JDMAllSelectView *)selectView clickAllSelectbtn:(UIButton *)AllSelectbtn
{
//    for (int row=0; row<self.allBooks.count; row++) {
//
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
//        UITableViewCell *oneCell = [self.tableView cellForRowAtIndexPath: indexPath];
//        oneCell.accessoryType = UITableViewCellAccessoryCheckmark;
////        NSLog(@"这是第%d行",indexPath.row);
//    }
    
    NSIndexPath *indexPath;
    int i = 0;
    for (NSDictionary *dict in self.addressArray) {
        int j =0;    i++;
        for (NSString *str in dict[@"content"])
        {
            j++;
            indexPath = [NSIndexPath indexPathForRow:j-1 inSection:i-1  ];
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            UITableViewCell *oneCell = [self.tableView cellForRowAtIndexPath: indexPath];
            oneCell.accessoryType = UITableViewCellAccessoryCheckmark;
            [AllSelectbtn setTitle:@"取消" forState:UIControlStateNormal];
            [self.SelectCellArray addObject:indexPath];
            if (!AllSelectbtn.selected) {
                [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
                AllSelectbtn.selected = NO;
                [self.SelectCellArray removeAllObjects];
                [AllSelectbtn setTitle:@"全选" forState:UIControlStateNormal];
            }
            
            
        }
        
    }
    
    
  
}


-(void)allSelectView:(JDMAllSelectView *)selectView clickSendMsgbtn:(UIButton *)SendMsgbtn
{
    JDMLogFunc;
}

#pragma mark - 懒加载

- (NSMutableArray *)SelectCellArray
{
    if (!_SelectCellArray) {
        _SelectCellArray = [NSMutableArray array];
        
    }
    return _SelectCellArray;
}


@end


@interface JDMAllSelectView ()

@end

@implementation JDMAllSelectView
- (IBAction)clickAllSelectbtn:(UIButton *)sender {
  sender.selected = !sender.selected ;
//    JDMLog(@"%d",sender.selected);
    
    if ( [_delegate respondsToSelector:@selector(allSelectView:clickAllSelectbtn:)] ) {
        
        [_delegate allSelectView:self clickAllSelectbtn:sender];
    }
   
    
}

- (IBAction)clickSendMsgBtn:(UIButton*)sender {
    if ( [_delegate respondsToSelector:@selector(allSelectView:clickSendMsgbtn:)] ) {
        
        [_delegate allSelectView:self clickSendMsgbtn:sender];
    }
}

@end
