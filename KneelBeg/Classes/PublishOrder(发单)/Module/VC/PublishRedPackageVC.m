//
//  PublishRedPackageVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/21.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "PublishRedPackageVC.h"
#import "RedPackageCell1.h"
#import "RedPageageCell2.h"

@interface PublishRedPackageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL        shouldArrive;
@property (nonatomic, strong) UILabel     *amountLab;
@property (nonatomic, strong) UIButton    *openBtn;
@property (nonatomic, strong) UIView      *bottomView;

@end

static NSString *cellID = @"PublishRedPackageVC";
static NSString *cellID1 = @"PublishRedPackageVC1";
@implementation PublishRedPackageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shouldArrive = YES;
    [self initSubviews];
    // Do any additional setup after loading the view.
}

- (void)initSubviews{
    
    self.navigationItem.title = @"发红包";
    [self.view addSubview:self.tableView];

    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:blackColor() forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = Font14();
    [cancleBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancleBtn];
    
//    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [cancleBtn setImage:[UIImage imageNamed:@"发单更多"] forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    
    [self.bottomView addSubview:self.amountLab];
    [self.bottomView addSubview:self.openBtn];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bottomView).offset(80);
        make.centerX.equalTo(self.bottomView);
        
    }];
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.amountLab.mas_bottom).offset(40);
        make.centerX.equalTo(self.bottomView);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(45);
        
    }];
    
    self.tableView.tableFooterView = self.bottomView;
    
}

#pragma mark---懒加载
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, BDTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - BDTopHeight - BDBottomHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = HexColor(@"f5f5f5");
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 70;
        
        [_tableView registerClass:[RedPackageCell1 class] forCellReuseIdentifier:cellID];
        [_tableView registerClass:[RedPageageCell2 class] forCellReuseIdentifier:cellID1];
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
            
        }
    }
    return _tableView;
}

- (UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        
    }
    return _bottomView;
}

- (UILabel *)amountLab{
    
    if (!_amountLab) {
        _amountLab = [[UILabel alloc]init];
        _amountLab.textColor = blackColor();
        _amountLab.font = BlodFont(12);
        _amountLab.attributedText = [Util mutableStringWithTitle:@"¥8.80" WithString1:@"8.80" WithAttrDic1:@{NSFontAttributeName : BlodFont(36)}];
        
    }
    return _amountLab;
}

- (UIButton *)openBtn{
    
    if (!_openBtn) {
        _openBtn = [[UIButton alloc]init];
        [_openBtn setTitle:@"塞钱进红包" forState:UIControlStateNormal];
        [_openBtn setTitleColor:whiteColor() forState:UIControlStateNormal];
        _openBtn.titleLabel.font = Font15();
        [_openBtn setBackgroundColor:redColor()];
        [_openBtn rounded:8];
        
    }
    return _openBtn;
}

#pragma mark---<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count = 4;
    
    if (self.shouldArrive) {
        count = 5;
        
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 2) {
        
        NSArray *titleArr = @[@"总金额",@"红包个数"];
        NSArray *rightArr = @[@"元",@"个"];
        NSArray *placeArr = @[@"0.00",@"0"];
        
        RedPackageCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        cell.titleS = titleArr[indexPath.row];
        cell.rightS = rightArr[indexPath.row];
        cell.placeHolder = placeArr[indexPath.row];
        
        return cell;
        
    } else {
        
        RedPageageCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellID1 forIndexPath:indexPath];
        NSArray *titleArr = @[@"持续时间",@"是否需要到达目的地",@"领取范围"];
        cell.titleS = titleArr[indexPath.row - 2];
        
        return cell;
        
    }
    
    return nil;
    
}

#pragma mark---点击时间
- (void)closeAction{
    
    for (BaseViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[NSClassFromString(@"SendTypeOrderVC") class]]) {
            
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }
    
}

@end
