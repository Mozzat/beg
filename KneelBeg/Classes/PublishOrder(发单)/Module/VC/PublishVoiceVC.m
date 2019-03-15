//
//  PublishVoiceVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/21.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "PublishVoiceVC.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "PublishOrderLineView.h"
#import "UITextView+Placeholder.h"
#import "PublishVoiceView.h"
#import "PublishShowImageOrVideoView.h"
#import "DataPickView.h"
#import "PublishPayMethedView.h"
#import "LYFPhotoModel.h"
#import "LocationManager.h"
#import "PublishSuccessVC.h"

@interface PublishVoiceVC ()

@property (nonatomic, strong) UIScrollView *scrollView;
///标题
@property (nonatomic, strong) UITextField  *titleTextF;
///内容
@property (nonatomic, strong) UITextView   *contetnText;
///显示音频
@property (nonatomic, strong) PublishVoiceView *voiceView;

@property (nonatomic, strong) UIButton     *publishBtn;

@property (nonatomic, strong) UIView        *middleView;

///时间数组
@property (nonatomic, strong) NSArray        *timeArr;
///活动类别
@property (nonatomic, strong) NSArray        *categoryArr;
///活动保存
@property (nonatomic, strong) NSDictionary   *categoryDic;
///支付方式
@property (nonatomic, strong) NSArray        *payTypeArr;
///交易方式
@property (nonatomic, strong) NSArray        *tradeTypeArr;

@property (nonatomic, strong) NSMutableDictionary *imageDic;

@property (nonatomic, weak)   PublishPayMethedView *m1View;
@property (nonatomic, weak)   PublishPayMethedView *m2View;

///价格
@property (nonatomic, copy)   NSString       *price;
///支付类型
@property (nonatomic, copy)   NSString       *payType;
///活动类型
@property (nonatomic, copy)   NSString       *categoryType;
///交易方式
@property (nonatomic, copy)   NSString       *tradeTyp;
///持续时间
@property (nonatomic, copy)   NSString       *time;
///经度
@property (nonatomic, copy)   NSString       *nLongitude;
///维度
@property (nonatomic, copy)   NSString       *nLatitude;

@property (nonatomic, weak)   DataPickView   *pickView1;

@property (nonatomic, weak)   DataPickView   *pickView2;

@end

@implementation PublishVoiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self locationPoint];
    
    [self setLocationUI];
    
    [self getOrderWords];
    
}

- (BOOL)fd_prefersNavigationBarHidden{
    
    return  YES;
    
}

- (void)locationPoint{
    
    [[LocationManager sharedInstance] startUpdatingLocation];
    [LocationManager sharedInstance].locationDelegate = self;
    
}


