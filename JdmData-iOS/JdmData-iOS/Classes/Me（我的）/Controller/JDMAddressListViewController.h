//
//  JDMAddressListViewController.h
//  JdmData-iOS
//
//  Created by test1 on 15/12/1.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDMBaseAddressListViewController.h"




@interface JDMAddressListViewController : JDMBaseAddressListViewController

@end



@class JDMAllSelectView;
@protocol JDMAllSelectViewDelegate <NSObject>

-(void)allSelectView:(JDMAllSelectView*)selectView clickAllSelectbtn:(UIButton*)AllSelectbtn;
-(void)allSelectView:(JDMAllSelectView*)selectView clickSendMsgbtn:(UIButton*)SendMsgbtn;

@end
@interface JDMAllSelectView : UIView

@property(nonatomic,weak)id<JDMAllSelectViewDelegate> delegate;
@end