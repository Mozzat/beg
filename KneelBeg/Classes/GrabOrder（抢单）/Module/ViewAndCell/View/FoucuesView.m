//
//  FoucuesView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/25.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "FoucuesView.h"
#import "UIImageView+Load.h"

@interface FoucuesView ()

@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UILabel     *titleLab;
@property (nonatomic, strong) UILabel     *levelLab;
@property (nonatomic, strong) UILabel     *contentLab;
@property (nonatomic, strong) UIButton    *focuesBtn;

@end

@implementation FoucuesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = whiteColor();
        [self initSubviews];
        
    }
    return self;
}

#pragma mark---懒加载
- (void)initSubviews{
    
    [self addSubview:self.headImageV];
    [self addSubview:self.titleLab];
    [self addSubview:self.levelLab];
    [self addSubview:self.contentLab];
    [self addSubview:self.focuesBtn];
    
    [self.headImageV rounded:24];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.width.height.mas_equalTo(48);
        
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headImageV).offset(5);
        make.left.equalTo(self.headImageV.mas_right).offset(10);
        make.width.mas_lessThanOrEqualTo(150);
        
    }];
    
    [self.levelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.titleLab);
        make.left.equalTo(self.titleLab.mas_right).offset(5);
        
    }];
    
    [self.focuesBtn rounded:15 width:1 color:redColor()];
    [self.focuesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.headImageV);
        make.right.equalTo(self).offset(-20);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(30);
        
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_bottom).offset(5);
        make.left.equalTo(self.titleLab);
        make.right.mas_lessThanOrEqualTo(self.focuesBtn.mas_left).offset(-10);
        
    }];
    
}

#pragma mark---懒加载
- (UIImageView *)headImageV{
    
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc]init];
        
    }
    return _headImageV;
}

- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = blackColor();
        _titleLab.font = BlodFont(16);
        _titleLab.text = @"莉姆露露";
        
    }
    return _titleLab;
}

- (UILabel *)levelLab{
    
    if (!_levelLab) {
        _levelLab = [[UILabel alloc]init];
        _levelLab.textColor = GoldColor();
        _levelLab.font = Font12();
        _levelLab.text = @"LV.1";
        
    }
    return _levelLab;
}

- (UILabel *)contentLab{
    
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = HexColor(@"9b9b9b");
        _contentLab.text = @"10分钟前发布于上海 黄浦区";
        _contentLab.font = Font12();
        _contentLab.numberOfLines = 2;
        
    }
    return _contentLab;
}

- (UIButton *)focuesBtn{
    
    if (!_focuesBtn) {
        _focuesBtn = [[UIButton alloc]init];
        [_focuesBtn setTitle:@"+关注" forState:UIControlStateNormal];
        [_focuesBtn setTitleColor:redColor() forState:UIControlStateNormal];
        _focuesBtn.titleLabel.font = Font14();
        
    }
    
    return _focuesBtn;
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _dataDic = dataDic;
    [self.headImageV loadImageViewWithImageString:dataDic[@"cHeadImage"] WithPlaceHoldeImage:@"默认头像"];
    self.titleLab.text = dataDic[@"cName"];
    self.contentLab.text = self.addressStr;
    
    
}

@end
