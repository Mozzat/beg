//
//  PayView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/15.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "PayView.h"

@interface PayView()

@property (nonatomic, strong) UIView  *bottomView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *moneyLay;
@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation PayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.bottomView];
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = whiteColor();
    [self.bottomView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.bottomView);
        make.height.mas_equalTo(56);
        
    }];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"发单关闭"] forState:UIControlStateNormal];
    [topView addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(topView);
        make.left.equalTo(topView).offset(20);
        make.height.width.mas_equalTo(30);
        
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HexColor(@"ebebeb");
    [topView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(topView);
        make.height.mas_equalTo(0.5);
        
    }];
    
    [self.bottomView addSubview:self.moneyLay];
    [self.moneyLay mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView).offset(40);
        make.centerX.equalTo(self.bottomView);
        
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = HexColor(@"ebebeb");
    [self.bottomView addSubview:line1];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.moneyLay);
        make.left.right.equalTo(self.bottomView);
        make.height.mas_equalTo(0.5);
        
    }];
    
    UIImageView *img1 = [[UIImageView alloc]init];
    img1.image = [UIImage imageNamed:@"红包"];
    [self.bottomView addSubview:img1];
    
    [img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line1.mas_bottom).offset(35);
        make.left.equalTo(self.bottomView).offset(80);
        
    }];
    
    UILabel *amountLab = [[UILabel alloc]init];
    amountLab.text = @"红包代扣(22.3元)";
    amountLab.textColor = HexColor(@"9b9b9b");
    amountLab.font = Font15();
    [self.bottomView addSubview:amountLab];
    
    [amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(img1);
        make.left.equalTo(img1.mas_right).offset(10);
        
    }];
    
    UIImageView *img2 = [[UIImageView alloc]init];
    img2.image = [UIImage imageNamed:@"支付宝图标"];
    [self.bottomView addSubview:img2];
    
    [img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(img1.mas_bottom).offset(30);
        make.left.equalTo(self.bottomView).offset(80);
        
    }];
    
    UILabel *amountLab1 = [[UILabel alloc]init];
    amountLab1.text = @"支付包支付";
    amountLab1.textColor = HexColor(@"9b9b9b");
    amountLab1.font = Font15();
    [self.bottomView addSubview:amountLab1];
    
    [amountLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(img2);
        make.left.equalTo(img2.mas_right).offset(10);
        
    }];
    
    UIButton *selctBtn1 = [[UIButton alloc]init];
    [self.bottomView addSubview:selctBtn1];
    
    [selctBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(img2);
        make.right.equalTo(self.bottomView).offset(-80);
        make.width.height.mas_equalTo(30);
        
    }];
    
    UIImageView *img3 = [[UIImageView alloc]init];
    img3.image = [UIImage imageNamed:@"支付宝图标"];
    [self.bottomView addSubview:img3];
    
    [img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(img2.mas_bottom).offset(30);
        make.left.equalTo(self.bottomView).offset(80);
        
    }];
    
    UILabel *amountLab2 = [[UILabel alloc]init];
    amountLab2.text = @"支付包支付";
    amountLab2.textColor = HexColor(@"9b9b9b");
    amountLab2.font = Font15();
    [self.bottomView addSubview:amountLab2];
    
    [amountLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(img3);
        make.left.equalTo(img3.mas_right).offset(10);
        
    }];
    
    UIButton *selctBtn2 = [[UIButton alloc]init];
    [self.bottomView addSubview:selctBtn2];
    
    [selctBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(img2);
        make.right.equalTo(self.bottomView).offset(-80);
        make.width.height.mas_equalTo(30);
        
    }];
    
    UIButton *payBtn = [[UIButton alloc]init];
    [payBtn setTitle:@"认支付4.30元" forState:UIControlStateNormal];
    [payBtn setTitleColor:whiteColor() forState:UIControlStateNormal];
    payBtn.titleLabel.font = Font15();
    payBtn.backgroundColor = redColor();
    [self.bottomView addSubview:payBtn];
    
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bottomView).offset(20);
        make.right.equalTo(self.bottomView).offset(-20);
        make.bottom.equalTo(self.bottomView).offset(-10);
        make.height.mas_equalTo(45);
        
    }];
    
    
}

#pragma mark----懒加载
- (UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 500)];
        _bottomView.backgroundColor = whiteColor();
        
    }
    return _bottomView;
}

- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"订单支付";
        _titleLab.textColor = blackColor();
        _titleLab.font = BlodFont(18);
        
    }
    return _titleLab;
}

- (UILabel *)moneyLay{
    
    if (!_moneyLay) {
        _moneyLay = [[UILabel alloc]init];
        _moneyLay.textColor = blackColor();
        _moneyLay.font = BlodFont(32);
        _moneyLay.text = @"32.00元";
    }
    return _moneyLay;
}

@end
