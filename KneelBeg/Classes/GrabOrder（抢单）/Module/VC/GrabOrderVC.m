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

#pragma mark--高德地图api
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface GrabOrderVC ()<AMapLocationManagerDelegate,MAMapViewDelegate>

@property (nonatomic, weak) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, weak) UILabel  *middleLab;
@property (nonatomic, strong) GrabWaterView *waterView;

@end

@implementation GrabOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLocationUI];
    [self initLocationManager];
    [self addPointAnnotationData];
    
}

- (BOOL)fd_prefersNavigationBarHidden{
 
    return YES;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView setZoomLevel:16.1 animated:YES];
    
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

- (void)setLocationUI{
    
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    MAMapView *mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - BDBottomHeight)];
    mapView.delegate = self;
    self.mapView = mapView;
    [self.view addSubview:mapView];
    mapView.showsScale = NO;
    mapView.showsCompass = NO;
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
    
//    AMapLocationManager *locationManager = [[AMapLocationManager alloc]init];
//    self.locationManager =locationManager;
//    locationManager.distanceFilter = 100;
//    locationManager.delegate = self;
//    [self.locationManager setLocatingWithReGeocode:YES];
//    [self.locationManager startUpdatingLocation];
    
}

#pragma mark---添加标注
- (void)addPointAnnotationData{
    
    NSArray *data1 = @[@"31.203387",@"31.203919",@"121.491882",@"31.203379",@"31.203380"];
    NSArray *data2 = @[@"121.494994",@"121.492977",@"121.491882",@"121.491880",@"121.491875"];
    
    for (NSInteger index = 0; index < 5; index ++ ) {
        
        float point1 = [data1[index] floatValue];
        float point2 = [data2[index] floatValue];
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(point1, point2);
        pointAnnotation.title = @"方恒国际";
        pointAnnotation.subtitle = @"阜通东大街6号";
        [self.mapView addAnnotation:pointAnnotation];
        
    }
    
}

- (void)restartUpdateLocation{
    
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark---定位地图代理
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
        
//        self.mapView.userLocation.location = location;
//        [self.mapView updateUserLocationRepresentation:self.mapView.userLocation];
        
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        CustomAnnotationView*annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.image = [UIImage imageNamed:@"气球坐标"];
        annotationView.canShowCallout= NO;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}


#pragma mark----点击事件
///跳转瀑布流控制器
- (void)openWaterFallOrderVC:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    self.waterView.hidden = !btn.selected;
    
}

@end
