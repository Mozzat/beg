//
//  GrabOrderVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/15.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "GrabOrderVC.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "CTMediator+GrabOrderWaterMediator.h"
#import "GrabWaterView.h"
#pragma make--自定义的气泡
#import "CustomAnnotationView.h"

#import "LocationManager.h"
#pragma mark--高德地图api
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import "GrabDetialVC.h"
#import "RedPacketListVC.h"
#import "OpenRedPackageView.h"
#import <MZTNetWorking/ProgressHUDView.h>
#import "HomeFilterView.h"

@interface GrabOrderVC ()<LocationManagerDelegate,MAMapViewDelegate>

@property (nonatomic, weak)    MAMapView *mapView;
@property (nonatomic, strong)  AMapLocationManager *locationManager;
@property (nonatomic, strong)  UIView *middleView;
@property (nonatomic, weak)    UILabel  *middleLab;
@property (nonatomic, strong)  GrabWaterView *waterView;
@property (nonatomic, strong)  NSMutableArray *pointArr;
@property (nonatomic, copy)    NSString       *locationStr;
@property (nonatomic, strong)  NSMutableArray *annotationArr;
@property (nonatomic, weak)    OpenRedPackageView   *openRedView;
@property (nonatomic, strong)  HomeFilterView *filterView;

@end

@implementation GrabOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLocationUI];
    [self initLocationManager];
//    [self addPointAnnotationData];
    
}

- (BOOL)fd_prefersNavigationBarHidden{
 
    return YES;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView setZoomLevel:16.1 animated:YES];
    
//    [self getMapPointData];
    
}

#pragma mark---懒加载
- (UIView *)middleView{
    
    if (!_middleView) {
        _middleView = [[UIView alloc]init];
        _middleView.backgroundColor = HexColor(@"4a4a4a");
        [_middleView rounded:20];
    }
    return _middleView;
}

- (GrabWaterView *)waterView{
    
    if (!_waterView) {
        _waterView = [[GrabWaterView alloc]initWithFrame:CGRectMake(0, BDTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - BDTopHeight - BDTabBarHeight)];
    }
    return _waterView;
}

- (NSMutableArray *)pointArr{
    
    if (!_pointArr) {
        _pointArr = [NSMutableArray array];
    }
    return _pointArr;
}

- (NSMutableArray *)annotationArr{
    
    if (!_annotationArr) {
        _annotationArr = [NSMutableArray array];
    }
    return _annotationArr;
}

- (HomeFilterView *)filterView{
    
    if (!_filterView) {
        _filterView = [[HomeFilterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        [[UIApplication sharedApplication].keyWindow addSubview:_filterView];
        
    }
    return _filterView;
}

- (void)setLocationUI{
    
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    MAMapView *mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - BDBottomHeight)];
    mapView.userTrackingMode = MAUserTrackingModeNone;
    mapView.delegate = self;
    self.mapView = mapView;
    [self.view addSubview:mapView];
    mapView.showsScale = NO;
    mapView.showsCompass = NO;
//    mapView.userTrackingMode =
    mapView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BDTopHeight)];
    topView.backgroundColor = whiteColor();
    [self.view addSubview:topView];
    
    UIButton *search = [[UIButton alloc]init];
    search.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [search setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [topView addSubview:search];
    
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(44);
        make.left.equalTo(topView).offset(20);
        make.bottom.equalTo(topView);
        
    }];
    
    UIImageView *titleImageV = [[UIImageView alloc]init];
    titleImageV.image = [UIImage imageNamed:@"跪求标题"];
    [topView addSubview:titleImageV];
    
    [titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(search);
        make.centerX.equalTo(topView);
        
    }];
    
    UIButton *menuBtn = [[UIButton alloc]init];
    [menuBtn setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(showFilterView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:menuBtn];
    
    [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(44);
        make.right.equalTo(topView).offset(-10);
        make.bottom.equalTo(topView);
        
    }];
    
    UIButton *listBtn = [[UIButton alloc]init];
    [listBtn setImage:[UIImage imageNamed:@"列表"] forState:UIControlStateNormal];
    [listBtn setImage:[UIImage imageNamed:@"坐标模式"] forState:UIControlStateSelected];
    [listBtn addTarget:self action:@selector(openWaterFallOrderVC:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:listBtn];
    
    [listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(44);
        make.right.equalTo(menuBtn.mas_left);
        make.bottom.equalTo(topView);
        
    }];
    
    [self.view addSubview:self.middleView];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(40);
        
    }];
    
    UIImageView *leftImageV = [[UIImageView alloc]init];
    leftImageV.image = [UIImage imageNamed:@"消息"];
    [self.middleView addSubview:leftImageV];
    
    [leftImageV  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.middleView).offset(10);
        make.centerY.equalTo(self.middleView);
        make.width.height.mas_equalTo(17);
        
    }];
    
    UIButton *middleCloseBtn = [[UIButton alloc]init];
    [middleCloseBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [self.middleView addSubview:middleCloseBtn];
    
    [middleCloseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.middleView);
        make.right.equalTo(self.middleView).offset(-10);
        make.width.height.mas_equalTo(18);
        
    }];
    
    UILabel *middleLab = [[UILabel alloc]init];
    self.middleLab = middleLab;
    middleLab.text = @"发单抽IPhone X，10个Iphone X等你来领！�";
    middleLab.font = Font12();
    middleLab.textColor = whiteColor();
    [self.middleView addSubview:middleLab];
    
    [middleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.middleView);
        make.left.equalTo(leftImageV.mas_right).offset(10);
        make.right.lessThanOrEqualTo(middleCloseBtn.mas_left).offset(-10);
        
    }];
    
    UIButton *redPageBtn = [[UIButton alloc]init];
    [redPageBtn setImage:[UIImage imageNamed:@"红包图标"] forState:UIControlStateNormal];
    [redPageBtn setImage:[UIImage imageNamed:@"红包退出图标"] forState:UIControlStateSelected];
    [self.view addSubview:redPageBtn];
    
    [redPageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view).offset(-BDTabBarHeight - 40);
        make.left.equalTo(self.view).offset(20);
        make.width.height.mas_equalTo(50);
        
    }];
    
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setImage:[UIImage imageNamed:@"帮助中心"] forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(redPageBtn);
        make.right.equalTo(self.view).offset(-10);
        make.width.height.mas_equalTo(50);
        
    }];

    UIButton *pointBtn = [[UIButton alloc]init];
    [pointBtn setImage:[UIImage imageNamed:@"重新定位"] forState:UIControlStateNormal];
    [pointBtn addTarget:self action:@selector(restartUpdateLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pointBtn];
    
    [pointBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(saveBtn);
        make.bottom.equalTo(saveBtn.mas_top).offset(-10);
        make.width.height.mas_equalTo(50);
        
    }];
    
    [self.view addSubview:self.waterView];
    self.waterView.hidden = YES;
    
}

