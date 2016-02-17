//
//  JDMinViteHeaderView.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/1.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMinViteHeaderView.h"
#import <MBProgressHUD.h>

@interface JDMinViteHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *QRcodeView;


@end
@implementation JDMinViteHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self creatQRCode];
}
- (IBAction)ClickinviteFriendsButton {

  
}

-(void)creatQRCode
{
    // 创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复默认设置
    [filter setDefaults];
    
    // 给滤镜设置数据
    NSString *string = @"http://www.baidu.com";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 获取生成好的二维码
    CIImage *outputImage = [filter outputImage];
    
    // 将二维码显示在imageView上
    self.QRcodeView.image = [UIImage createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
}

@end
