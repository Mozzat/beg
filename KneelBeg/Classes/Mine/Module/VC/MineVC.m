//
//  MineVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/5.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "MineVC.h"
#import "Login.h"
#import "MIneCell.h"
#import "MIneHeadVIew.h"
#import "OrderProgressingVC.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *titleData;
@property (nonatomic, strong) MIneHeadVIew *headView;

@end

static NSString *cellId = @"MineVC";
@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%f====BDStatusBarHeight",BDStatusBarHeight);
    self.titleData = @[@"我的发单",@"我的抢单",@"我的红包",@"设置",@"实名认证",@"商务合作"];
    [self setLocationUI];
    
}

- (void)setLocationUI{
    
    self.navigationItem.title = @"Alice";
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark--懒加载
-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, BDTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - BDTopHeight - BDTabBarHeight) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 62;
        [_tableView registerClass:[MIneCell class] forCellReuseIdentifier:cellId];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;;
        _tableView.tableHeaderView = self.headView;
        
    }
    
    return _tableView;
    
}

- (MIneHeadVIew *)headView{
    
    if (!_headView) {
        _headView = [[MIneHeadVIew alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 112)];
        
        LRWeakSelf(self);
        _headView.block = ^{
            
            LRStrongSelf(self);
            [self loginAction];
            
        };
        
    }
    return _headView;
}


- (void)loginAction{
    
    Login *login = [[Login alloc]init];
    [self.navigationController presentViewController:login animated:YES completion:^{
        
    }];
    
}

#pragma mar---<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MIneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.row < self.titleData.count) {
        cell.titleS = self.titleData[indexPath.row];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderProgressingVC *progress = [[OrderProgressingVC alloc]init];
    progress.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:progress animated:YES];
    
}

@end
