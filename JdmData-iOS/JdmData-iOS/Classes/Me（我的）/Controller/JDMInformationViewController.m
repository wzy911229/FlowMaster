//
//  JDMInformationViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/19.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMInformationViewController.h"
#import "JDMAFNNetworkTools.h"
#import "JDMChangePwdViewController.h"
#import "JDMUserNameViewController.h"
#import "JDMChangeGanderViewController.h"
#import "UIImage+purityImage.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "JDMUserInfoTools.h"
#import "UIViewController+JDMHUD.h"

@interface JDMInformationViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
/**  等级 */
@property (weak, nonatomic) IBOutlet UILabel *grade;
/**  头像 */
@property (weak, nonatomic) IBOutlet UIImageView *imageurl;
/**  姓名 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/**  性别 */
@property (weak, nonatomic) IBOutlet UILabel *gander;
/**  手机 */
@property (weak, nonatomic) IBOutlet UILabel *phone;
/**  归属地 */
@property (weak, nonatomic) IBOutlet UILabel *place;
/**  新的用户数据 */
@property (strong, nonatomic) NSMutableArray *userArray;

/**  字体设配 */
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userImageLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ganderLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *changePwdLabel;

@end

@implementation JDMInformationViewController
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的信息";
    [self setupTableView];
    [self proper];

}
/**
 *  界面字体设配
 */
-(void)proper
{
    self.grade.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.name.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.gander.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.phone.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.place.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.gradeLabel.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.userImageLabel.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.nameLabel.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.ganderLabel.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.phoneLabel.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.placeLabel.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    self.changePwdLabel.font =[UIFont systemFontOfSize:[JDMTools titleScriptProper]];
    
}

- (void)setupTableView
{
    self.tableView.contentInset = UIEdgeInsetsMake(- 15, 0, 0, 0);
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadUserInfo];
}
#pragma mark - 内部控制方法
// 获取用户信息
- (void)reloadUserInfo
{
    self.gander.text = [JDMUserInfoTools getUserGender] == 2 ? @"女" :@"男";
    
   //设置手机号
    self.phone.text = [NSString stringWithFormat:@"%ld",(long)[JDMUserInfoTools getUserPhoneNumber]];
    
    //设置头像
    NSData *data = [JDMUserInfoTools getUserBigIcon];
    if (data) {
         self.imageurl.image = [UIImage imageWithData:data];
    }
    //设置昵称
    self.name.text = [JDMUserInfoTools getUserName];
    
}
//弹出获取用户头像的alert
-(void)getUserImage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 添加按钮
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"打开照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
    }];
    [alertController addAction:sure];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self getPhoto];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        JDMLogFunc;
    }]];
    // 在当前控制器上面弹出另一个控制器：alertController
    [self presentViewController:alertController animated:YES completion:nil];
}
//通过相机获取
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    if([UIImagePickerController isSourceTypeAvailable:sourceType] &&[mediatypes count] > 0){
        
        NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.mediaTypes=mediatypes;
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        NSString *requiredmediatype=(NSString *)kUTTypeImage;
        NSArray *arrmediatypes=[NSArray arrayWithObject:requiredmediatype];
        [picker setMediaTypes:arrmediatypes];
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
}
//通过相册获取
-(void)getPhoto
{
    // 1.创建一个图片选择控制器
    UIImagePickerController *imagePickerVc = [[UIImagePickerController alloc] init];
    // 设置照片源,照片库
    imagePickerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // 设置代理，监听用户选择
    imagePickerVc.delegate = self;
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}
//修改昵称
-(void)changeUserName
{
    JDMUserNameViewController *userNameVc = [[JDMUserNameViewController alloc]init];
    [self.navigationController pushViewController:userNameVc animated:YES];
}
//修改性别
-(void)changeGander
{
    JDMChangeGanderViewController *ganderVc = [[JDMChangeGanderViewController alloc]init];
    [self.navigationController pushViewController:ganderVc animated:YES];
    
}
#pragma mark -数据源方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return JDMScreenW / 5.5;
    }
    return [JDMTools cellProper];
}
#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2 ) {
        JDMChangePwdViewController *changeVc = [[JDMChangePwdViewController alloc]init];
        [self.navigationController pushViewController:changeVc animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        [self getUserImage];
    }
    else if (indexPath.section == 0 && indexPath.row == 2) {
        [self changeUserName];
        
    }else if (indexPath.section == 0 && indexPath.row == 3) {
        [self changeGander];
    }
    
    
    
}

#pragma mark UIImagePickerControllerDelegate
// 当用户选择一个照片的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 获取用户选择的照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    self.imageurl.image = [image getCircleImageSize:CGSizeMake(40, 40)];
    
    NSData *imageData = UIImagePNGRepresentation([image getCircleImageSize:CGSizeMake(40, 40)]);
    
    [JDMUserInfoTools updateBigicon:imageData];
    
    [self LoadUserImage:imageData];

    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    NSLog(@"%@",info);
}
#pragma mark - 外部控制方法
- (IBAction)ExitLogin
{
    isUserLogin  = 0;
    [SVProgressHUD showSuccessWithStatus:@"成功推出"];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isUserHaveLogined" object:nil];
}

- (void)LoadUserImage:(NSData *)imageData
{
    
    
   
        // Set determinate mode
    
    //     HUD.labelText = @"Loading";
//    [self showLoadingHUD:nil andOffsetY:0];
    
    // 取消之前的所有请求
    [[JDMAFNNetworkTools shareNetworkTools].tasks makeObjectsPerformSelector:@selector(cancel)];
    NSString *count = [NSString stringWithFormat:@"%ld",(long)[JDMUserInfoTools getUserloginid]];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginid"] =  count;
    
    [[JDMAFNNetworkTools shareNetworkTools] POST:JDMChangeUserImageURL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /*
         Data: 需要上传的数据
         name: 服务器参数的名称
         fileName: 文件名称
         mimeType: 文件的类型
         */
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"userImage.png" mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber* isSuccess = responseObject[@"status"];
        if (isSuccess.integerValue) {
        NSString *str = responseObject[@"dataObj"][@"bigicon"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",JDMBaseURL,str]];
         [JDMUserInfoTools updateBigicon:[NSData dataWithContentsOfURL:url]];
        }
        
//         [self hideHUD];
    　 [self showTextMsgHUD: responseObject[@"msg"] andOffsetY: 0];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
 
}


@end
