//
//  JDMHotMapViewController.m
//  JdmData-iOS
//
//  Created by test1 on 15/11/12.
//  Copyright © 2015年 jdmdata. All rights reserved.
//

#import "JDMHotMapViewController.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

//#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
//
//#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
//
//#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
//
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
//
//#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
//
//#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface JDMHotMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property(nonatomic,strong)BMKMapView* mapView;
@property(nonatomic,strong) BMKLocationService * locService;
@property(nonatomic,strong) BMKHeatMap* heatMap;
@end

@implementation JDMHotMapViewController


-(void)loadView
{
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.mapView =mapView;
    self.view = mapView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
    [self addHeatMap];




//
    
   
 
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(BMKLocationService *)locService
{
    if (_locService) {
        BMKLocationService * locService = [[BMKLocationService alloc]init];
        self.locService =locService;
    }
    return _locService;
}
- (void)setupMapView
{
   
       // 2.设置地图的类型
    [self.mapView setMapType:BMKMapTypeStandard];

    // 3.打开实时的交通状况
    [self.mapView setTrafficEnabled:NO];
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=JDMRGBColor(0, 0, 0, 0.5);
    [btn sizeToFit];
    btn.frame = CGRectMake(0, 90, 100, 30);
  
    [btn setTitle:@"我的位置" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];


}


-(void)click
{
    NSLog(@"进入普通定位态");
    
    [self.locService startUserLocationService];
  
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    
    _mapView.showsUserLocation = YES;//显示定位图层
    

}

//添加热力图
-(void)addHeatMap{
    //创建热力图数据类
 self.heatMap = [[BMKHeatMap alloc]init];
    //创建渐变色类
    UIColor* color1 = [UIColor blueColor];
    UIColor* color2 = [UIColor yellowColor];
    UIColor* color3 = [UIColor redColor];
    NSArray*colorInitialArray = [[NSArray alloc]initWithObjects:color1,color2,color3, nil];
    BMKGradient* gradient = [[BMKGradient alloc]initWithColors:colorInitialArray startPoints:@[@"0.08f", @"0.4f", @"1f"]];
   
    //如果用户自定义了渐变色则按自定义的渐变色进行绘制否则按默认渐变色进行绘制
    self.heatMap.mGradient = gradient;
    
    //创建热力图数据数组
    NSMutableArray* data = [NSMutableArray array];
    int num = 1000;
    for(int i = 0; i<num; i++)
    {
        //创建BMKHeatMapNode
        BMKHeatMapNode* heapmapnode_test = [[BMKHeatMapNode alloc]init];
        //此处示例为随机生成的坐标点序列，开发者使用自有数据即可
        CLLocationCoordinate2D coor;
        float random = (arc4random()%1000)*0.001;
        float random2 = (arc4random()%1000)*0.003;
        float random3 = (arc4random()%1000)*0.015;
        float random4 = (arc4random()%1000)*0.016;
        if(i%2==0){
            coor.latitude = 39.915+random;
            coor.longitude = 116.403+random2;
        }else{
            coor.latitude = 39.915-random3;
            coor.longitude = 116.403-random4;
        }
        heapmapnode_test.pt = coor;
        //随机生成点强度
        heapmapnode_test.intensity = arc4random()*900;
        //添加BMKHeatMapNode到数组
        [data addObject:heapmapnode_test];
      
    }
    //将点数据赋值到热力图数据类
    self.heatMap.mData = data;
    //调用mapView中的方法根据热力图数据添加热力图
    [_mapView addHeatMap:self.heatMap];
    
}

////删除热力图
//-(void)removeHeatMap{
//    [_mapView removeHeatMap];
//}
//
//-(void)dealloc
//{
//    [self removeHeatMap];
//}




-(void)viewWillAppear:(BOOL)animated
{
   
    [_mapView viewWillAppear];
    _mapView.delegate = self;
     _locService.delegate = self;// 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{

    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;// 不用时，置nil
    
 JDMLog(@"%@",_locService.delegate);
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    if (_locService) {
        _locService = nil;
    }
    if(_heatMap)
        _heatMap =nil;
        
}

#pragma mark --地图代理
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
//       _mapView.showsUserLocation = NO;//显示定位图层
//     [self addHeatMap];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
      _mapView.centerCoordinate = userLocation.location.coordinate;
    [_mapView updateLocationData:userLocation];
//   _mapView.showsUserLocation = NO;//显示定位图层
//     [self addHeatMap];
//    _mapView.userTrackingMode = BMKUserTrackingModeNone;
//    
//    [_mapView setBuildingsEnabled:YES];//使用3D楼宇
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    JDMLog(@"location error");
}




@end
