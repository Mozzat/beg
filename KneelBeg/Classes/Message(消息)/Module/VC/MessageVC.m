//
//  MessageVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/14.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "MessageVC.h"
#import "MessageTradView.h"
#import "MessageOrderView.h"
#import "MessageSystemView.h"
#import "MessageUserVIew.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "MessageBtn.h"

@interface MessageVC ()

@property (nonatomic, strong)  UIView              *topView;
@property (nonatomic, strong)  UIScrollView        *scrollView;
///
@property (nonatomic, strong)  MessageOrderView    *orderView;
@property (nonatomic, strong)  MessageTradView     *tradeView;
@property (nonatomic, strong)  MessageSystemView   *systemView;
@property (nonatomic, strong)  MessageUserVIew     *userView;
@property (nonatomic, strong)  UIView              *bottomView;

@property (nonatomic, weak)    UIButton            *editBtn;
@property (nonatomic, weak)    UIButton            *sureBtn;

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLocationUI];
    
}

- (void)setLocationUI{
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.orderView];
    [self.scrollView addSubview:self.tradeView];
    [self.scrollView addSubview:self.systemView];
    [self.scrollView addSubview:self.userView];
    
    UIButton *editBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, BDStatusBarHeight + 16, 40, 30)];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"全选" forState:UIControlStateSelected];
    [editBtn setTitleColor:redColor() forState:UIControlStateSelected];
    [editBtn setTitleColor:redColor() forState:UIControlStateNormal];
    editBtn.titleLabel.font = Font16();
    editBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.editBtn = editBtn;
    [editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:editBtn];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake( SCREEN_WIDTH - 30 - 36, BDStatusBarHeight + 16, 40, 30)];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sureBtn setTitleColor:redColor() forState:UIControlStateNormal];
    sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    sureBtn.titleLabel.font = Font16();
    sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    sureBtn.hidden = YES;
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.sureBtn = sureBtn;
    [self.topView addSubview:sureBtn];
    
    CGFloat marginX = 30;
    CGFloat width = (SCREEN_WIDTH - marginX)/4.0;
    NSArray *titleArr = @[@"订单消息",@"交易信息",@"系统消息",@"互动消息"];
    
    for (NSInteger index = 0 ; index < 4; index ++) {
        
        MessageBtn *btn = [[MessageBtn alloc]initWithFrame:CGRectMake(marginX + index *width, BDStatusBarHeight + 54, width, 30)];
        [btn setTitleColor:blackColor() forState:UIControlStateSelected];
        [btn setTitleColor:HexColor(@"b9b9b9") forState:UIControlStateNormal];
        btn.titleLabel.font = BlodFont(16);
        [btn setTitle:titleArr[index] forState:UIControlStateNormal];
        [btn setTitle:titleArr[index] forState:UIControlStateSelected];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.topView addSubview:btn];
        
        if (index == 0) {
            btn.selected = YES;
        }
        
    }
    
    [self.view addSubview:self.bottomView];
    self.bottomView.hidden = YES;
    
    UIButton *allReadBtn = [[UIButton alloc]init];
    [allReadBtn setTitle:@"标记已读" forState:UIControlStateNormal];
    [allReadBtn setTitleColor:redColor() forState:UIControlStateNormal];
    allReadBtn.titleLabel.font = Font16();
    allReadBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.bottomView addSubview:allReadBtn];
    
    [allReadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.bottomView);
        make.left.equalTo(self.bottomView).offset(30);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(25);
        
    }];
    
    UIButton *delBtn = [[UIButton alloc]init];
    [delBtn setTitleColor:redColor() forState:UIControlStateNormal];
    [delBtn setTitle:@"删除" forState:UIControlStateNormal];
    delBtn.titleLabel.font = Font16();
    delBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.bottomView addSubview:delBtn];
    
    [delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView).offset(-30);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(25);
    }];
    
}

#pragma mark---懒加载
- (UIView *)topView{
 
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90 + BDStatusBarHeight)];
        _topView.backgroundColor = whiteColor();
        
    }
    return _topView;
}

- (UIScrollView *)scrollView{
 
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.topView.bottom, SCREEN_WIDTH, SCREENH_HEIGHT - self.topView.height- BDTabBarHeight)];
        _scrollView.backgroundColor = whiteColor();
        _scrollView.contentSize = CGSizeMake(4 * SCREEN_WIDTH, self.scrollView.height);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (MessageOrderView *)orderView{
 
    if (!_orderView) {
        _orderView = [[MessageOrderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.height) WithType:BaseMessageViewTypeOrder];
        
    }
    return _orderView;
}

- (MessageTradView *)tradeView{
    
    if (!_tradeView) {
        _tradeView = [[MessageTradView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.height) WithType:BaseMessageViewTypeTrad];
        
    }
    return _tradeView;
    
}


- (MessageSystemView *)systemView{
    
    if (!_systemView) {
        _systemView = [[MessageSystemView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, self.scrollView.height) WithType:BaseMessageViewTypeSystem];
    }
    return _systemView;
}

- (MessageUserVIew *)userView{
 
    if (!_userView) {
        _userView = [[MessageUserVIew alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 3, 0, SCREEN_WIDTH, self.scrollView.height) WithType:BaseMessageViewTypeUser];
    }
    return _userView;
}

- (UIView *)bottomView{
 
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.scrollView.bottom - 67, SCREEN_WIDTH, 67)];
        _bottomView.backgroundColor = HexColor(@"fafafa");
    }
    return  _bottomView;
}
    
    

- (BOOL)fd_prefersNavigationBarHidden{
 
    return YES;
    
}

#pragma mark---点击事件
- (void)editAction:(UIButton *)btn{
    
    if (btn.selected) {
        
        
    } else {
        btn.selected = YES;
        self.sureBtn.hidden = NO;
        self.bottomView.hidden = NO;
        self.orderView.isEdit = YES;
        
    }
    
}

- (void)sureBtnAction{
    
    self.editBtn.selected = NO;
    self.bottomView.hidden = YES;
    self.sureBtn.hidden = YES;
    self.orderView.isEdit = NO;
    
}

@end
