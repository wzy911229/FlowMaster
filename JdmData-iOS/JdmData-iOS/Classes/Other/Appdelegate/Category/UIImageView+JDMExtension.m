//
//  UIImageView+XMGExtension.m
//  2期-百思不得姐
//
//  Created by apple on 15/8/16.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "UIImageView+JDMExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (JDMExtension)
- (void)setImageWithCurrentNetwork:(NSURL *)url isWIFI:(BOOL)isWIFI isSwitchOn:(BOOL)isOn WIFIWithplaceholderImage:(UIImage *)placeholderImage
{
    if (isOn) {
        isWIFI ? [self sd_setImageWithURL:url placeholderImage:placeholderImage]: [self setImage:placeholderImage];
    }else
    {
        [self sd_setImageWithURL:url placeholderImage:placeholderImage];
    }

    
}
@end
