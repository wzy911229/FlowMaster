// 引用全局常量

#import <UIKit/UIKit.h>
/* -----------------Home统一的间距常量------------------- */
/** Banner宽度 */
UIKIT_EXTERN CGFloat const JDMHomeBannerH ;
/** 看视频模块cell间距*/
UIKIT_EXTERN CGFloat const JDMHomeMovieCellMargin ;
/** 各子视图间距 */
UIKIT_EXTERN CGFloat const JDMHomeViewMargin;
/** scrollView滑动高度 */
UIKIT_EXTERN CGFloat const JDMHomeContentSizeH;
/** Homefunc模块按钮大小 */
UIKIT_EXTERN CGFloat const JDMHomeFuncBtnH;


/* -----------------赚流量统一的间距常量------------------- */

/** 赚流量func模块按钮大小 */
UIKIT_EXTERN CGFloat const JDMEarnedFuncBtnH;
/** 赚流量图片cell高度 */
UIKIT_EXTERN CGFloat const JDMEarnedCellH;

/* -----------------登陆注册URL------------------------ */

/** 请求路径 */
UIKIT_EXTERN NSString * const JDMBaseURL ;

/** 请求注册路径 */
UIKIT_EXTERN NSString * const JDMReisterURL;

/** 请求登陆路径 */
UIKIT_EXTERN NSString * const JDMLoginURL;

/** 请求验证码的路径 */
UIKIT_EXTERN NSString * const JDMAuthCodeURL;

/** BannerURL */
UIKIT_EXTERN  NSString * const JDMBannerURL;

/** 活动请求url */
UIKIT_EXTERN  NSString * const JDMActivityURL;

/** 签到url */
UIKIT_EXTERN  NSString * const JDMSignURL;

/** 按月获取历史签到记录 */
UIKIT_EXTERN NSString * const JDMSignHistoryURL;

/** 重设密码 */
UIKIT_EXTERN NSString * const JDMResetPwdURL;
/** 修改密码 */
UIKIT_EXTERN NSString * const JDMChangePwdURL;



/** 反馈 */
UIKIT_EXTERN NSString * const JDMFeedBackURL;
/** 更新 */
UIKIT_EXTERN NSString * const JDMUpdateURL;
/** 视频接口 */

UIKIT_EXTERN NSString * const JDMMovieURL;

/** 消息列表 */
UIKIT_EXTERN NSString * const JDMMMsgListURL;

/** 标记已读 */
UIKIT_EXTERN NSString * const JDMMsgSetReadURL;

/** 上传头像 */
UIKIT_EXTERN NSString * const JDMChangeUserImageURL;

/** 修改昵称 */
UIKIT_EXTERN  NSString * const JDMChangeUserNameURL;

/** 修改性别 */
UIKIT_EXTERN NSString * const JDMChangeUserGanderURL;

/** 全部已读 */
UIKIT_EXTERN NSString * const JDMReadAllMsgURL;

/** 查询全部未读 */
UIKIT_EXTERN NSString * const JDMNoReadMsgURL;
/** 全部新闻 */
UIKIT_EXTERN NSString * const JDMNewsURL;

/** 首页新闻列表 */
UIKIT_EXTERN NSString * const JDMHomeNewsURL;
/** 新闻点赞*/
UIKIT_EXTERN NSString * const JDMPraiseCountURL;
/** 新闻点击数*/
UIKIT_EXTERN NSString * const JDMHitCountURL;

/* -----------------状态存储记录------------------------ */

/** 保存是否提醒签到开关状态 */
UIKIT_EXTERN NSString * const  JDMSaveSignInSwitch;
/** 是否需要使用AFN缓存 */
UIKIT_EXTERN BOOL isNeedAFNCaches ;
/** 标记用户是否登陆 */
UIKIT_EXTERN BOOL  isUserLogin;
/** 标记是否需要根据网络调整是否下载图片 */
UIKIT_EXTERN BOOL isNeedLoadImage;
/** 标记用户总的未读消息数目 */
UIKIT_EXTERN NSInteger userNoReadMsgList;

/** 请求错误提醒 */
UIKIT_EXTERN NSString * JDMRequestErrorAwake;

/** 请求失败 */
UIKIT_EXTERN NSString * JDMRequestProblemAwake;
/** 加载中 */
UIKIT_EXTERN NSString * JDMLoadingAwake;
/* -----------------其他------------------------ */

/** 签到提醒时间 */
UIKIT_EXTERN NSString * const JDMSignInDate;







