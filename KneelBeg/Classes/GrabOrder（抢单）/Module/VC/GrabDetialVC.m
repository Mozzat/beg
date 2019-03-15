//
//  GrabDetialVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/25.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "GrabDetialVC.h"
#import "FoucuesView.h"
#import "MZTScrollVIewSlider.h"
#import "OrderShareVIew.h"
#import "OrderBasicInformationView.h"
#import "OrderDetialContentView.h"
#import "OrderShareVIew.h"
#import "GrabOrderCommentView.h"
#import "UIButton+ImageTitleSpacing.h"
//#import "CTMediator+ChatViewController.h"
//#import "ChatViewController.h"
#import "ConversationViewController.h"
#import <IQKeyboardManager.h>
#import <JMessage/JMessage.h>
#import "CommentListView.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "OrderDetialWriteCommentView.h"
#import "ConversationVC.h"
#import "CTMediator+Comment.h"

@interface GrabDetialVC ()

@property (nonatomic, strong) FoucuesView               *focuesView;
@property (nonatomic, strong) MZTScrollVIewSlider       *sliderScrollView;
@property (nonatomic, strong) OrderBasicInformationView *basicInformtionView;
@property (nonatomic, strong) OrderDetialContentView    *contentView;
@property (nonatomic, strong) OrderShareVIew            *shareView;
@property (nonatomic, strong) GrabOrderCommentView      *commentView;
@property (nonatomic, strong) UIView                    *bottomView;
@property (nonatomic, strong) CommentListView           *commentListView;
@property (nonatomic, strong) OrderDetialWriteCommentView *writeCommentView;

///属性
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) NSArray      *linkArr;
@property (nonatomic, strong) NSDictionary *order;

@end

@implementation GrabDetialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLocationUI];
    
    [self getRequestAction];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
//    self.sliderScrollView.data = @[@"http://p1.img.cctvpic.com/cportal/img/2019/2/25/1551109029441_938_792x670.jpg",@"http://t11.baidu.com/it/u=538889017,157038003&fm=173&app=49&f=JPEG?w=640&h=725&s=A50042F9648B7AFCCC11C11F030090C2"];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
}

- (BOOL)fd_prefersNavigationBarHidden{
    
    return YES;
    
}

- (void)setLocationUI{
    
    self.navigationItem.title = @"抢单详情";
    
    UIView *navitationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BDTopHeight)];
    navitationView.backgroundColor = whiteColor();
    [self.view addSubview:navitationView];
    
    UILabel *navigationTitle = [[UILabel alloc]init];
    navigationTitle.textColor = blackColor();
    navigationTitle.font = BlodFont(18);
    navigationTitle.text = @"抢单详情";
    [navitationView addSubview:navigationTitle];
    
    [navigationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(navitationView).offset(BDStatusBarHeight);
        make.centerX.equalTo(navitationView);
        make.bottom.equalTo(navitationView);
        
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, BDStatusBarHeight, 44, 44);
    [backButton setImage:[UIImage imageNamed:@"评论页面-返回"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(closeCurrentVC) forControlEvents:UIControlEventTouchUpInside];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [navitationView addSubview:backButton];
    
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setImage:[UIImage imageNamed:@"发单更多"] forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [navitationView addSubview:rightBtn];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(navitationView);
        make.right.equalTo(navitationView).offset(-20);
        make.width.height.mas_equalTo(44);
        
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, BDTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - BDTopHeight - BDBottomHeight - 50)];
    scrollView.backgroundColor = whiteColor();
    [self.view addSubview:scrollView];
    
    UIView *contentView = [[UIView alloc]init];
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.equalTo(scrollView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        
    }];
    
    [contentView addSubview:self.focuesView];
    [self.focuesView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(contentView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(80);
        
    }];
    
    [contentView addSubview:self.sliderScrollView];
    [self.sliderScrollView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.focuesView.mas_bottom);
        make.left.equalTo(contentView);
        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(300);

    }];

    [contentView addSubview:self.basicInformtionView];
    [self.basicInformtionView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.sliderScrollView.mas_bottom).offset(10);
        make.left.equalTo(contentView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(70);

    }];

    [contentView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.basicInformtionView.mas_bottom).offset(10);
        make.left.equalTo(contentView);
        make.width.mas_equalTo(SCREEN_WIDTH);

    }];

    [contentView addSubview:self.shareView];
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(contentView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);

    }];

    [contentView addSubview:self.commentView];
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.shareView.mas_bottom);
        make.left.left.equalTo(contentView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(contentView);

    }];
    
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.commentListView];
    self.commentListView.hidden = YES;
    
    [self.view addSubview:self.writeCommentView];
    self.writeCommentView.hidden = YES;
    
}

