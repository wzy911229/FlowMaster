//
//  UIImage+purityImage.h
//  ZYWu
//
//  Created by apple on 15/7/19.
//  Copyright (c) 2015年 ZYWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (purityImage)

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color width:(CGFloat)width hight:(CGFloat)hight;
/**
 *  生成二维码以UIImage格式输出
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;
/**
 *  生成一个圆形图片
 */
- (instancetype)getCircleImage;
- (instancetype)getCircleImageSize:(CGSize)size;
@end