- (void)initLocationManager{
    
    [LocationManager sharedInstance].locationDelegate = self;
    [[LocationManager sharedInstance] startUpdatingLocation];
    
}

#pragma mark---添加标注
- (void)addPointAnnotationData{
    
//    NSArray *data1 = @[@"31.203387",@"31.203919",@"121.491882",@"31.203379",@"31.203380"];
//    NSArray *data2 = @[@"121.494994",@"121.492977",@"121.491882",@"121.491880",@"121.491875"];
//
//    for (NSInteger index = 0; index < 5; index ++ ) {
//
//        float point1 = [data1[index] floatValue];
//        float point2 = [data2[index] floatValue];
//
//        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//        pointAnnotation.coordinate = CLLocationCoordinate2DMake(point1, point2);
//        pointAnnotation.title = @"方恒国际";
//        pointAnnotation.subtitle = @"阜通东大街6号";
//        [self.mapView addAnnotation:pointAnnotation];
//
//    }
    
}

- (void)restartUpdateLocation{
    
    [[LocationManager sharedInstance] startUpdatingLocation];
    
}

#pragma mark---定位地图代理
- (void)finishLocationWithLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
    
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        
        NSInteger count = [annotation.title floatValue];
        
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        CustomAnnotationView*annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        
        NSDictionary *dic = self.pointArr[count];
        NSString *type = dic[@"type"];
        
        if ([type isEqualToString:@"RED_PACKET"]) {
            
            annotationView.image = [UIImage imageNamed:@"红包坐标"];
            
        } else {
            
            annotationView.image = [UIImage imageNamed:@"气球坐标"];
            
        }
        
        LRWeakSelf(self);
        annotationView.block = ^(NSDictionary * _Nonnull dic) {
          
            LRStrongSelf(self);
            [self annotationViewAction:dic];
            
        };
        
        annotationView.canShowCallout= NO;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
        annotationView.centerOffset = CGPointMake(0, -18);
        annotationView.dataDic = self.pointArr[count];
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
    NSLog(@"MAMapView:  %@", userLocation.location);
    NSString *locationStr = [NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude];
    
    if (![locationStr isEqualToString:self.locationStr]) {
        
        self.locationStr = locationStr;
        [self getMapPointData];
        
    }
    
    
}

#pragma mark----点击事件
///跳转瀑布流控制器
- (void)openWaterFallOrderVC:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    self.waterView.hidden = !btn.selected;
    
}

///展示筛选页面
- (void)showFilterView{
    
    self.filterView.hidden = NO;
    self.filterView.data = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    
}

