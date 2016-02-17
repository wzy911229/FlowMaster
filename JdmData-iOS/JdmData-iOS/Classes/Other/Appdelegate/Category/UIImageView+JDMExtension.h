//
//  UIImageView+XMGExtension.h
//  2期-百思不得姐
//
//  Created by apple on 15/8/16.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JDMExtension)
/**根据网络状态显示图片*/
- (void)setImageWithCurrentNetwork:(NSURL *)url isWIFI:(BOOL)isWIFI isSwitchOn:(BOOL)isOn WIFIWithplaceholderImage:(UIImage *)placeholderImage;

@end
