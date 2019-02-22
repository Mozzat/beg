//
//  PublistWordsOrderVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/20.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "PublistWordsOrderVC.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "PublishOrderLineView.h"
#import "UITextView+Placeholder.h"
#import "PublishShowImageOrVideoView.h"

@interface PublistWordsOrderVC ()

@property (nonatomic, strong) UIScrollView *scrollView;
///标题
@property (nonatomic, strong) UITextField  *titleTextF;
///内容
@property (nonatomic, strong) UITextView   *contetnText;
///展示图片视频
@property (nonatomic, strong) PublishShowImageOrVideoView    *imgView;

@property (nonatomic, strong) UIButton      *publishBtn;



@end

@implementation PublistWordsOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLocationUI];
    
}

- (BOOL)fd_prefersNavigationBarHidden{
 
    return  YES;
    
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
    
    [topView addSubview:self.imgView];
    self.imgView.data = @[@"1",@"1"];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.contetnText.mas_bottom).offset(10);
        make.left.right.equalTo(topView);
        make.height.mas_equalTo(72);
        make.bottom.equalTo(topView).offset(-20);

    }];
    
    UIView *middleView = [[UIView alloc]init];
    middleView.backgroundColor = whiteColor();
    [containView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.left.right.equalTo(containView);
        make.height.mas_equalTo(300);
        make.bottom.equalTo(containView);
        
    }];
    
    NSArray *titleArr = @[@"价格",@"分类",@"时间",@"支付方式",@"交易方式"];
    PublishOrderLineView *lastView = nil;
    for (NSInteger index = 0 ; index < 5; index ++) {
        
        PublishOrderLineType type =  PublishOrderLineTypeInput;
        if (index != 0) {
            type = PublishOrderLineTypeTap;
        }
        
        PublishOrderLineView *lineView = [[PublishOrderLineView alloc]initWithFrame:CGRectMake(0, index * 60, SCREEN_WIDTH, 60) WithType:type];
        [lineView setTitles:titleArr[index]];
        [middleView addSubview:lineView];
        lastView = lineView;
        
        if (index == 1) {
            [lineView setContent:@"跑腿" WithTextColor:blackColor()];
        }
        
    }
    
    [self.view addSubview:self.publishBtn];
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view).offset( -BDBottomHeight - 11);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(45);
        
    }];
    
}

#pragma mark----懒加载
- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, BDTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - BDTopHeight- BDBottomHeight - 67)];
        _scrollView.backgroundColor = whiteColor();
        
        
    }
    return _scrollView;
}

- (PublishShowImageOrVideoView *)imgView{
    
    if (!_imgView) {
        _imgView = [[PublishShowImageOrVideoView alloc]init];
        _imgView.backgroundColor = whiteColor();
        
    }
    return _imgView;
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
        _publishBtn.enabled = NO;
        [_publishBtn setTitle:@"确认发布" forState:UIControlStateNormal];
        
    }
    return _publishBtn;
}

- (void)closeAction{
    
    for (BaseViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[NSClassFromString(@"SendTypeOrderVC") class]]) {
            
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }
    
}

@end
