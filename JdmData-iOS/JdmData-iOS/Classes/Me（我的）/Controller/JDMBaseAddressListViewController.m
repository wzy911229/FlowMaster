//
//  JDMAddressListViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/1.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMBaseAddressListViewController.h"
#import <AddressBook/AddressBook.h>
#import "JDMAddressList.h"
#import "NSString+PinYin.h"
#import "JDMsearchResultViewController.h"
#import <MBProgressHUD.h>

static NSString *ID = @"cell";
#define HUDMsg @"世界那么大,请多出去走走"

@interface JDMBaseAddressListViewController ()<UISearchResultsUpdating,UISearchControllerDelegate,UITableViewDataSource,UITableViewDelegate,JDMsearchResultViewControllerDelegate>
/** 姓名和电话对应字典数组*/
@property(nonatomic,strong)NSMutableArray *addressBookArray;
/** 搜索控件*/
@property(nonatomic,strong)UISearchController *searchVc;
/** 所有的姓名数组*/
@property(strong, nonatomic) NSMutableArray *allBooks;
/** 选中的姓名数组*/
@property(strong, nonatomic) NSMutableArray *searchedBooks;
/** 搜索结果展示控制器*/
@property(strong,nonatomic) JDMsearchResultViewController *resultVc;

@end

@implementation  JDMBaseAddressListViewController



#pragma mark -生命周期方法
- (void)viewDidLoad
{
      [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
      [self gainAddressBookList];
      [self setuptableView];
      [self setupSearchView];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    //设置状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];  
    
    //设置状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if (self.searchVc.active) {
        self.searchVc.active = NO;
        [self.searchVc.searchBar removeFromSuperview];
    }

}
#pragma mark -内部控制方法
- (void)setuptableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
//  tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
//  tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    self.tableView.allowsMultipleSelectionDuringEditing =YES;
    self.tableView.rowHeight = 44;
    
}

- (void)setupSearchView
{
    JDMsearchResultViewController *Vc = [[JDMsearchResultViewController alloc]init];
    Vc.delegate = self;
    [self addChildViewController:Vc];
    self.resultVc = Vc;
    self.searchVc = [[UISearchController alloc] initWithSearchResultsController:Vc];
    self.searchVc.searchResultsUpdater = self;
    self.searchVc.delegate = self;
    self.searchVc.searchBar.frame = CGRectMake(0, 100, JDMScreenW, 44);
    self.searchVc.searchBar.barTintColor= JDMColor(0xF0F0F0);
    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = self.searchVc.searchBar;
}


- (void)gainAddressBookList
{
    // 判断授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if (status != kABAuthorizationStatusAuthorized) return;
    
    // 获取通信录对象
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    // 获取通信录对象中所有的联系人(ABRecordRef)
    CFArrayRef peopleArray = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    CFIndex peopleCount = CFArrayGetCount(peopleArray);
    if (!peopleCount) {
        
 	 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = HUDMsg;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:3];
    [self.navigationController popViewControllerAnimated:YES];
        
    }
    for (CFIndex i = 0; i < peopleCount; i++) {
        
    //JDMAddressList *addressList = [[JDMAddressList alloc]init];
        //1.获取姓名
        ABRecordRef peroson = CFArrayGetValueAtIndex(peopleArray, i);
     NSString *lastname = (__bridge NSString *)ABRecordCopyValue(peroson, kABPersonLastNameProperty);
     NSString *firstname = (__bridge NSString *)ABRecordCopyValue(peroson, kABPersonFirstNameProperty);
       
        NSString *name = [NSString stringWithFormat:@"%@%@",lastname,firstname];
        [self.allBooks addObject:name];
        //存储姓名数组
        [self.addressArray addObject:name];
        
        // 2.获取电话号码
        ABMultiValueRef phones = ABRecordCopyValue(peroson, kABPersonPhoneProperty);
        CFIndex phoneCount = ABMultiValueGetCount(phones);
        for (CFIndex i = 0; i < phoneCount; i++) {

            NSString *phoneValue = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phones, i);
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:phoneValue forKey:name];
            //存储姓名对应电话的字典数组
            [self.addressBookArray addObject:dict];
        }
    }

    self.addressArray  = [[self.addressArray arrayWithPinYinFirstLetterFormat] mutableCopy];
//  [self.tableView reloadData];
    CFRelease(addressBook);
    CFRelease(peopleArray);
}

#pragma mark -数据源方法

#pragma mark tableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.addressArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        NSDictionary *dict = self.addressArray[section];
        NSMutableArray *array = dict[@"content"];
        return array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell ;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    NSDictionary *dict = self.addressArray[indexPath.section];
    NSMutableArray *array = dict[@"content"];
    cell.textLabel.text = array[indexPath.row];
    
     NSString *str  = nil;
    
    for (NSDictionary *dict in self.addressBookArray) {
        
         str = dict[array[indexPath.row]];
        if (str) {
            cell.detailTextLabel.text = str ;
        }
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.numberOfLines = 0;
    cell.imageView.image = [UIImage imageNamed:@"my_icon_people"];
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = self.addressArray[section];
    NSString *title = dict[@"firstLetter"];
    return title;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (NSDictionary *dict in self.addressArray) {
        NSString *title = dict[@"firstLetter"];
        [resultArray addObject:title];
    }
    [resultArray insertObject:UITableViewIndexSearch atIndex:0];
    return resultArray;
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

#pragma mark -代理方法

#pragma mark searchResultVc<JDMsearchResultViewControllerDelegate>
- (void)searchResultViewController:(JDMsearchResultViewController *)searchResultVc selectName:(NSString *)selectName
{
    NSIndexPath *indexPath = nil;
    int i = 0;
    for (NSDictionary *dict in self.addressArray) {
        int j =0;    i++;
        for (NSString *str in dict[@"content"]){
            j++;
            if ([str isEqualToString:selectName]){
                
                indexPath = [NSIndexPath indexPathForRow:j-1 inSection:i-1  ];
            }
        }
        
        [self.tableView selectRowAtIndexPath: indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark UIsearchController<UISearchResultsUpdating>

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self.searchedBooks removeAllObjects];
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.searchVc.searchBar.text];
    self.searchedBooks = [[self.allBooks filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    self.resultVc.searchBooks = self.searchedBooks;
    self.resultVc.addressBookArray = self.addressBookArray;
    [self.resultVc.tableView reloadData];
}

#pragma mark - 懒加载
- (NSMutableArray *)addressBookArray
{
    if (!_addressBookArray) {
        _addressBookArray =[NSMutableArray array];

    }
    return _addressBookArray;
}
- (NSMutableArray *)addressArray
{
    if (!_addressArray) {
        _addressArray =[NSMutableArray array];
     
    }
    return _addressArray;
}
-(NSMutableArray *)searchedBooks
{
    if (!_searchedBooks) {
        _searchedBooks =[NSMutableArray array];
    }
    return _searchedBooks;
}

-(NSMutableArray *)allBooks
{
    if (!_allBooks) {
        _allBooks =[NSMutableArray array];
    }
    return _allBooks;
}


@end

