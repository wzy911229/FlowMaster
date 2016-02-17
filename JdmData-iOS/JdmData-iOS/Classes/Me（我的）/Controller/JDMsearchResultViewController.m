//
//  JDMsearchResultViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/2.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMsearchResultViewController.h"

@interface JDMsearchResultViewController ()
@property(strong,nonatomic)NSMutableArray *array;

@end
@implementation JDMsearchResultViewController

static NSString *ID =@"cell";

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.searchBooks.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell ;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = self.searchBooks[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"my_icon_people"];
    
    

    for (NSDictionary *dict in self.addressBookArray) {
        
//        JDMLog(@"%@",dict);
       NSString * str = dict[self.searchBooks[indexPath.row]];
        if (str) {
            cell.detailTextLabel.text = str ;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(searchResultViewController:selectName:)]) {
        [_delegate searchResultViewController:self selectName:self.searchBooks[indexPath.row]];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"联系人";
}
@end
