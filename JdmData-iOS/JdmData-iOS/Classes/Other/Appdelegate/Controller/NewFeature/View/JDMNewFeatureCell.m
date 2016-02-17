//
//  YZNewFeatureCell.m
//
//
//  Created by yz on 15/6/28.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "JDMNewFeatureCell.h"

@interface JDMNewFeatureCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation JDMNewFeatureCell


- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self.contentView addSubview:imageV];
        
        _imageView = imageV;
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}





@end
