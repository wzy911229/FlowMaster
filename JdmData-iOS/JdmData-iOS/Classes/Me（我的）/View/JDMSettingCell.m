//
//  JDMSettingCell.m
//  JDM 
//
//  Created by apple on 15/7/22.
//  Copyright (c) 2015年 JDM. All rights reserved.
//

#import "JDMSettingCell.h"
#import "JDMSettingItem.h"
#import "JDMSettingArrowItem.h"
#import "JDMSettingSwitchItem.h"
#import "NSString+ZYExtension.h"

@interface JDMSettingCell ()
/** 圈圈 */
@property (nonatomic, weak) UIActivityIndicatorView *loadingView;
@end
@implementation JDMSettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)cellStyle
{
    
    static NSString *ID = @"cell";
    
    JDMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[JDMSettingCell alloc] initWithStyle:cellStyle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setItem:(JDMSettingItem *)item
{
    _item = item;
   
    // 设置子控件数据
    [self setUpData];
    
    // 设置辅助视图
    [self setUpAccessoryView];
    if (item.customAccessoryView.height > self.height) {
        item.customAccessoryView.height = self.height;
      }
  
    
    if(self.item.isClearCacheCell){
        // 添加圈圈
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        [self.contentView addSubview:loadingView];
        self.loadingView = loadingView;
        
        // 设置文字
        self.textLabel.text = @"清除缓存";
        
        // 设置箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // 获得缓存大小
        [self getCacheSize];
    }

    
    
   
}

#pragma mark - 设置辅助视图
- (void)setUpData
{
    self.imageView.image = _item.image;
    self.textLabel.text = _item.title;
    self.textLabel.font = [UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.detailTextLabel.text = _item.subTitle;
    self.detailTextLabel.font = [UIFont systemFontOfSize:[JDMTools contentScriptProper]];

    self.detailTextLabel.textColor = [UIColor darkGrayColor];
    self.detailTextLabel.numberOfLines = 0;
    
}

#pragma mark - 设置辅助视图
- (void)setUpAccessoryView
{
    // 设置辅助视图
    if(self.item.customAccessoryView)
    {
        self.accessoryView  =  self.item.customAccessoryView;
        
    }else if ([_item isKindOfClass:[JDMSettingArrowItem class]]) {
        // 展示箭头
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_rightarrow"]];
        self.accessoryView = arrowView;
        
    }else if ( [_item isKindOfClass:[JDMSettingSwitchItem class]]){
        // 展示开关
        UISwitch *switchView = [[UISwitch alloc] init];
        JDMSettingSwitchItem * switchItem =  (JDMSettingSwitchItem *)self.item;
        switchView.on = switchItem.isOpen;
        [switchView addTarget:self action:@selector(changeSwitchValue:) forControlEvents:UIControlEventValueChanged];
        
        
        self.accessoryView = switchView;
    }
    else{
        
        self.accessoryView = nil;
    }

}
-(void)changeSwitchValue:(UISwitch *)switchView
{
     JDMSettingSwitchItem * switchItem =  (JDMSettingSwitchItem *)self.item;
 !switchItem.doSomethingWhenSwitchOpen ? : switchItem.doSomethingWhenSwitchOpen(switchView);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.loadingView.x = CGRectGetMaxX(self.textLabel.frame) + 10;
    self.loadingView.centerY = self.contentView.height * 0.5;
}


- (void)getCacheSize
{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        // SDWebImage缓存路径
       //  NSString *fileSize = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"].fileSizeString;
      //   NSString *text = [NSString stringWithFormat:@"清除缓存(%@)", fileSize];
        NSString *text = [NSString stringWithFormat:@"清除缓存(%@)", caches.fileSizeString];
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            // 设置文字
            self.textLabel.text = text;
            // 删除圈圈
            [self.loadingView removeFromSuperview];
        });
    });
}

- (void)reset
{
    self.textLabel.text = @"清除缓存(0B)";
}

@end
