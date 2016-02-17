//
//  JDMBaseSettingController.m
//  JDM 
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import "JDMBaseSettingController.h"
#import "JDMLoginViewController.h"

#import <SVProgressHUD.h>
#import <SDImageCache.h>

#define clearCacheMsg @"缓存清理成功"

@interface JDMBaseSettingController ()

@end

@implementation JDMBaseSettingController

#pragma mark - 生命周期方法
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(- 15, 0, 0, 0);
    self.tableView.sectionHeaderHeight = [JDMTools sectionHeightProper];
    self.tableView.sectionFooterHeight = 0;
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 取出当前的组模型
    JDMGroupItem * group = self.groups[section];
    return group.items.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 取模型
    // 哪一组的模型
    JDMGroupItem *group = self.groups[indexPath.section];
    
    // 从模型数组数组中取出对应的模型
    JDMSettingItem *item = group.items[indexPath.row];
    
    item.cellStyle = item.cellStyle ? item.cellStyle :UITableViewCellStyleValue1;
    
        // 1.创建cell
        JDMSettingCell *cell =  [JDMSettingCell cellWithTableView:tableView cellStyle:item.cellStyle];
  
    // 2.给cell传递模型，给cell的子控件赋值
    cell.item = item;
    
    return cell;
}

// 返回第section组的头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 取出当前是哪一组
    JDMGroupItem *group = self.groups[section];
    
    return group.headerTitle;
}

// 返回第section组的尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    // 取出当前是哪一组
    JDMGroupItem *group = self.groups[section];
    
    return group.footerTitle;
}



#pragma mark - 监听cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 取出模型
    JDMGroupItem *group = self.groups[indexPath.section];
    
    JDMSettingItem *item = group.items[indexPath.row];
    if(item.isClearCacheCell)
    {
     [self clearCacheWithIndexPath:indexPath];
    }
    
    // 判断下有木有事情，就判断下block有没有值
    if (item.operationBlock) {
        // 执行保存的代码
        item.operationBlock(indexPath);
        return;
    }
    if ([item isKindOfClass:[JDMSettingArrowItem class]]) {
        JDMSettingArrowItem *arrowItem = (JDMSettingArrowItem *)item;
        
        if (arrowItem.descVc) {
            if (!arrowItem.isNeedLogin || isUserLogin) {
                // 创建目的控制器
                UIViewController *vc = [[arrowItem.descVc alloc] init];

                vc.navigationItem.title = item.title;
                // 跳转到功能界面
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if (arrowItem.isNeedLogin  && isUserLogin == 0 )
            {
                JDMLoginViewController *logVc = [[JDMLoginViewController alloc]init];
                 // 跳转到登陆界面
                [self.navigationController pushViewController:logVc animated:YES];

            }
            
        }
        
    }
    
  
    
   
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellProper;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return self.sectionHeightProper;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return self.sectionHeightProper;
//}

/**
 *  清理缓存
 */
- (void)clearCacheWithIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section) return;
    
    // 清除缓存
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
      [[NSURLCache sharedURLCache] removeAllCachedResponses];
    // 清除SDWebImage的所有缓存图片
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        // 关闭弹框
        [SVProgressHUD showSuccessWithStatus:clearCacheMsg];
      
        // 设置cell的文字
        JDMSettingCell *cell = (JDMSettingCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell reset];
        
    }];
}

/**
 *  适配cell高度
 */
- (CGFloat)cellProper
{
    if (JDMScreenW == 320) {
        return 35;
    }else if (JDMScreenW == 375)
    {
        return 44;
    }else if (JDMScreenW == 414)
    {
        return 55;
    }
    return 65;
    
}



@end