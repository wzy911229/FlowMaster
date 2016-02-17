//
//  JDMSoundHelpViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/16.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMSoundHelpViewController.h"

@interface JDMSoundHelpViewController ()
@property(nonatomic,strong)NSMutableArray *soundHelps;

@end

@implementation JDMSoundHelpViewController

static NSString *ID = @"cell";
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

-(NSMutableArray *)soundHelps
{
    if (!_soundHelps) {
        _soundHelps = [NSMutableArray array];
     [_soundHelps addObjectsFromArray: @[@"1.如何兑换上网时长",@"2.如何断开和连接WiFI上网",@"3.WiFI时长有使用的有效期码"]];
    }
    return _soundHelps;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.soundHelps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text =self.soundHelps[indexPath.row];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"play_icon_play"]];
    cell.accessoryView =image;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}
@end