- (void)getRequestAction{
    
    ///数据查询
    [self getOrderDetialData];
    [self getCommentListData];
    [self getCommentTotalCountRequest];
    
}

#pragma mark---懒加载
- (FoucuesView *)focuesView{
    
    if (!_focuesView) {
        _focuesView = [[FoucuesView alloc]init];
    }
    return _focuesView;
}

- (MZTScrollVIewSlider *)sliderScrollView{
    
    if (!_sliderScrollView) {
        _sliderScrollView = [[MZTScrollVIewSlider alloc]init];
        
    }
    return _sliderScrollView;
}

- (OrderBasicInformationView *)basicInformtionView{
    
    if (!_basicInformtionView) {
        _basicInformtionView = [[OrderBasicInformationView alloc]init];
        
    }
    return _basicInformtionView;
}

- (OrderDetialContentView *)contentView{
    
    if (!_contentView) {
        _contentView = [[OrderDetialContentView alloc]init];
    }
    return _contentView;
}

- (GrabOrderCommentView *)commentView{
    
    if (!_commentView) {
        _commentView = [[GrabOrderCommentView alloc]init];
        
        LRWeakSelf(self);
        _commentView.writeAction = ^{
          
            LRStrongSelf(self);
            [self.writeCommentView showAnimation];
            
        };
    }
    
    return _commentView;
}

-(OrderShareVIew *)shareView{
    
    if (!_shareView) {
        _shareView = [[OrderShareVIew alloc]init];
        
        LRWeakSelf(self);
        _shareView.commentBlock = ^{
            
            LRStrongSelf(self);
            self.commentListView.hidden = NO;
            self.commentListView.orderNo = self.orderNo;
            [self.commentListView startAnimation];
            
        };
        
    }
    return _shareView;
}

- (CommentListView *)commentListView{
    
    if (!_commentListView ) {
        
        _commentListView = [[CommentListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        
        LRWeakSelf(self);
        _commentListView.tapClick = ^(NSDictionary *dic) {
          
            LRStrongSelf(self);
            [self.commentListView hideAnimation];
            UIViewController *vc = [[CTMediator sharedInstance] commentVCMediatorWithParame:@{@"commitId":dic[@"id"]}];
            [self.navigationController pushViewController:vc animated:YES];
            
        };
        
    }
    return _commentListView;
}

- (OrderDetialWriteCommentView *)writeCommentView{
    
    if (!_writeCommentView) {
        _writeCommentView = [[OrderDetialWriteCommentView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        
        LRWeakSelf(self);
        _writeCommentView.writeBlock = ^(NSString *message) {
            LRStrongSelf(self);
            [self writeCommentRequest:message];
            
        };
        
    }
    return _writeCommentView;
}

- (UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT  - BDBottomHeight - 50, SCREEN_WIDTH, 50)];
        _bottomView.backgroundColor = whiteColor();
        [_bottomView shadow:HexColor(@"f5f5f5") opacity:1 radius:2 offset:CGSizeMake(0, -1)];
        
        UIButton *consultBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3.0, self.bottomView.height)];
        [consultBtn setImage:[UIImage imageNamed:@"发单咨询"] forState:UIControlStateNormal];
        [consultBtn setTitle:@"咨询" forState:UIControlStateNormal];
        [consultBtn setTitleColor:blackColor() forState:UIControlStateNormal];
        consultBtn.titleLabel.font = Font16();
        [consultBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
        [consultBtn addTarget:self action:@selector(pushChatView) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:consultBtn];
        
        UIButton *callBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3.0, 0, SCREEN_WIDTH/3.0, _bottomView.height)];
        callBtn.backgroundColor = HexColor(@"FDEAED");
        [callBtn setImage:[UIImage imageNamed:@"发单打电话"] forState:UIControlStateNormal];
        [callBtn setTitle:@"打电话" forState:UIControlStateNormal];
        [callBtn setTitleColor:redColor() forState:UIControlStateNormal];
        callBtn.titleLabel.font = Font16();
        [callBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
        [_bottomView addSubview:callBtn];
        
        UIButton *grabBtn = [[UIButton alloc]initWithFrame:CGRectMake(2 * SCREEN_WIDTH/3.0, 0, SCREEN_WIDTH/3.0, _bottomView.height)];
        [grabBtn setTitle:@"立即抢单" forState:UIControlStateNormal];
        [grabBtn setTitleColor:whiteColor() forState:UIControlStateNormal];
        grabBtn.backgroundColor = redColor();
        grabBtn.titleLabel.font = Font16();
        [grabBtn addTarget:self action:@selector(grabOrderAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:grabBtn];
        
    }
    return _bottomView;
}

