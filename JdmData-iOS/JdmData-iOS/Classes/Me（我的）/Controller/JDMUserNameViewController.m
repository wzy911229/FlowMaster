//
//  JDMUserNameViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/12/10.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMUserNameViewController.h"
#import "JDMAFNNetworkTools.h"
#import "JDMUserInfoTools.h"

@interface JDMUserNameViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNamefield;

@property(copy,nonatomic)NSString * oldUserName;

@end

@implementation JDMUserNameViewController
- (IBAction)changeUserName {
    
    [self.oldUserName isEqualToString:self.userNamefield.text] ? : [self haveChangeUserName];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userNamefield.text = [JDMUserInfoTools getUserName];
    self.oldUserName = self.userNamefield.text;
    
}

-(void)haveChangeUserName
{
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
     NSString *count = [NSString stringWithFormat:@"%ld",(long)[JDMUserInfoTools getUserloginid]];
    params[@"loginid"] =  count;
    params[@"name"] =  self.userNamefield.text;
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMChangeUserNameURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        JDMLog(@"%@",responseObject);
        
     [JDMUserInfoTools updateUserName:self.userNamefield.text];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
    
}


@end
