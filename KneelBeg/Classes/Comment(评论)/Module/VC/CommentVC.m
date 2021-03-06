//
//  CommentVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/11.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "CommentVC.h"
#import "CommentReplyCell.h"
#import "TextFieldInputView.h"
#import <IQKeyboardManager.h>

@interface CommentVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *tableView;

@property (nonatomic, assign) NSInteger      currentPage;

@property (nonatomic, assign) BOOL           isLastPage;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSDictionary   *commitDic;

@property (nonatomic, assign) NSInteger      tapIndex;

@end

static NSString *cellId = @"CommentVC";
@implementation CommentVC

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.tapIndex = 0;
    [self setLocationUI];
    [self getDataCommitRequest];
    [self getCommentById];

    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
}

- (void)setLocationUI{
    
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"评论";
    
    TextFieldInputView *inputView = [[TextFieldInputView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT - BDBottomHeight - 67, SCREEN_WIDTH, 67)];
    
    LRWeakSelf(self);
    inputView.endBlock = ^(NSString * _Nonnull text) {
        LRStrongSelf(self);
        [self writeCommentRequest:text];
        
    };
    [self.view addSubview:inputView];
    
}

- (void)getDataCommitRequest{
    
    [self getReplyCommentData];
    
}

#pragma mark---懒加载
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, BDTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - BDTopHeight - BDBottomHeight - 67) style:UITableViewStyleGrouped];
        _tableView.delegate =  self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = whiteColor();
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.estimatedRowHeight = 137;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[CommentReplyCell class] forCellReuseIdentifier:cellId];
        
    }
    return _tableView;
}

- (NSMutableArray *)data{
    
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

#pragma mark---<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    
    return self.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.lineHide = YES;
    }
    
    if (indexPath.section == 0) {
        
        if (self.commitDic) {
            cell.dataDic = self.commitDic;
        }
        
    } else {
        
        if (indexPath.row < self.data.count) {
            cell.dataDic1 = self.data[indexPath.row];
        }
        
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.01;
    }
    
    return 42;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    return view;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        UIView *view = [[UIView alloc]init];
        return view;
        
    } else {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42)];
        bgView.backgroundColor = whiteColor();
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = HexColor(@"f5f5f5");
        [bgView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.right.equalTo(bgView);
            make.height.mas_equalTo(5);
            
        }];
        
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = @"全部回复";
        titleLab.textColor = blackColor();
        titleLab.font = BlodFont(15);
        [bgView addSubview:titleLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(bgView).offset(20);
            make.bottom.equalTo(bgView).offset(-2);
            
        }];
        
        return bgView;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tapIndex = indexPath.section ;
    
    if (indexPath.section == 0) {
        
    
    } else {
        NSDictionary *dic = self.data[indexPath.row];
        
    }
    
    
    
}

#pragma mark---获取评论➕回复信息
- (void)getReplyCommentData{
    
    [HttpManagerRequest selectByCommentId:self.commitId WithPage:1 WithSuccessBlock:^(id result) {
       
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            NSArray *arr = [Util getJsonArray:dic];
            self.data = [arr mutableCopy];
            
            self.isLastPage = [Util getJsonIsLastPage:dic];
            if (!self.isLastPage) {
                self.currentPage = 2;
            }
            [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

- (void)getMoreReplyCommentData{
    
    if (self.isLastPage) {
        return;
    }
    
    [HttpManagerRequest selectByCommentId:self.commitId WithPage:self.currentPage WithSuccessBlock:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            NSArray *arr = [Util getJsonArray:dic];
            [self.data addObjectsFromArray:arr];
            
            self.isLastPage = [Util getJsonIsLastPage:dic];
            if (!self.isLastPage) {
                self.currentPage ++;
            }
            [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

///根据评论id查询评论
- (void)getCommentById{
    
    [HttpManagerRequest selectByCommentId:self.commitId WithSuccessBlock:^(id result) {
       
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            self.commitDic = dic[@"data"];
            [self.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

#pragma mark---写评论和写回复
- (void)writeCommentRequest:(NSString *)message{
    
    NSInteger type = 1;
    
    if (self.tapIndex == 1) {
        type = 2;
    }
    
    [HttpManagerRequest addReplyCommentDataWithMessage:message WithType:type WithCommentId:self.commitId WithReplayId:0 WithSuccessBlock:^(id result) {
       
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

@end
