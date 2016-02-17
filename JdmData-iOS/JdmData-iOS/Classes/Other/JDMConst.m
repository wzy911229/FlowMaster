// 定义全局常量（赋值）

#import <UIKit/UIKit.h>

/* -----------------Home统一的间距常量------------------- */
/** 各子视图间距 */
CGFloat const JDMHomeViewMargin = 20;
/** scrollView滑动高度 */
CGFloat const JDMHomeContentSizeH = 850;
/** Banner宽度 */
CGFloat const JDMHomeBannerH = 150;
/** 看视频模块cell间距*/
CGFloat const JDMHomeMovieCellMargin = 10;
/** func模块按钮大小 */
CGFloat const JDMHomeFuncBtnH = 0.55;

/* -----------------赚流量统一的间距常量------------------- */

/** 赚流量func模块按钮大小 */
 CGFloat const JDMEarnedFuncBtnH = 0.28;
/** 赚流量图片cell高度 */
 CGFloat const JDMEarnedCellH = 150;


/* -----------------URL------------------------ */

/** 请求路径 */
NSString * const JDMBaseURL = @"http://192.168.0.205:8080/jdmdataServer/api/";
/** 请求注册路径 */
NSString * const JDMReisterURL = @"user/register";
/** 请求登陆路径 */
NSString * const JDMLoginURL = @"user/login";
/** 请求验证码的路径 */
NSString * const JDMAuthCodeURL =@"user/vcode";
/** BannerURL */
NSString * const JDMBannerURL = @"main/banner/list";
/** 活动请求url */
NSString * const JDMActivityURL = @"activity/list";
/** 签到url */
NSString * const JDMSignURL = @"user/attendance";
/** 按月获取历史签到记录 */
NSString * const JDMSignHistoryURL = @"user/attendance/month";
/** 重设密码 */
NSString * const JDMResetPwdURL = @"user/resetpwd";
/** 修改密码 */
NSString * const JDMChangePwdURL = @"user/changepwd";

/** 反馈 */
NSString * const JDMFeedBackURL = @"system/feenback";
/** 更新 */
NSString * const JDMUpdateURL = @"system/update";
/** 视频接口 */
NSString * const JDMMovieURL = @"video/list";
/** 消息列表 */
NSString * const JDMMMsgListURL = @"sysmsg/list";
/** 标记已读 */
 NSString * const JDMMsgSetReadURL = @"sysmsg/setRead";
/** 上传头像 */
NSString * const JDMChangeUserImageURL = @"user/upimg";
/** 修改昵称 */
NSString * const JDMChangeUserNameURL = @"user/changename";
/** 修改性别 */
NSString * const JDMChangeUserGanderURL = @"user/changegender";
/** 全部已读 */
NSString * const JDMReadAllMsgURL =@"sysmsg/setAllRead";
/** 查询全部未读 */
NSString * const JDMNoReadMsgURL =@"sysmsg/unreadCount";
/** 全部新闻列表 */
NSString * const JDMNewsURL = @"news/list";
/** 首页新闻列表 */
NSString * const JDMHomeNewsURL = @"news/newsDetail";
/** 新闻点赞*/
NSString * const JDMPraiseCountURL =@"news/addPraiseCount";
/** 新闻点击数*/
NSString * const JDMHitCountURL =@"news/addHitCount";

/* -----------------状态存储记录------------------------ */

NSString * const  JDMSaveSignInSwitch = @"isSignInSwitchOn";
/** 标记用户是否登陆 */
BOOL isUserLogin  =  NO;
/** 标记是否需要根据网络调整是否下载图片 */
BOOL isNeedLoadImage  =  NO;
/** 是否需要使用AFN缓存 */
BOOL isNeedAFNCaches  =  NO;
/** 标记用户总的未读消息数目 */
NSInteger userNoReadMsgList = 0;
/** 请求失败提醒 */
NSString * JDMRequestErrorAwake = @"请检查你的网络";
/** 请求错误 */
NSString * JDMRequestProblemAwake = @"连接失败";
/** 加载中 */
NSString * JDMLoadingAwake = @"加载中";

/* -----------------其他------------------------ */

/** 设备字符串 */
NSString * const JDMSaveService = @"com.wzy.JdmData-iOS";
/** 签到提醒时间 */
NSString * const JDMSignInDate = @"2015-12-15 09:00:00";




