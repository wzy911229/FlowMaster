//
//  JDMFeedbackViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/14.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMFeedbackViewController.h"
#import "JDMPlaceholderTextView.h"
#import "JDMAFNNetworkTools.h"
#import "JDMUserInfoTools.h"
#import "JDMPopoverAnimtor.h"
#import "JDMFeedBackWordTableViewController.h"
#import "UIViewController+JDMHUD.h"

@interface JDMFeedbackViewController ()
/**意见标题选项 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**意见标题选项容器View */
@property (weak, nonatomic) IBOutlet UIView *titleContentView;

@property (weak, nonatomic) IBOutlet JDMPlaceholderTextView *placeholderTextView;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
/**转场动画代理对象 */
@property (strong, nonatomic)  JDMPopoverAnimtor *Animtor;
@end

@implementation JDMFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.placeholderTextView.placeholder = @"请留下您的宝贵意见,我们一直努力做的更好,谢谢!";
}

//点击切换title
- (IBAction)clickChangeTitleButton {
    
    JDMFeedBackWordTableViewController *helpWordVc = [[JDMFeedBackWordTableViewController alloc]init];
    
    [helpWordVc setDidSelectCell:^(NSString *word) {
        [self dismissViewControllerAnimated:YES completion:nil];
        self.titleLabel.text = word;
    }];
    
    //定义负责转场的类
    helpWordVc.transitioningDelegate = self.Animtor;
    //定义转场模式
    helpWordVc.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:helpWordVc animated:YES completion:nil];
    

}
//点击提交按钮
- (IBAction)clickCommitButton {
   
    [self sendIdea];
    
}

//提交意见
-(void)sendIdea
{
    NSString *str =self.placeholderTextView.text;
 
    if ([str isEqualToString:@""]) {
       
         　  [self showLoadingHUD: @"请输入意见" andOffsetY:0];
        return;
    }
    
    // 取消之前的所有请求
    [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"useruuid"] = [JDMUserInfoTools getUserUuid];
    params[@"text"] = self.placeholderTextView.text;
  
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMFeedBackURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        JDMLog(@"%@",responseObject);
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {
           
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        [self showTextMsgHUD: responseObject[@"msg"] andOffsetY: 0];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        
        [self showTextMsgHUD:JDMRequestErrorAwake andOffsetY:0];
        
    }];
    
}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.placeholderTextView resignFirstResponder];
    [self.mailTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (JDMPopoverAnimtor *)Animtor
{
    if (!_Animtor) {
        
        JDMPopoverAnimtor *animtor  = [[JDMPopoverAnimtor alloc]init];
        CGRect rect = CGRectMake(self.titleLabel.x, CGRectGetMaxY(self.titleContentView.frame), JDMScreenW - 20 , JDMScreenH * 0.26);
        animtor.presentedFrame = rect;
        _Animtor = animtor;
    }
    return _Animtor;
}

@end
