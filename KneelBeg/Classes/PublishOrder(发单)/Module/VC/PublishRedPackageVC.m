//
//  PublishRedPackageVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/21.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "PublishRedPackageVC.h"
#import "RedPackageCell1.h"
#import "RedPageageCell2.h"
#import "DataPickView.h"
#import "UITextView+Placeholder.h"
#import "LocationManager.h"
#import "PublishSuccessVC.h"

@interface PublishRedPackageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL        shouldArrive;
@property (nonatomic, strong) UILabel     *amountLab;
@property (nonatomic, strong) UIButton    *openBtn;
@property (nonatomic, strong) UIView      *bottomView;
@property (nonatomic, strong) UITextView  *textView;
@property (nonatomic, weak)   DataPickView *timePickView;
@property (nonatomic, weak)   DataPickView *airPickView;
@property (nonatomic, weak)   DataPickView *rediusPickView;
///祝福语
@property (nonatomic, copy)   NSString     *wishStr;

///金额
@property (nonatomic, copy)   NSString    *amountS;
///红包个数
@property (nonatomic, copy)   NSString    *redNum;
///持续时间
@property (nonatomic, copy)   NSString    *time;
///领取范围
@property (nonatomic, copy)   NSString    *readius;
///存放时间间隔的数组
@property (nonatomic, strong) NSArray     *timeArr;
///时间字符串
@property (nonatomic, copy)   NSString    *timeS;
///范围数组
@property (nonatomic, strong) NSArray     *rangeArr;
///范围
@property (nonatomic, copy)   NSString    *rangeS;
///是否在f范围内
@property (nonatomic, strong) NSArray     *reachArr;
///最低价格
@property (nonatomic, assign) NSInteger   minPrice;
///最高价格
@property (nonatomic, assign) NSInteger   maxPrice;
///最小数量
@property (nonatomic, assign) NSInteger   minAmount;
///最大数量
@property (nonatomic, assign) NSInteger   maxAmount;
///经度
@property (nonatomic, copy)   NSString    *nLongitude;
///维度
@property (nonatomic, copy)   NSString    *nLatitude;
///地理编码信息简介
@property (nonatomic, copy)   NSString    *cLocationIntro;

@end

static NSString *cellID = @"PublishRedPackageVC";
static NSString *cellID1 = @"PublishRedPackageVC1";
@implementation PublishRedPackageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self locationPoint];
    self.shouldArrive = YES;
    self.wishStr = @"求人不如求己，红包就在这里";
    [self initSubviews];
    [self getRedPacketWordsRequest];
    // Do any additional setup after loading the view.
}

- (void)initSubviews{
    
    self.navigationItem.title = @"发红包";
    [self.view addSubview:self.tableView];

    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:blackColor() forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = Font14();
    [cancleBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancleBtn];
    
//    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [cancleBtn setImage:[UIImage imageNamed:@"发单更多"] forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    
    [self.bottomView addSubview:self.textView];
    [self.bottomView addSubview:self.amountLab];
    [self.bottomView addSubview:self.openBtn];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.textView.mas_bottom).offset(40);
        make.centerX.equalTo(self.bottomView);
        
    }];
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.amountLab.mas_bottom).offset(20);
        make.centerX.equalTo(self.bottomView);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(45);
        
    }];
    
    self.tableView.tableFooterView = self.bottomView;
    
}

#pragma mark---懒加载
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, BDTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - BDTopHeight - BDBottomHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = HexColor(@"f5f5f5");
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 70;
        
        [_tableView registerClass:[RedPackageCell1 class] forCellReuseIdentifier:cellID];
        [_tableView registerClass:[RedPageageCell2 class] forCellReuseIdentifier:cellID1];
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
            
        }
    }
    return _tableView;
}

- (UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        
    }
    return _bottomView;
}

- (UILabel *)amountLab{
    
    if (!_amountLab) {
        _amountLab = [[UILabel alloc]init];
        _amountLab.textColor = blackColor();
        _amountLab.font = BlodFont(12);
        _amountLab.attributedText = [Util mutableStringWithTitle:@"¥8.80" WithString1:@"8.80" WithAttrDic1:@{NSFontAttributeName : BlodFont(36)}];
        
    }
    return _amountLab;
}

