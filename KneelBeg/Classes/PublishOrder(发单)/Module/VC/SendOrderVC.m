//
//  SendOrderVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/19.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "SendOrderVC.h"
#import "BaseNavigationController.h"

#import <UINavigationController+FDFullscreenPopGesture.h>
#pragma mark--高德地图api
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "SendBottomView.h"
#import "SendTypeOrderVC.h"

@interface SendOrderVC ()<AMapLocationManagerDelegate,MAMapViewDelegate>

@property (nonatomic, weak) MAMapView *mapView;
@property (nonatomic, strong) UILabel *addressLab;

@end

@implementation SendOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLocationUI];
    
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
- (UILabel *)addressLab{
    
    if (!_addressLab) {
        _addressLab = [[UILabel alloc]init];
        _addressLab.text = @"马德里案例馆附近";
        _addressLab.textColor = whiteColor();
        _addressLab.font = Font14();
        
    }
    return _addressLab;
}

- (void)setLocationUI{
    
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    MAMapView *mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - BDBottomHeight)];
    mapView.delegate = self;
    self.mapView = mapView;
    [self.view addSubview:mapView];
    mapView.showsScale = NO;
    mapView.showsCompass = NO;
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = whiteColor();
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(BDTopHeight);
        
    }];
    
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
    
    UIView *middleView = [[UIView alloc]init];
    [middleView rounded:20];
    middleView.backgroundColor = HexColor(@"4a4a4a");
    [self.view addSubview:middleView];
    
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(40);
        
    }];
    
    UIView *point = [[UIView alloc]init];
    point.backgroundColor = redColor();
    [point rounded:7.5];
    [middleView addSubview:point];
    
    [point mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(middleView);
        make.left.equalTo(middleView).offset(20);
        make.width.height.mas_equalTo(15);
        
    }];
    
    [middleView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(middleView);
        make.left.equalTo(point.mas_right).offset(10);
        
    }];
    
    SendBottomView *bottomView = [[SendBottomView alloc]init];
    [bottomView addTarget:self action:@selector(openOrderTypeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(245);
        make.left.width.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-BDTabBarHeight);
        
    }];
    
}

#pragma mark---
- (void)openOrderTypeVC{
    
    SendTypeOrderVC *order = [[SendTypeOrderVC alloc]init];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:order];
    [self presentViewController:nav animated:YES completion:nil];
    
}

@end
