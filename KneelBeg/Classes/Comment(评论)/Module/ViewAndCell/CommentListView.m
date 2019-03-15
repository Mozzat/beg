//
//  CommentListView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/11.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "CommentListView.h"
#import "CommentCell.h"

@interface CommentListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView        *bottomView;
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, weak)   UILabel       *topLab;

///属性
@property (nonatomic, assign) NSInteger     currentPage;
@property (nonatomic, assign) BOOL          isLastPage;

@end

static NSString *cellId = @"CommentListView";
@implementation CommentListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self initWithSubviews];
        self.currentPage = 1;
        
    }
    return self;
}

- (void)initWithSubviews{
    
    [self addSubview:self.bottomView];
    
    UILabel *topView = [[UILabel alloc]init];
    topView.userInteractionEnabled = YES;
    [self.bottomView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self.bottomView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(54);
        
    }];
    
    UILabel *topLab = [[UILabel alloc]init];
    topLab.font = BlodFont(18);
    topLab.text = @"共43条评论";
    topLab.textColor = blackColor();
    self.topLab = topLab;
    [topView addSubview:topLab];
    
    [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(topView);
        
    }];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"发单关闭"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction1) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.userInteractionEnabled = YES;
    [topView addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(topView);
        make.right.equalTo(topView).offset(-20);
        make.width.height.mas_equalTo(20);
        
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HexColor(@"ebebeb");
    [topView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(topView);
        make.height.mas_equalTo(1);
        
    }];
    
    [self.bottomView addSubview:self.tableView];
    
}

#pragma mark---懒加载
- (UIView *)bottomView{
    
    if (!_bottomView ) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT , SCREEN_WIDTH, 500)];
        _bottomView.backgroundColor = whiteColor();
        
    }
    return _bottomView;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 54, SCREEN_WIDTH, self.bottomView.height - 54) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = whiteColor();
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[CommentCell class] forCellReuseIdentifier:cellId];
        
        
    }
    return _tableView;
}

- (NSMutableArray *)data{
    
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (void)setOrderNo:(NSString *)orderNo{
    
    _orderNo = orderNo;
    
    [self getCommentListData];
    
}

- (void)setTotalCount:(NSInteger)totalCount{
    
    _totalCount = totalCount;
    self.topLab.text = [NSString stringWithFormat:@"共%ld条评论",self.totalCount];
    
}

#pragma mark----<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count ;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.data[indexPath.row];
    
    if (self.tapClick) {
        self.tapClick(dic);
    }
    
}

- (void)startAnimation{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.bottomView.y = SCREENH_HEIGHT - 500;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)hideAnimation{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.bottomView.y = SCREENH_HEIGHT;
        
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
        
    }];
    
}

- (void)closeAction1{
    
    
    [self hideAnimation];
    
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
            self.data = [data mutableCopy];
            [self.tableView reloadData];
            
            self.isLastPage = [Util getJsonIsLastPage:dic];
            if (!self.isLastPage) {
                self.currentPage = 2;
            }
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}


///查询评论列表接口
- (void)getMoreCommentListData{
    
    if (self.currentPage) {
        return;
    }
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"value"] = self.orderNo;
    parameter[@"pageNum"] = @"1";
    
    [HttpManagerRequest getCommentListData:parameter WithSuccessBlock:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            NSArray *data = [Util getJsonArray:dic];
            [self.data addObjectsFromArray:data];
            
            self.isLastPage = [Util getJsonIsLastPage:dic];
            
            if (!self.isLastPage) {
                self.currentPage ++;
            }
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}



@end
