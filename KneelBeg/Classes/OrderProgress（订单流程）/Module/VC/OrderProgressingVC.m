//
//  OrderProgressingVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/15.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//
#import "OrderProgressingVC.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface OrderProgressingVC ()<MAMapViewDelegate>

@property (nonatomic, weak)    MAMapView *mapView;
@property (nonatomic, strong)  UILabel   *timeLab;
@property (nonatomic, strong)  UILabel   *timeLab1;
@property (nonatomic, strong)  UILabel   *distanceLab;

@property (nonatomic, strong)  UIButton  *bottomBtn;

@end

@implementation OrderProgressingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLocationUI];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView setZoomLevel:16.1 animated:YES];
    
    //    [self getMapPointData];
    
}

- (void)setLocationUI{
    
    self.navigationItem.title = @"订单进行中";
    
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    MAMapView *mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - BDBottomHeight)];
    mapView.userTrackingMode = MAUserTrackingModeNone;
    mapView.delegate = self;
    self.mapView = mapView;
    [self.view addSubview:mapView];
    mapView.showsScale = NO;
    mapView.showsCompass = NO;
    mapView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = whiteColor();
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(BDTopHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(150);
        
    }];
    
    [topView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView).offset(20);
        make.centerX.equalTo(topView.mas_left).offset(SCREEN_WIDTH/6.0);
        
    }];
    
    [topView addSubview:self.timeLab1];
    [self.timeLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView).offset(20);
        make.centerX.equalTo(topView.mas_left).offset(SCREEN_WIDTH/2.0);
        
    }];
    
    [topView addSubview:self.distanceLab];
    [self.distanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView).offset(20);
        make.centerX.equalTo(topView.mas_left).offset(5 * SCREEN_WIDTH/6.0);
        
    }];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.textColor = HexColor(@"9b9b9b");
    label1.text = @"剩余时间";
    label1.font = Font15();
    [topView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeLab.mas_bottom).offset(3);
        make.centerX.equalTo(self.timeLab);
        
    }];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.textColor = HexColor(@"9b9b9b");
    label2.text = @"时长";
    label2.font = Font15();
    [topView addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeLab1.mas_bottom).offset(3);
        make.centerX.equalTo(self.timeLab1);
        
    }];
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.textColor = HexColor(@"9b9b9b");
    label3.text = @"距离";
    label3.font = Font15();
    [topView addSubview:label3];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.distanceLab.mas_bottom).offset(3);
        make.centerX.equalTo(self.distanceLab);
        
    }];
    
    CGFloat width = (SCREEN_WIDTH - 4 * 20)/3.0;
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"申请退单" forState:UIControlStateNormal];
    [btn1 setTitleColor:whiteColor() forState:UIControlStateNormal];
    btn1.backgroundColor = redColor();
    [btn1 rounded:8];
    btn1.titleLabel.font = Font15();
    [btn1 addTarget:self action:@selector(refusedOrderAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.timeLab);
        make.bottom.equalTo(topView).offset(-20);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(40);
        
    }];
    
    UIButton *btn2 = [[UIButton alloc]init];
    [btn2 setTitle:@"任务执行中" forState:UIControlStateNormal];
    [btn2 setTitleColor:whiteColor() forState:UIControlStateNormal];
    btn2.backgroundColor = blackColor();
    [btn2 rounded:8];
    btn2.titleLabel.font = Font15();
    [topView addSubview:btn2];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.timeLab1);
        make.bottom.equalTo(topView).offset(-20);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(40);
        
    }];
    
    UIButton *btn3 = [[UIButton alloc]init];
    [btn3 setTitle:@"联系对方" forState:UIControlStateNormal];
    [btn3 setTitleColor:whiteColor() forState:UIControlStateNormal];
    btn3.backgroundColor = greenColor();
    [btn3 rounded:8];
    btn3.titleLabel.font = Font15();
    [btn3 addTarget:self action:@selector(contactOtherUserAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn3];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.distanceLab);
        make.bottom.equalTo(topView).offset(-20);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(40);
        
    }];
    
    UIView *bottomView1 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT - 67, SCREEN_WIDTH, 67)];
    bottomView1.backgroundColor = whiteColor();
    [self.view addSubview:bottomView1];
    
    [bottomView1 addSubview:self.bottomBtn];
    [self.bottomBtn rounded:8];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(bottomView1);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(45);
        
    }];
    
    
}

#pragma mark---懒加载
- (UILabel *)timeLab{
    
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = greenColor();
        _timeLab.font = BlodFont(24);
        _timeLab.text = @"00:20:23";
        
    }
    return _timeLab;
}

- (UILabel *)timeLab1{
    
    if (!_timeLab1) {
        _timeLab1 = [[UILabel alloc]init];
        _timeLab1.textColor = redColor();
        _timeLab1.text = @"00:17";
        _timeLab1.font = BlodFont(24);
        
    }
    return _timeLab1;
}

- (UILabel *)distanceLab{
    
    if (!_distanceLab) {
        _distanceLab = [[UILabel alloc]init];
        _distanceLab.textColor = blackColor();
        _distanceLab.text = @"0.52km";
        _distanceLab.font = BlodFont(24);
        
    }
    return _distanceLab;
}

- (UIButton *)bottomBtn{
    
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc]init];
        [_bottomBtn setTitle:@"完成约定任务" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:whiteColor() forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = Font15();
        _bottomBtn.backgroundColor = redColor();
    }
    return _bottomBtn;
}

#pragma mark---点击事件
- (void)refusedOrderAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退单申请" message:@"申请退单将扣除您5%的订单费用，最低扣款为1元，您确定申请吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"再想一想" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancle];
    [alert addAction:sure];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
}

- (void)contactOtherUserAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *sendMessageAction = [UIAlertAction actionWithTitle:@"发消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"打电话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:sendMessageAction];
    [alert addAction:callAction];
    [alert addAction:cancleAction];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
}

@end
