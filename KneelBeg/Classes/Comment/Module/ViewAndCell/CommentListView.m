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

@end

static NSString *cellId = @"CommentListView";
@implementation CommentListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self initWithSubviews];
        
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

#pragma mark----<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4 ;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    return cell;
    
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

@end
