//
//  JDMHelpWordViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/17.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMHelpWordViewController.h"

@interface JDMHelpWordViewController ()

@end

@implementation JDMHelpWordViewController
static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.helpArray addObjectsFromArray:@[@"童鞋,送币啊",@"没流量,送币啊",@"童鞋,送币啊",@"童鞋,送币啊",@"童鞋,送币啊",@"童鞋,送币啊"]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.helpArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text = self.helpArray[indexPath.row];
   
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
     !self.didSelectCell ? : self.didSelectCell(cell.textLabel.text);
}

-(NSMutableArray *)helpArray
{
    if (!_helpArray) {
        _helpArray = [NSMutableArray array];
    }
    return _helpArray;
}

@end