- (void)annotationViewAction:(NSDictionary *)dic{
    
    NSString *type = dic[@"type"];
    if ([type isEqualToString:@"RED_PACKET"]) {
        
        [self getRedPacketData:dic[@"orderNo"]];
        
    } else {
        
        GrabDetialVC *detial = [[GrabDetialVC alloc]init];
        detial.orderNo = dic[@"orderNo"];
        detial.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detial animated:YES];
        
    }

    
}

#pragma mark---网络请求
- (void)getMapPointData{
    
    if ([Util isBlankString:self.locationStr]) {
        return;
        
    }
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"key"] = kWebServise_Key;
    parameter[@"tableid"] = kWebServise_TableID;
    parameter[@"filter"] = @"source:BEG";
    parameter[@"center"] = self.locationStr;
    parameter[@"radius"] = @"2000";
    parameter[@"limit"] = @"20";
    parameter[@"page"] = @"1";
    
    [HttpManagerRequest getLBSDataWithParameter:parameter WithSuccessBlock:^(id result) {
        
        NSLog(@"%@",result);
        NSDictionary *dic = (NSDictionary *)result;
        NSInteger status = [dic[@"status"] integerValue];
        
        if (status == 1) {
            
            [self.mapView removeAnnotations:self.mapView.annotations];
            
            NSArray *data = dic[@"datas"];
            self.pointArr = [data mutableCopy];
            NSInteger count = 0;
            
            for (NSDictionary *dic1 in data) {
                
                NSArray *pointArr = [dic1[@"_location"] componentsSeparatedByString:@","];
                float point1 = [[pointArr firstObject] floatValue];
                float point2 = [[pointArr lastObject] floatValue];
                
                MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
                pointAnnotation.coordinate = CLLocationCoordinate2DMake(point2, point1);
                pointAnnotation.title = dic1[@"_province"];
                pointAnnotation.subtitle = dic1[@"_address"];
                pointAnnotation.title = @(count).stringValue;
                [self.mapView addAnnotation:pointAnnotation];
                
                count ++;
            }
            
        }
        
        
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

///获取红包详情
- (void)getRedPacketData:(NSString *)orderNo{
    
    [ProgressHUDView showProgressMessage:@"加载"];
    [HttpManagerRequest getRedPacketDataWithOrderNo:orderNo WithSuccessBlock:^(id result) {
       
        [ProgressHUDView dismiss];
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {

            ///红包是否领取过
            BOOL nStateRecord = [dic[@"data"][@"nStateRecord"] boolValue];
            
            if (nStateRecord) {
                
                [self.openRedView hide];
                RedPacketListVC *red = [[RedPacketListVC alloc]init];
                red.orderNo = orderNo;
                red.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:red animated:YES];
                
                
            } else {
                
                float lat = [dic[@"data"][@"nLatitude"] floatValue];
                float lgt = [dic[@"data"][@"nLongitude"] floatValue];
                CLLocationCoordinate2D redPacketLoc = CLLocationCoordinate2DMake(lat, lgt);
                MAMapPoint p1 = MAMapPointForCoordinate([LocationManager sharedInstance].currentCoordinaate2D);
                MAMapPoint p2 = MAMapPointForCoordinate(redPacketLoc);
                CLLocationDistance distance = MAMetersBetweenMapPoints(p1, p2);
                
                OpenRedPackageView *open = [[OpenRedPackageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
                self.openRedView = open;
                open.dic = dic[@"data"];
                open.distance = distance ;
                [[UIApplication sharedApplication].keyWindow addSubview:open];
                [open startAnimation];
                
                LRWeakSelf(self);
                open.block = ^(NSDictionary * _Nonnull dic) {
                    LRStrongSelf(self);
                    [self grabRedPacketRequest:dic];
                    
                };
                
            }
            
        }
        
    } WithFailBlock:^(id result) {
        
        [ProgressHUDView dismiss];
        
    }];
    
}

///抢红包大战
- (void)grabRedPacketRequest:(NSDictionary *)dataDic{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"orderNo"] = dataDic[@"cOrderNo"];
    parameter[@"nLongitude"] = @([LocationManager sharedInstance].currentCoordinaate2D.longitude).stringValue;
    parameter[@"nLatitude"] = @([LocationManager sharedInstance].currentCoordinaate2D.latitude).stringValue;
    parameter[@"cLocationIntro"] = [LocationManager sharedInstance].cLocationIntro;
    
    [HttpManagerRequest grabRedPacketWithParameter:parameter WithSuccessBlock:^(id result) {
       
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            [self.openRedView hide];
            RedPacketListVC *red = [[RedPacketListVC alloc]init];
            red.orderNo = dataDic[@"cOrderNo"];
            red.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:red animated:YES];
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

@end
