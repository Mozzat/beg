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

@property (nonatomic, strong) UITableView   *tableView;

@end

static NSString *cellId = @"CommentVC";
@implementation CommentVC

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self setLocationUI];
    
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
    [self.view addSubview:inputView];
    
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

#pragma mark---<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.lineHide = YES;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return nil;
        
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

@end
