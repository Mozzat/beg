//
//  MyRedPacketVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/8.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "MyRedPacketVC.h"
#import "GrabRedPacketCell.h"

@interface MyRedPacketVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UILabel       *currentMoneyLab;
@property (nonatomic, strong) UILabel       *allMoneyLab;
@property (nonatomic, strong) NSMutableArray *data;

@end

static NSString *cellID = @"MyRedPacketVC";
@implementation MyRedPacketVC

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setLocationUI];
    
    ///获取红包信息
    [self getMyRedPacketRequest];
    
}

- (void)setLocationUI{
    
    self.navigationItem.title = @"我的红包";
    [self.view addSubview:self.tableView];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    headView.backgroundColor = whiteColor();
    self.tableView.tableHeaderView = headView;
    
    UIImageView *bgImageV = [[UIImageView alloc]init];
    bgImageV.contentMode = UIViewContentModeCenter;
    bgImageV.image = [UIImage imageNamed:@"红包金额背景"];
    [headView addSubview:bgImageV];
    
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(headView);
        make.height.mas_equalTo(150);
        
    }];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"当前可用(元)";
    titleLab.font = Font15();
    titleLab.textColor = whiteColor();
    [headView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(headView).offset(20);
        make.centerX.equalTo(headView);
        
    }];
    
    [headView addSubview:self.currentMoneyLab];
    [self.currentMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleLab.mas_bottom).offset(10);
        make.centerX.equalTo(headView);
        
    }];
    
    [headView addSubview:self.allMoneyLab];
    [self.allMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.currentMoneyLab.mas_bottom).offset(5);
        make.centerX.equalTo(headView);
        
    }];
    
    UILabel *bottomLab = [[UILabel alloc]init];
    bottomLab.textColor = blackColor();
    bottomLab.font = Font15();
    bottomLab.text = @"领取记录";
    [headView addSubview:bottomLab];
    
    [bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(headView).offset(20);
        make.bottom.equalTo(headView);
        
    }];
    
}

#pragma mark----懒加载
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, BDTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - BDTopHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 80;
        
        [_tableView registerClass:[GrabRedPacketCell class] forCellReuseIdentifier:cellID];
        
    }
    return _tableView;
}

- (NSMutableArray *)data{
    
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (UILabel *)currentMoneyLab{
    
    if (!_currentMoneyLab) {
        _currentMoneyLab = [[UILabel alloc]init];
        _currentMoneyLab.text = @"23.28";
        _currentMoneyLab.textColor = whiteColor();
        _currentMoneyLab.font = BlodFont(48);
        
    }
    return _currentMoneyLab;
}

- (UILabel *)allMoneyLab{
    
    if (!_allMoneyLab) {
        _allMoneyLab = [[UILabel alloc]init];
        _allMoneyLab.textColor = RGBA(255, 255, 255, 0.8);
        _allMoneyLab.font = Font12();
        _allMoneyLab.attributedText = [Util mutableStringWithTitle:@"红包总额40.24元" WithString1:@"40.24" WithAttrDic1:@{NSFontAttributeName : Font14(),NSForegroundColorAttributeName : whiteColor()}];
        
    }
    return _allMoneyLab;
}

#pragma mark---<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GrabRedPacketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (indexPath.row < self.data.count) {
        cell.dataDic = self.data[indexPath.item];
    }
    
    return cell;
    
}

#pragma mark---网络请求
///获取我的红包列表
- (void)getMyRedPacketRequest{
    
    [HttpManagerRequest getMyRedPacketListWithSuccessBlock:^(id result) {
       
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            self.data = dic[@"data"];
            [self.tableView reloadData];
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}


@end
