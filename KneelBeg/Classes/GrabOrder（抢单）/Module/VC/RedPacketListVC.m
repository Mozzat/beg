//
//  RedPacketListVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/7.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "RedPacketListVC.h"
#import "GrabRedPacketCell.h"
#import "MyRedPacketVC.h"
#import "UIImageView+Load.h"

@interface RedPacketListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UIImageView    *headImageV;
@property (nonatomic, strong) UILabel       *nameLab;
@property (nonatomic, strong) UILabel       *addressLab;
@property (nonatomic, strong) UILabel       *amountLab;
@property (nonatomic, strong) UILabel       *countLab;


@end

static NSString *cellID = @"RedPacketListVC";
@implementation RedPacketListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLocationUI];
    [self getRedPacketRequeset];
    
}

- (void)setLocationUI{
    
    UIButton *myRedPacketBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 75, 20)];
    [myRedPacketBtn setTitle:@"红包记录" forState:UIControlStateNormal];
    [myRedPacketBtn setTitleColor:redColor() forState:UIControlStateNormal];
    myRedPacketBtn.titleLabel.font = Font15();
    [myRedPacketBtn addTarget:self action:@selector(openMyRedPacketAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:myRedPacketBtn];
    
    self.navigationItem.title = @"跪求红包";
    [self.view addSubview:self.tableView];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 135)];
    self.tableView.tableHeaderView = headView;
    
    [self.headImageV rounded:36];
    self.headImageV.backgroundColor = redColor();
    [headView addSubview:self.headImageV];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(headView).offset(20);
        make.left.equalTo(headView).offset(20);
        make.width.height.mas_equalTo(72);
        
    }];
    
    [headView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.headImageV);
        make.right.equalTo(headView).offset(-20);
        
    }];
    
    [headView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headImageV).offset(10);
        make.left.equalTo(self.headImageV.mas_right).offset(15);
        
    }];
    
    [headView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.nameLab.mas_bottom).offset(5);
        make.left.equalTo(self.headImageV.mas_right).offset(15);
        
    }];
    
    [headView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(headView).offset(20);
        make.bottom.equalTo(headView).offset(-5);
        
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HexColor(@"ebebeb");
    [headView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(headView);
        make.height.mas_equalTo(1);
        
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
        _data = [[NSMutableArray alloc]init];
        
    }
    return _data;
}

- (UIImageView *)headImageV{
    
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc]init];
        
    }
    return _headImageV;
}

- (UILabel *)nameLab{
    
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"的洪波啊";
        _nameLab.font = BlodFont(18);
        _nameLab.textColor = blackColor();
        
    }
    return _nameLab;
}

- (UILabel *)addressLab{
    
    if (!_addressLab) {
        _addressLab = [[UILabel alloc]init];
        _addressLab.textColor = HexColor(@"ebebeb");
        _addressLab.font =Font15();
        _addressLab.text = @"到指定地点有抽奖活动";
        
    }
    return _addressLab;
}

- (UILabel *)amountLab{
    
    if (!_amountLab) {
        _amountLab = [[UILabel alloc]init];
        _amountLab.textColor = redColor();
        _amountLab.font =Font16();
        _amountLab.attributedText = [Util mutableStringWithTitle:@"8.60元" WithString1:@"8.60" WithAttrDic1:@{NSFontAttributeName : Font28()}];
        
    }
    return _amountLab;
}

- (UILabel *)countLab{
    
    if (!_countLab) {
        _countLab = [[UILabel alloc]init];
        _countLab.text = @"9个红包，5分钟被抢完";
        _countLab.font = Font12();
        _countLab.textColor = HexColor(@"b9b9b9");
        
    }
    return _countLab;
}

#pragma mark---事件处理
- (void)openMyRedPacketAction{
    
    MyRedPacketVC *myRedPacketVC = [[MyRedPacketVC alloc]init];
    [self.navigationController pushViewController:myRedPacketVC animated:YES];
    
}

#pragma mark---<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GrabRedPacketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (indexPath.row < self.data.count) {
        NSDictionary *dic = self.data[indexPath.item];
        cell.dataDic = dic;
        
        NSString *userId = [NSString stringWithFormat:@"%@",dic[@"userId"]];
        if ([userId isEqualToString:[UserModelManager getUserId]]) {
            self.amountLab.attributedText = [Util mutableStringWithTitle:[NSString stringWithFormat:@"%@元",dic[@"nMoney"]] WithString1:[NSString stringWithFormat:@"%@",dic[@"nMoney"]] WithAttrDic1:@{NSFontAttributeName : Font28()}];
            
        }
    }
    
    return cell;
    
}

#pragma mark---网络请求
- (void)getRedPacketRequeset{
    
    [HttpManagerRequest redPacketListWithORderNo:self.orderNo WithSuccessBlock:^(id result) {
       
        NSDictionary *dic = (NSDictionary *)result;
        if ([[Util getJsonResultState:dic] isEqualToString:successKey]) {
            
            self.data = dic[@"data"][@"record"];
            [self.tableView reloadData];
            
            self.nameLab.text = dic[@"data"][@"title"];
            [self.headImageV loadImageViewWithImageString:dic[@"data"][@"headImage"] WithPlaceHoldeImage:@"默认头像"];
            
            NSInteger totalCount = [dic[@"data"][@"totalAmount"] floatValue];
            
            if (totalCount == self.data.count) {
                
                NSInteger min = [dic[@"data"][@"period"] floatValue];
                self.countLab.text = [NSString stringWithFormat:@"%ld个红包,%ld分钟抢完",totalCount,min/60];
                
            } else {
                self.countLab.text = [NSString stringWithFormat:@"%ld/%ld红包",self.data.count,totalCount];
                
            }
            
            
        }
        
    } WithFailBlock:^(id result) {
        
    }];
    
}

@end
