//
//  JDMCommend.h
//  JdmData-iOS
//
//  Created by test1 on 15/11/23.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDMCommend : NSObject <NSCoding>
/** 图片url */
@property (nonatomic, copy) NSString *imageurl;
/** 参加人数 */
@property (nonatomic, assign) NSInteger readcount;
/** 开始时间 */
@property (nonatomic, copy) NSString *createtime;
/** 结束时间 */
@property (nonatomic, copy) NSString *enddate;
/** 活动链接 */
@property (nonatomic, copy) NSString *linkurl;
/** 标题 */
@property (nonatomic, copy) NSString *atname;
/** 详情 */
@property (nonatomic, copy) NSString *atitle;
/** id */
@property (nonatomic, assign) NSInteger  ID;
//aicon = "<null>";
//aorder = 1;
//asummary = "\U65b0\U95fb\U63cf\U8ff01";
//atitle = "\U8fd9\U662f\U4e2a\U5927\U65b0\U95fb1";
//atname = "\U6d41\U91cf\U6d3b\U52a8";
//atype = 847c10261eb54c04a936d8189c8faaca;
//begindate = "2015-11-30 00:00:00";
//createtime = "2015-11-30 00:00:00";
//enddate = "2015-11-30 00:00:00";
//id = 1;
//imageurl = "<null>";
//linkurl = "http://www.baidu.com";
//liveflag = 1;
//readcount = 0;
//remark = "<null>";
//uuid = 5f127e1ebcff42f28c308adb00df0488;
/*                         辅助                          */
/** 是否全路径 */
@property (nonatomic, assign) bool isLoadFullPath;

@end
