//
//  SideMenuViewController.m
//  iosapp
//
//  Created by chenhaoxiang on 1/31/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

#import "leftMenuViewController.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "JDMMyMsgViewController.h"
#import "JDMsettingViewController.h"
#import "JDMActivityCommendViewController.h"
#import "JDMWitchMovieViewController.h"
#import "JDMMoreNewViewController.h"
#import <RESideMenu.h>
#import "JDMLoginViewController.h"
#import "JDMMainTabBarController.h"
#import "JDMInformationViewController.h"
#import "JDMUserInfoTools.h"

@interface leftMenuViewController ()

@property(nonatomic,weak)UIImageView *imageView;
@property(nonatomic,weak)UILabel *label;

@end
@implementation leftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPortrait) name:@"isUserHaveLogined" object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - 内部控制方法
- (void)setContentViewController:(UIViewController *)viewController isNeedLogin:(BOOL)isNeedLogin isTabBarVc:(BOOL)isTabBarVc
{
    
    UINavigationController *nav = (UINavigationController *)((UITabBarController *)self.sideMenuViewController.contentViewController).selectedViewController;
    
    if (!isUserLogin && isNeedLogin== YES) {
        JDMLoginViewController *loginVc = [[JDMLoginViewController alloc]init];
        [nav pushViewController: loginVc animated:YES];
    }
    else if(isNeedLogin == NO && isTabBarVc == YES){
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
        
        // 添加按钮
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            isUserLogin  = 0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"popToHome" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isUserHaveLogined" object:nil];
            
        }];
        [alertController addAction:sure];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
             JDMLog(@"点击了【取消】按钮");
            
        }]];
        
        // 在当前控制器上面弹出另一个控制器：alertController
        [self presentViewController:alertController animated:YES completion:nil];
     
        
    }else{
        [nav pushViewController:viewController animated:YES];
    }

    [self.sideMenuViewController hideMenuViewController];
}


#pragma mark - 数据源方法

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 160;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor clearColor];
   
    UIImage *image = [UIImage imageNamed:@"my_icon_people"];
    
    UIImageView *avatar = [[UIImageView alloc]initWithImage:image];
    avatar.contentMode = UIViewContentModeScaleAspectFit;
    avatar.userInteractionEnabled = YES;
    avatar.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:avatar];
    self.imageView = avatar;

    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"请登录" ;
    
    nameLabel.font = [UIFont boldSystemFontOfSize:20];
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:nameLabel];
    self.label = nameLabel;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(avatar, nameLabel);
    NSDictionary *metrics = @{@"x": @([UIScreen mainScreen].bounds.size.width / 4 - 15)};
    
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[avatar(60)]-10-[nameLabel]-15-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-x-[avatar(60)]" options:0 metrics:metrics views:views]];
    
    avatar.userInteractionEnabled = YES;
    nameLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickMyInfo)];
    [headerView addGestureRecognizer:tap];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.imageView.image = [UIImage imageNamed:@[@"tab_home_normal", @"tab_make_normal", @"tab_play_normal", @"tab_map_normal", @"tab_my_normal",@"register_icon_password"][indexPath.row]];
    
    cell.textLabel.text = @[@"我的消息", @"最新活动", @"最热新闻", @"好玩视频", @"我的设置", @"要注销吗"][indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:19];
    
    return cell;
    
}

#pragma mark - 外部控制方法
/**
 *  监听点击手势
 */
- (void)clickMyInfo
{
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"JDMInformationViewController" bundle:nil];
    JDMInformationViewController * InforVc  =[SB instantiateInitialViewController];
    [self setContentViewController:InforVc isNeedLogin:YES isTabBarVc:NO];
  
}
-(void)reloadPortrait
{
    self.imageView.image = isUserLogin ?[UIImage imageWithData: [JDMUserInfoTools getUserBigIcon]]: [UIImage imageNamed:@"my_icon_people"];
    self.label.text =  isUserLogin ?[JDMUserInfoTools getUserName] : @"请登录";
    
}
#pragma mark -代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
             [self setContentViewController:[[JDMMyMsgViewController alloc]init] isNeedLogin:YES isTabBarVc:NO];
     
            break;
        case 1:

             [self setContentViewController:[[JDMActivityCommendViewController alloc]init] isNeedLogin:NO isTabBarVc:NO];
            break;
        case 2:
           
            [self setContentViewController:[[JDMMoreNewViewController alloc]init] isNeedLogin:NO isTabBarVc:NO];

            break;
        case 3:
            
              [self setContentViewController:[[JDMWitchMovieViewController alloc]init] isNeedLogin:NO isTabBarVc:NO];
            
            break;
        case 4:{
            JDMsettingViewController *setVc = [[JDMsettingViewController alloc]init];
            setVc.title = @"设置";
        [self setContentViewController:setVc isNeedLogin:NO isTabBarVc:NO];
        }
            break;
        case 5:

            [self setContentViewController:[[JDMMainTabBarController alloc]init] isNeedLogin:NO isTabBarVc:YES];
            
            break;
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

#pragma mark - 点击登录


@end