- (void)setLocationUI{
    
    UIView *navigateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BDTopHeight)];
    navigateView.backgroundColor = whiteColor();
    [self.view addSubview:navigateView];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"发单关闭"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [navigateView addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(30);
        make.left.equalTo(navigateView).offset(7);
        make.bottom.equalTo(navigateView).offset(-7);
        
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.textColor = blackColor();
    titleLab.font = BlodFont(16);
    titleLab.text = @"发布";
    [navigateView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(navigateView);
        make.centerY.equalTo(closeBtn);
        
    }];
    
    UIView *navLine = [[UIView alloc]init];
    navLine.backgroundColor = HexColor(@"ebebeb");
    [navigateView addSubview:navLine];
    
    [navLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(navigateView);
        make.right.equalTo(navigateView);
        make.bottom.equalTo(navigateView);
        make.height.mas_equalTo(1);
        
    }];
    
    
    [self.view addSubview:self.scrollView];
    
    ///contaionVIew
    UIView *containView = [[UIView alloc]init];
    containView.backgroundColor = HexColor(@"f5f5f5");
    [self.scrollView addSubview:containView];
    
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.scrollView);
        
    }];
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = whiteColor();
    [containView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(containView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        //        make.height.mas_equalTo(300);
        
    }];
    
    [topView addSubview:self.titleTextF];
    [self.titleTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView);
        make.left.equalTo(topView).offset(20);
        make.right.equalTo(topView).offset(-20);
        make.height.mas_equalTo(55);
        
    }];
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = HexColor(@"ebebeb");
    [topView addSubview:topLine];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleTextF.mas_bottom);
        make.left.equalTo(self.titleTextF);
        make.right.equalTo(topView);
        make.height.mas_equalTo(1);
        
    }];
    
    [topView addSubview:self.contetnText];
    [self.contetnText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topLine.mas_bottom).offset(10);
        make.left.equalTo(topView).offset(12);
        make.right.equalTo(topView).offset(-12);
        make.height.mas_equalTo(140);
        
    }];
    
    [topView addSubview:self.voiceView];
    [self.voiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contetnText.mas_bottom).offset(10);
        make.left.right.equalTo(topView);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(topView).offset(-20);
        
    }];
    
    UIView *middleView = [[UIView alloc]init];
    middleView.backgroundColor = whiteColor();
    self.middleView = middleView;
    [containView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.left.right.equalTo(containView);
        make.bottom.equalTo(containView);
        
    }];
    
    NSArray *titleArr = @[@"价格",@"分类",@"时间"];
    PublishOrderLineView *lastView = nil;
    for (NSInteger index = 0 ; index < 3; index ++) {
        
        PublishOrderLineType type =  PublishOrderLineTypeInput;
        if (index != 0) {
            type = PublishOrderLineTypeTap;
        }
        
        PublishOrderLineView *lineView = [[PublishOrderLineView alloc]initWithFrame:CGRectMake(0, index * 60, SCREEN_WIDTH, 60) WithType:type];
        [lineView setTitles:titleArr[index]];
        [middleView addSubview:lineView];
        [lineView addTarget:self action:@selector(publishOrderLineAction:) forControlEvents:UIControlEventTouchUpInside];
        lineView.tag = 1111 + index;
        lastView = lineView;
        
        if (index == 1) {
            [lineView setContent:@"跑腿" WithTextColor:blackColor()];
            
        }
        
        if (index == 0) {
            
            LRWeakSelf(self);
            lineView.block = ^(NSString *text) {
                LRStrongSelf(self);
                self.price = text;
            };
            
        }
        
    }
    
    PublishPayMethedView *m1 = [[PublishPayMethedView alloc]init];
    m1.titleS = @"支付方式";
    [middleView addSubview:m1];
    self.m1View = m1;
    
    LRWeakSelf(self);
    m1.bloack = ^(NSDictionary *dic) {
        LRStrongSelf(self);
        self.payType = dic[@"cKey"];
    };
    
    [m1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lastView.mas_bottom);
        make.left.equalTo(middleView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_greaterThanOrEqualTo(60);
        
    }];
    
    PublishPayMethedView *m2 = [[PublishPayMethedView alloc]init];
    m2.titleS = @"交易方式";
    [middleView addSubview:m2];
    self.m2View = m2;
    
    m2.bloack = ^(NSDictionary *dic) {
        
        LRStrongSelf(self);
        self.tradeTyp = dic[@"cKey"];
        
    };
    
    [m2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(m1.mas_bottom);
        make.left.equalTo(middleView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_greaterThanOrEqualTo(60);
        make.bottom.equalTo(middleView);
        
    }];
    
    [self.view addSubview:self.publishBtn];
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view).offset( -BDBottomHeight - 11);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(45);
        
    }];
    
}

- (void)initWebData:(NSDictionary *)dic{
    
    ///时间限制
    NSArray *timeLimitArr = dic[@"timeLimit"];
    NSInteger maxTime = 0;
    NSInteger minTime = 0;
    
    for (NSDictionary *timeDic in timeLimitArr) {
        
        if ([timeDic[@"cKey"] isEqualToString:@"ORDER_MAX_TIME"]) {
            maxTime = [timeDic[@"cValue"] integerValue];
            
        } else {
            minTime = [timeDic[@"cValue"] integerValue];
            
        }
        
    }
    
    if (minTime == 0) {
        
        minTime = 1;
        
    }
    
    NSMutableArray *timeArr = [NSMutableArray array];
    for (NSInteger index = minTime; index <= maxTime; index ++) {
        
        [timeArr addObject:[NSString stringWithFormat:@"%ld小时",index]];
        
    }
    
    self.timeArr = [timeArr mutableCopy];
    
    self.tradeTypeArr = dic[@"tradeType"];
    self.payTypeArr = dic[@"payType"];
    
    NSMutableDictionary *categoryDic = [NSMutableDictionary dictionary];
    NSMutableArray *categoryArr = [NSMutableArray array];
    
    for (NSDictionary *category in dic[@"category"]) {
        
        [categoryDic setValue:category[@"cKey"] forKey:category[@"cValue"]];
        [categoryArr addObject:category[@"cValue"]];
        
    }
    
    self.categoryArr = [categoryArr mutableCopy];
    self.categoryDic = [categoryDic mutableCopy];
    
    ///刷新
    [self reloadUIData];
    
}

#pragma mark----懒加载
- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, BDTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - BDTopHeight- BDBottomHeight - 67)];
        _scrollView.backgroundColor = whiteColor();
        
        
    }
    return _scrollView;
}

- (PublishVoiceView *)voiceView{
    
    if (!_voiceView) {
        _voiceView = [[PublishVoiceView alloc]init];
        
    }
    return _voiceView;
}

