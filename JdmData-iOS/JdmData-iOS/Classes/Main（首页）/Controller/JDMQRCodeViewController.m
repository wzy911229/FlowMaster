//
//  JDMQRCodeViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/25.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIViewController+JDMHUD.h"

#define signFormatterStyle @"yyyy-MM-dd HH:mm:ss"
#define remindLabelFirst @"将二维码存放于框内"
#define remindLabelSecond @"将领取的流量币二维码存放于框内"
#define remindLabelThird  @"将领取的流量卷二维码存放于框内"
#define AVCaptureSessionPreset  @"AVCaptureSessionPreset1920x1080"

@interface JDMQRCodeViewController ()<UITabBarDelegate,AVCaptureMetadataOutputObjectsDelegate>
/** 控制自定义tabbar的约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabbarLayout;
/** 自定义tabbar*/
@property (weak, nonatomic) IBOutlet UITabBar *custabBar;
/** 提醒文字label*/
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;
/** 冲击波和容器顶部相对高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sancleHigh;
/** 容器高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHigh;
/** 波动容器视图*/
@property (weak, nonatomic) IBOutlet UIView *contantView;

/** 懒加载会话*/
@property(nonatomic,strong) AVCaptureSession * session;
/** 懒加载预览图层*/
@property(nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
/** 创建一个二维码描边图层*/
@property(nonatomic,strong) CALayer *drawlayer;
/** 懒加载输入*/
@property(nonatomic,strong) AVCaptureDeviceInput *inputDevice;
/** 懒加载输出*/
@property(nonatomic,strong) AVCaptureMetadataOutput *output;
/**记录是否获得二维码*/
@property(nonatomic,assign) BOOL isGetQRCode;

@end

@implementation JDMQRCodeViewController

/** 保存选中自定义Bar的按钮*/
static NSString * selectBarItem = @"selectedItem";

#pragma mark -生命周期方法
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"扫一扫";
    
    self.custabBar.selectedItem = self.custabBar.items[0];
    
    [self.custabBar addObserver:self forKeyPath:selectBarItem options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self showTextMsgHUD:@"dasdad" andOffsetY:0];
    [self startScanQRCode];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    UIBarButtonItem *item = change[NSKeyValueChangeNewKey];
    
    switch (item.tag) {
        case 0:
            self.remindLabel.text = remindLabelFirst;
            break;
        case 1:
            self.remindLabel.text = remindLabelSecond;
            break;
        case 2:
            self.remindLabel.text = remindLabelThird;
            break;
        default:
            break;
    }
                             
}

-(void)dealloc
{
    [self.custabBar removeObserver:self forKeyPath:selectBarItem];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startAnimation];
   
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     self.tabbarLayout.constant = 0;
}

#pragma mark -内部控制方法
/**
 *  开启动画
 */
- (void)startAnimation
{
    self.sancleHigh.constant = - self.contentHigh.constant;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1.5 animations:^{
        [UIView setAnimationRepeatCount:MAXFLOAT];
        self.sancleHigh.constant = self.contentHigh.constant;
        [self.view layoutIfNeeded];
    }];
}


/**
 *  开始二维码扫描
 */
-(void)startScanQRCode
{
    
        //添加输入输出
        [self.session addInput:self.inputDevice];
    
        [self.session addOutput:self.output];
    
        [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];

    //注意:模态出来的可以不用调,nav跳转必须调节
    CGRect frame = self.contantView.frame;
    frame.origin.x = frame.origin.x - 64 - 20 - 14;
    frame.origin.y = frame.origin.y + 20;
    CGSize size = self.view.frame.size;
   

    CGRect Fram = CGRectMake(frame.origin.y / size.height , frame.origin.x /size.width ,frame.size.height/size.height +1 ,frame.size.width / size.width + 1);
    
    [_output setRectOfInterest:Fram];
    
      //创建预览图层
       AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
       layer.frame = self.view.bounds;
       [self.view.layer addSublayer:layer];
         self.previewLayer = layer;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    [self.previewLayer addSublayer:self.drawlayer];

    
    // 5.开始扫描
    [_session startRunning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isGetQRCode) {
        [self clearCorners];
        [self.session startRunning];
    }
}

#pragma mark - 代理方法
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [self clearCorners];
    
    for (AVMetadataObject * Objc in metadataObjects) {
        AVMetadataObject *  codeObjc = [self.previewLayer transformedMetadataObjectForMetadataObject:Objc];
        [self drawCorners:(AVMetadataMachineReadableCodeObject *)codeObjc];
        
    }
    
    if (metadataObjects.count > 0) {
        // 1.获取元数据
        AVMetadataMachineReadableCodeObject *metadata = [metadataObjects lastObject];
        
        // 2.获取具体的值
        NSLog(@"%@", metadata.stringValue);
        if (metadata.stringValue) {
            // 3.停止扫描
            [self.session stopRunning];
            self.isGetQRCode = YES;
        }
    }
}
#pragma mark   代理子方法

// 移除以前的描边
-(void)clearCorners
{
    if (self.drawlayer == nil || self.drawlayer.sublayers.count == 0) {
        return;
    }
    for (CALayer *sublayer in self.drawlayer.sublayers) {
        [sublayer removeFromSuperlayer];
    }
    
}

//画出当前二维码位置
- (void)drawCorners:(AVMetadataMachineReadableCodeObject*)codeObjc
{
    if (codeObjc.corners == nil ||codeObjc.corners.count == 0) {
        return;
    }
    CAShapeLayer *sublayer = [[CAShapeLayer alloc]init];
    sublayer.lineWidth = 4;
    sublayer.strokeColor = [UIColor redColor].CGColor;
    sublayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path  = [[UIBezierPath alloc]init];
    CGPoint point = CGPointZero;
    NSInteger index = 0;
    NSArray *dictArr = codeObjc.corners;

    CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)dictArr[index++], &point);
    [path moveToPoint:point];
    
    while (index < dictArr.count) {
       CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)dictArr[index++], &point);
        [path addLineToPoint:point];
    }
    [path closePath];
    sublayer.path = path.CGPath;
    [self.drawlayer addSublayer:sublayer];
}

#pragma mark - 懒加载
- (AVCaptureDeviceInput *)inputDevice
{
    if (!_inputDevice) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (error) {
            input = nil;
            JDMLog(@"%@",error);
        }
        _inputDevice = input;
        
    }
    return _inputDevice;
}
- (AVCaptureMetadataOutput *)output
{
    if (!_output) {
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        
        
        
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        _output = output;
    }
    
    
    return _output;
}

-(AVCaptureSession *)session
{
    if (!_session) {
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        _session = session;
        _session.sessionPreset = AVCaptureSessionPreset;
    }
    return _session;
}

-(CALayer *)drawlayer
{
    if (!_drawlayer) {
        CALayer *layer = [[CALayer alloc]init];
        layer.frame = JDMScreenBounds;
        _drawlayer = layer;
    }
    return _drawlayer;
}

@end
