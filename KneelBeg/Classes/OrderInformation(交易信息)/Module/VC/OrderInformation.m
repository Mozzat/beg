//
//  OrderInformation.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/15.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "OrderInformation.h"

@interface OrderInformation ()

@property (nonatomic, strong) UILabel   *moneyLab;
@property (nonatomic, strong) UILabel   *serviceType;
@property (nonatomic, strong) UILabel   *timeLab;
@property (nonatomic, strong) UILabel   *addressLab;
@property (nonatomic, strong) UILabel   *orderNoLab;
@property (nonatomic, strong) UILabel   *startTimeLab;

@property (nonatomic, strong) UIButton  *bottomBtn;

@end

@implementation OrderInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLocationUI];
    
}


- (void)setLocationUI{
    
    self.navigationItem.title = @"订单详情";
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, BDTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - BDTopHeight - 67)];
    scrollView.backgroundColor = whiteColor();
    [self.view addSubview:scrollView];
    
    UIView *containView = [[UIView alloc]init];
    [scrollView addSubview:containView];
    
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(scrollView);
        make.width.mas_equalTo(scrollView);
        make.bottom.equalTo(scrollView);
        
    }];
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = whiteColor();
    [containView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(containView);
        make.left.right.equalTo(containView);
        make.height.mas_equalTo(80);
        
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.textColor = blackColor();
    titleLab.font = Font15();
    titleLab.text = @"支付金额";
    [topView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(topView);
        make.left.equalTo(topView).offset(20);
        
    }];
    
    [topView addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(topView);
        make.right.equalTo(topView).offset(-20);
        
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HexColor(@"f5f5f5");
    [containView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView.mas_bottom);
        make.left.right.equalTo(topView);
        make.height.mas_equalTo(5);
        
    }];
    
    UIView *middleView = [[UIView alloc]init];
    middleView.backgroundColor = whiteColor();
    [containView addSubview:middleView];
    
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line.mas_bottom);
        make.left.right.equalTo(topView);
        make.height.mas_equalTo(220);
        
    }];
    
    UILabel *topLab = [[UILabel alloc]init];
    topLab.text = @"交易类型";
    topLab.textColor = blackColor();
    topLab.font = BlodFont(18);
    [middleView addSubview:topLab];
    
    [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(middleView).offset(20);
        
        
    }];
    
    UILabel *serviceTitle = [[UILabel alloc]init];
    serviceTitle.textColor = HexColor(@"9b9b9b");
    serviceTitle.text = @"服务类型";
    serviceTitle.font = Font15();
    [middleView addSubview:serviceTitle];
    
    [serviceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleLab.mas_bottom).offset(20);
        make.left.equalTo(middleView);
        
    }];
    
    UILabel *serviceTime = [[UILabel alloc]init];
    serviceTime.textColor = HexColor(@"9b9b9b");
    serviceTime.text = @"服务时间";
    serviceTime.font = Font15();
    [middleView addSubview:serviceTime];
    
    [serviceTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(serviceTitle.mas_bottom).offset(20);
        make.left.equalTo(middleView);
        
    }];
    
    
    UILabel *serviceAddress = [[UILabel alloc]init];
    serviceAddress.textColor = HexColor(@"9b9b9b");
    serviceAddress.text = @"服务地址";
    serviceAddress.font = Font15();
    [middleView addSubview:serviceAddress];
    
    [serviceAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(serviceTitle.mas_bottom).offset(20);
        make.left.equalTo(middleView);
        
    }];
    
    [middleView addSubview:self.serviceType];
    [self.serviceType mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(serviceTitle);
        make.right.equalTo(middleView).offset(-20);
        
    }];
    
    [middleView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(serviceTime);
        make.right.equalTo(middleView).offset(-20);
        
    }];
    
    [middleView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(serviceAddress);
        make.right.equalTo(middleView).offset(-20);
        make.left.equalTo(middleView).offset(10);
        
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = HexColor(@"f5f5f5");
    [containView addSubview:line1];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(middleView.mas_bottom);
        make.left.right.equalTo(topView);
        make.height.mas_equalTo(5);
        
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    [containView addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line1.mas_bottom);
        make.left.right.equalTo(topView);
        make.height.mas_equalTo(140);
        make.bottom.equalTo(containView);
        
    }];
    
    UILabel *bottomLab = [[UILabel alloc]init];
    bottomLab.text = @"交易类型";
    bottomLab.textColor = blackColor();
    bottomLab.font = BlodFont(18);
    [bottomView addSubview:bottomLab];
    
    [bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(bottomView).offset(20);
        
        
    }];
    
    UILabel *orderTitle = [[UILabel alloc]init];
    orderTitle.textColor = HexColor(@"9b9b9b");
    orderTitle.text = @"订单编号";
    orderTitle.font = Font15();
    [bottomView addSubview:orderTitle];
    
    [orderTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(bottomLab.mas_bottom).offset(20);
        make.left.equalTo(bottomLab);
        
    }];
    
    UILabel *startTimeitle = [[UILabel alloc]init];
    startTimeitle.textColor = HexColor(@"9b9b9b");
    startTimeitle.text = @"下单时间";
    startTimeitle.font = Font15();
    [bottomView addSubview:startTimeitle];
    
    [startTimeitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(orderTitle.mas_bottom).offset(20);
        make.left.equalTo(orderTitle);
        
    }];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"复制" forState:UIControlStateNormal];
    [btn setTitleColor:blackColor() forState:UIControlStateNormal];
    btn.titleLabel.font = Font12();
    [btn rounded:4 width:0.5 color:HexColor(@"ebebeb")];
    [bottomView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(orderTitle);
        make.right.equalTo(bottomView).offset(-20);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(46);
        
    }];
    
    [bottomView addSubview:self.orderNoLab];
    [self.orderNoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(orderTitle);
        make.left.equalTo(orderTitle.mas_right).offset(20);
        make.right.equalTo(btn.mas_left).offset(-10);
        
    }];
    
    [bottomView addSubview:self.startTimeLab];
    [self.startTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(startTimeitle);
        make.left.equalTo(startTimeitle.mas_right).offset(20);
        make.right.equalTo(bottomView.mas_left).offset(-20);
        
    }];
    
    UIView *bottomView1 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT - 67, SCREEN_WIDTH, 67)];
    bottomView1.backgroundColor = whiteColor();
    [self.view addSubview:bottomView1];
    
    [bottomView1 addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(bottomView1);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(45);
        
    }];
    
}