- (UITextField *)titleTextF{
    
    if (!_titleTextF) {
        _titleTextF = [[UITextField alloc]init];
        _titleTextF.attributedPlaceholder = [Util mutableStringWithTitle:@"标题  描述发布需求的主要任务" WithString1:@"标题" WithAttrDic1:@{NSFontAttributeName : BlodFont(16)}];
        _titleTextF.font = Font16();
        _titleTextF.textColor = blackColor();
        _titleTextF.tintColor = blackColor();
        
    }
    return _titleTextF;
}

- (UITextView *)contetnText{
    
    if (!_contetnText) {
        _contetnText = [[UITextView alloc]init];
        _contetnText.placeholder = @"描述发布需求的主要内容和要求";
        _contetnText.font= Font15();
        _contetnText.textColor = blackColor();
        _contetnText.tintColor = blackColor();
        
    }
    return _contetnText;
}

- (UIButton *)publishBtn{
    
    if (!_publishBtn) {
        _publishBtn = [[UIButton alloc]init];
        [_publishBtn rounded:4];
        [_publishBtn setBackgroundColor:redColorAlpha()];
//        _publishBtn.enabled = NO;
        [_publishBtn setTitle:@"确认发布" forState:UIControlStateNormal];
        [_publishBtn addTarget:self action:@selector(uploadImageFileRequest) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _publishBtn;
}


#pragma mark---点击事件
- (void)closeAction{
    
    for (BaseViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[NSClassFromString(@"SendTypeOrderVC") class]]) {
            
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }
    
}

- (void)publishOrderLineAction:(PublishOrderLineView *)view{
    
    NSInteger tag = view.tag - 1111;
    
    if (tag == 0) {
        
    } else if (tag == 1) {
        
        [self.view endEditing:YES];
        
        DataPickView *pickView = [[DataPickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        pickView.data = self.categoryArr;
        self.pickView2 = pickView;
        [pickView startAnimation];
        
        
        LRWeakSelf(self);
        pickView.block = ^(NSString *title) {
            
            LRStrongSelf(self);
            self.categoryType = self.categoryDic[title];
            
            PublishOrderLineView *line = [self.middleView viewWithTag:1111 + tag];
            [line setContent:title WithTextColor:blackColor()];
            
            [self.pickView2 hideAnimation];
            
        };
        
    } else if (tag == 2) {
        
        [self.view endEditing:YES];
        
        DataPickView *pickView = [[DataPickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        pickView.data = self.timeArr;
        self.pickView1 = pickView;
        [pickView startAnimation];
        
        
        LRWeakSelf(self);
        pickView.block = ^(NSString *title) {
            
            LRStrongSelf(self);
            self.time = [title stringByReplacingOccurrencesOfString:@"小时" withString:@""];
            PublishOrderLineView *line = [self.middleView viewWithTag:1111 + tag];
            [line setContent:title WithTextColor:blackColor()];
            [self.pickView1 hideAnimation];
        };
        
    }
    
}

- (void)reloadUIData{
    
    self.m1View.data = self.payTypeArr;
    self.m2View.data = self.tradeTypeArr;
    
}

#pragma mark---网络请求
- (void)getOrderWords{
    
    [HttpManagerRequest publishOrderWithWordsWithSuccessBlock:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            [self initWebData:dic[@"data"]];
            
        } else {
            
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

- (void)uploadImageFileRequest{
    
    [HttpManagerRequest uploadOrderAudioWithArr:self.path WithSort:0 WithSuccessBlock:^(id result) {
       
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            [self publistRequest:dic[@"data"]];
            
        } else {
            
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}


///发布接口
- (void)publistRequest:(NSDictionary *)imageDic{
    
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *allKeys = [imageDic allKeys];

    for (NSString *key in allKeys) {

        NSMutableDictionary *imgDic = [NSMutableDictionary dictionary];
        imgDic[@"cType"] = @"AUDIO";
        imgDic[@"nOrder"] = key;
        imgDic[@"cPath"] = imageDic[key];
        [arr addObject:imgDic];

    }

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"mediaListJson"] = [arr modelToJSONString];
    parameter[@"orderType"] = @"COMMON_AUDIO";
    parameter[@"userId"] = [UserModelManager getUserId];
    parameter[@"cTitle"] = self.titleTextF.text;
    parameter[@"cDesc"] = self.contetnText.text;
    parameter[@"cCategory"] = self.categoryType;
    parameter[@"nPrice"] = self.price;
    parameter[@"nLongitude"] = self.nLongitude;
    parameter[@"nLatitude"] = self.nLatitude;
    parameter[@"cPayType"] = self.payType;
    parameter[@"cTradeType"] = self.tradeTyp;
    parameter[@"timeDuration"] = self.time;

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
    
    NSLog(@"%@---%@",self.nLongitude,self.nLatitude);
    
}


@end