#pragma mark----点击事件
- (void)pushChatView{
    
//    UIViewController *vc = [[CTMediator sharedInstance] chatViewControllerMediatorWithParame:@{}];
//    [self.navigationController pushViewController:vc animated:YES];
    
//    ChatViewController *chat = [[ChatViewController alloc]init];
//    [self.navigationController pushViewController:chat animated:YES];
    
//      ConversationViewController *chat = [[ConversationViewController alloc]init];
//      [self.navigationController pushViewController:chat animated:YES];
    
    [JMSGUser loginWithUsername:@"tao1" password:@"tao1" completionHandler:^(id resultObject, NSError *error) {
        
        [self getSingleConversation];
        
    }];
    
}

- (void)getSingleConversation {
    JMSGConversation *conversation = [JMSGConversation singleConversationWithUsername:@"username1"];
    if (conversation == nil) {
        
        [JMSGConversation createSingleConversationWithUsername:@"username1" completionHandler:^(id resultObject, NSError *error) {
            if (error) {
                NSLog(@"创建会话失败");
                return ;
            }
            
            ConversationViewController *conversationVC = [[ConversationViewController alloc] init];
            conversationVC.conversation = resultObject;
            [self.navigationController pushViewController:conversationVC animated:YES];
            
        }];
    } else {
        ConversationViewController *conversationVC = [[ConversationViewController alloc] init];
        conversationVC.conversation = conversation;
        [self.navigationController pushViewController:conversationVC animated:YES];
    }
}

- (void)reloadUIData{
    
    NSInteger startTime = [self.order[@"dDate"] integerValue];
    NSString *timeStr = [Util timeBeforeInfoWithString:startTime];
    self.focuesView.addressStr = [NSString stringWithFormat:@"%@发布于%@",timeStr,self.order[@"cLocationIntro"]];
    self.focuesView.dataDic = self.userInfo;
    
    self.sliderScrollView.data = self.linkArr;
    self.basicInformtionView.dataDic = self.order;
    self.shareView.nForward = [NSString stringWithFormat:@"%@",self.order[@"nForward"]];
    self.shareView.nCollect = [NSString stringWithFormat:@"%@",self.order[@"nCollect"]];
    self.contentView.dataDic = self.order;
    
}

#pragma mark---网络请求
///查询评论列表接口
- (void)getCommentListData{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"value"] = self.orderNo;
    parameter[@"pageNum"] = @"1";
    
    [HttpManagerRequest getCommentListData:parameter WithSuccessBlock:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            NSArray *data = [Util getJsonArray:dic];
            self.commentView.data = data;
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

///写评论
- (void)writeCommentRequest:(NSString *)message{
    
    
    if ([Util isBlankString:message]) {
        
        [JKRemindView showReminderString:@"评论不能为空"];
        return;
    }
    
    [self.writeCommentView hideAnimation];
    
    [HttpManagerRequest addCommentDataWithOrderNo:self.orderNo WithMessage:message WithSuccessBlock:^(id result) {
       
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
         
            [JKRemindView showReminderString:@"添加评论成功"];
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

- (void)getCommentTotalCountRequest{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"value"] = self.orderNo;
    [HttpManagerRequest getCommentCount:parameter WithSuccessBlock:^(id result) {
       
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            self.totalCount = [dic[@"data"] integerValue];
            self.commentListView.totalCount = self.totalCount;
            self.shareView.nMsgCount = @(self.totalCount).stringValue;
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

///查询订单详情
- (void)getOrderDetialData{
    
    [HttpManagerRequest getCommentOrderDataWithOrderNo:self.orderNo WithSuccessBlock:^(id result) {
       
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            self.userInfo = dic[@"data"][@"userInfo"];
            NSDictionary *orderMedia = dic[@"data"][@"orderMedia"];
            self.order      = dic[@"data"][@"order"];
            
            NSMutableArray *imageArr = [NSMutableArray array];
            for (NSDictionary *imageDic in orderMedia) {
                NSString *image = imageDic[@"cPath"];
                [imageArr addObject:image];
            }
            self.linkArr = [imageArr mutableCopy];
            [self reloadUIData];
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
}

///抢单
- (void)grabOrderAction{
    
    if (![UserModelManager userIsLogin]) {
        
        return;
        
    }
    
    [HttpManagerRequest acceptOrderWithOrderNo:self.orderNo WithSuccessBlock:^(id result) {
       
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

@end