- (UIButton *)openBtn{
    
    if (!_openBtn) {
        _openBtn = [[UIButton alloc]init];
        [_openBtn setTitle:@"塞钱进红包" forState:UIControlStateNormal];
        [_openBtn setTitleColor:whiteColor() forState:UIControlStateNormal];
        _openBtn.titleLabel.font = Font15();
        [_openBtn setBackgroundColor:redColor()];
        [_openBtn rounded:8];
        [_openBtn addTarget:self action:@selector(publistRequest) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _openBtn;
}

- (UITextView *)textView{
    
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 80)];
        _textView.placeholder = self.wishStr;
        _textView.backgroundColor = whiteColor();
        _textView.font = Font15();
        _textView.textColor = blackColor();
        _textView.tintColor = blackColor();
        _textView.contentInset = UIEdgeInsetsMake(5, 15, 5, 15);
        [_textView rounded:6];
    }
    return _textView;
}

#pragma mark---<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count = 4;
    
    if (self.shouldArrive) {
        count = 5;
        
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 2) {
        
        NSArray *titleArr = @[@"总金额",@"红包个数"];
        NSArray *rightArr = @[@"元",@"个"];
        NSArray *placeArr = @[@"0.00",@"0"];
        
        RedPackageCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        cell.titleS = titleArr[indexPath.row];
        cell.rightS = rightArr[indexPath.row];
        cell.placeHolder = placeArr[indexPath.row];
        cell.row = indexPath.row;
        
        LRWeakSelf(self);
        cell.block = ^(NSString *str, NSInteger row) {
            LRStrongSelf(self);
            
            if (row == 0) {
                
                self.amountS = str;
                self.amountLab.attributedText = [Util mutableStringWithTitle:[NSString stringWithFormat:@"¥%@",str] WithString1:str WithAttrDic1:@{NSFontAttributeName : BlodFont(36)}];
                
            } else {
                
                self.redNum = str;
                
            }
            
        };
        
        return cell;
        
    } else {
        
        RedPageageCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellID1 forIndexPath:indexPath];
        NSArray *titleArr = @[@"持续时间",@"是否需要到达目的地",@"领取范围"];
        cell.titleS = titleArr[indexPath.row - 2];
        
        if (indexPath.row == 3) {
            cell.contentS = self.shouldArrive ? @"是": @"否" ;
        }
        
        return cell;
        
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        
        DataPickView *pickView = [[DataPickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        pickView.data = self.timeArr;
        self.airPickView = pickView;
        [pickView startAnimation];
        
        LRWeakSelf(self);
        pickView.block = ^(NSString *title) {
            LRStrongSelf(self);
            
            RedPageageCell2 *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.contentS = title;
            self.timeS = [title stringByReplacingOccurrencesOfString:@"小时" withString:@""];
            [self.airPickView hideAnimation];
            
        };
        
        
    } else if (indexPath.row == 3) {
        
        DataPickView *pickView = [[DataPickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        pickView.data = @[@"是",@"否"];
        self.airPickView = pickView;
        [pickView startAnimation];
        
        LRWeakSelf(self);
        pickView.block = ^(NSString *title) {
            LRStrongSelf(self);
            self.shouldArrive = [title isEqualToString:@"是"] ? YES : NO ;
            [self.tableView reloadData];
            [self.airPickView hideAnimation];
            
        };
        
    } else if (indexPath.row == 4 ) {
        
        DataPickView *pickView = [[DataPickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        pickView.data = self.rangeArr;
        self.airPickView = pickView;
        [pickView startAnimation];
        
        LRWeakSelf(self);
        pickView.block = ^(NSString *title) {
            LRStrongSelf(self);
//            self.shouldArrive = [title isEqualToString:@"是"] ? YES : NO ;
//            [self.tableView reloadData];
            RedPageageCell2 *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
            cell.contentS = title;
            self.rangeS = [title stringByReplacingOccurrencesOfString:@"m" withString:@""];
            [self.airPickView hideAnimation];
            
        };
        
        
    }
    
}

#pragma mark---事件
- (void)locationPoint{
    
    [[LocationManager sharedInstance] startUpdatingLocation];
    [LocationManager sharedInstance].locationDelegate = self;
    
}

- (void)closeAction{
    
    for (BaseViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[NSClassFromString(@"SendTypeOrderVC") class]]) {
            
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }
    
}

///处理热词数据
- (void)initWebData:(NSDictionary *)dataDic{
    
    NSArray *timeArr = dataDic[@"timeLimit"];
    NSArray *amountArr = dataDic[@"amountLimit"];
    NSArray *reachArr = dataDic[@"isReach"];
    NSArray *rangeArr = dataDic[@"rangeLimit"];
    NSArray *priceArr = dataDic[@"priceLimit"];;
    
    NSInteger minTime = 0;
    NSInteger maxTime = 0;
    
    for (NSDictionary *timeDic in timeArr) {
        
        NSString *timeKey = timeDic[@"cKey"];
        
        if ([timeKey isEqualToString:@"ORDER_MAX_TIME"]) {
            maxTime = [timeDic[@"cValue"] integerValue];
            
        } else {
            minTime = [timeDic[@"cValue"] integerValue];
            
        }
        
    }
    
    if (minTime == 0) {
        minTime = 1;
    }
    
    NSMutableArray *timeArray = [NSMutableArray array];
    for (NSInteger index = minTime; index <= maxTime; index++) {
        
        [timeArray addObject:[NSString stringWithFormat:@"%ld小时",index]];
        
        if (index == minTime) {
            self.timeS = @(index).stringValue;
        }
        
        
    }
    
    self.timeArr = timeArray;
    
    for (NSDictionary *amountDic in amountArr) {
        
        NSString *amountKey = amountDic[@"cKey"];
        if ([amountKey isEqualToString:@"ORDER_MAX_AMOUNT"]) {
            self.maxAmount = [amountDic[@"cValue"] integerValue];
            
        } else {
            self.minAmount = [amountDic[@"cValue"] integerValue];
            
        }
        
    }
    
    NSMutableArray *rangeArray = [NSMutableArray array];
    for (NSInteger index =0 ; index < rangeArr.count; index++) {
        
        NSDictionary *rangeDic = rangeArr[index];
        NSString *rangeStr = [NSString stringWithFormat:@"%@m",rangeDic[@"cValue"]];
        if (index == 0) {
            self.rangeS = rangeDic[@"cValue"];
        }
        [rangeArray addObject:rangeStr];
        
    }
    self.rangeArr = [rangeArray mutableCopy];
    
    NSMutableArray *reachArray = [NSMutableArray array];
    for (NSDictionary *reachDic in reachArr) {
        
        [reachArray addObject:reachDic[@"cValue"]];
        
    }
    self.reachArr = [reachArray mutableCopy];
    
    for (NSDictionary *priceDic in priceArr) {
        
        NSString *key = priceDic[@"cKey"];
        if ([key isEqualToString:@"ORDER_MAX_PRICE"]) {
            self.maxPrice = [priceDic[@"cValue"] integerValue];
            
        } else {
            self.minPrice = [priceDic[@"cValue"] integerValue];
            
        }
        
    }
    
}

#pragma mark----网络请求
- (void)getRedPacketWordsRequest{
    
    [HttpManagerRequest publishRedPacketWithWordsWithSuccessBlock:^(id result) {
       
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            [self initWebData:dic[@"data"]];
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

///发布接口
- (void)publistRequest{
    
    if (![UserModelManager userIsLogin]) {
        return;
    }
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"orderType"] = @"RED_PACKET";
    parameter[@"userId"] = [UserModelManager getUserId];
    parameter[@"nPrice"] = self.amountS;
    parameter[@"nLongitude"] = self.nLongitude;
    parameter[@"nLatitude"] = self.nLatitude;
    parameter[@"cLocationIntro"] = self.cLocationIntro;
    parameter[@"timeDuration"] = self.timeS;
    parameter[@"nIsReach"] = @(self.shouldArrive).stringValue;
    parameter[@"nAmount"] = self.redNum;
    parameter[@"cDesc"] = self.wishStr;
    parameter[@"cPayType"] = @"ZYB";
    
    if (self.shouldArrive) {
        parameter[@"nRange"] = self.rangeS;
    }
    
    [HttpManagerRequest publishOrderWithParameter:parameter WithSuccessBlock:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            PublishSuccessVC *successVC = [[PublishSuccessVC alloc]init];
            [self.navigationController pushViewController:successVC animated:YES];
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
    
}

#pragma mark---<LocationManagerDelegate>
- (void)finishLocationWithLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    
    self.nLongitude = @(location.coordinate.longitude).stringValue;
    self.nLatitude = @(location.coordinate.latitude).stringValue;
    self.cLocationIntro = reGeocode.formattedAddress;
    NSLog(@"%@---%@",self.nLongitude,self.nLatitude);
    
}

@end