#pragma mark---懒加载
- (UILabel *)moneyLab{
    
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc]init];
        _moneyLab.font = Font15();
        _moneyLab.textColor = redColor();
        _moneyLab.attributedText = [Util mutableStringWithTitle:@"8.60元" WithString1:@"8.60" WithAttrDic1:@{NSFontAttributeName:BlodFont(24)}];
    }
    return _moneyLab;
}

- (UILabel *)serviceType{
    
    if (!_serviceType) {
        _serviceType = [[UILabel alloc]init];
        _serviceType.text = @"跑腿";
        _serviceType.font = Font15();
        _serviceType.textColor = blackColor();
    }
    return _serviceType;
}

- (UILabel *)addressLab{
    
    if (!_addressLab) {
        _addressLab = [[UILabel alloc]init];
        _addressLab.text = @"Alice(女士) 13823890112\n原马德里案例馆";
        _addressLab.font =Font15();
        _addressLab.textColor = blackColor();
        _addressLab.textAlignment = NSTextAlignmentRight;
        
    }
    return _addressLab;
}

- (UILabel *)orderNoLab{
    
    if (!_orderNoLab) {
        _orderNoLab = [[UILabel alloc]init];
        _orderNoLab.textColor = blackColor();
        _orderNoLab.font = Font15();
        _orderNoLab.text = @"6427 8919 0080 4923";
        _orderNoLab.textAlignment = NSTextAlignmentRight;
    }
    return _orderNoLab;
}

- (UILabel *)startTimeLab{
    
    if (!_startTimeLab) {
        _startTimeLab = [[UILabel alloc]init];
        _startTimeLab.text = @"2019-02-14 14:27:21";
        _startTimeLab.textColor = blackColor();
        _startTimeLab.font = Font15();
        _startTimeLab.textAlignment = NSTextAlignmentRight;
        
    }
    return _startTimeLab;
}

- (UIButton *)bottomBtn{
    
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc]init];
        [_bottomBtn setTitle:@"发起收款" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:whiteColor() forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = Font15();
        _bottomBtn.backgroundColor = redColor();
    }
    return _bottomBtn;
}

@end
