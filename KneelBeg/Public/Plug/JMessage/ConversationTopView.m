//
//  ConversationTopView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/13.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "ConversationTopView.h"

@interface ConversationTopView()

@property (nonatomic, strong) UIButton  *headImageV;
@property (nonatomic, strong) UILabel   *moneyLab;
@property (nonatomic, strong) UILabel   *timeLab;

@end

@implementation ConversationTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.headImageV];
        [self.headImageV rounded:24];
        [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(20);
            make.width.height.mas_equalTo(48);
            
        }];
        
        [self addSubview:self.moneyLab];
        [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.headImageV.mas_top).offset(5);
            make.left.equalTo(self.headImageV.mas_right).offset(10);
            
        }];
        
        [self addSubview:self.timeLab];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.moneyLab.mas_bottom).offset(5);
            make.left.equalTo(self.headImageV.mas_right).offset(10);
            
        }];
        
    }
    return self;
}

#pragma mark----懒加载
- (UIButton *)headImageV{
    
    if (!_headImageV) {
        _headImageV = [[UIButton alloc]init];
        [_headImageV setBackgroundImage:[UIImage imageNamed:@"美女头像.jpg"] forState:UIControlStateNormal];
        
    }
    return _headImageV;
}

- (UILabel *)moneyLab{
    
    if (!_moneyLab) {
        
        _moneyLab = [[UILabel alloc]init];
        _moneyLab.text = @"¥ 65.00";
        _moneyLab.font = Font16();
        _moneyLab.textColor = redColor();
        
    }
    return _moneyLab;
}

- (UILabel *)timeLab{
    
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = HexColor(@"9b9b9b");
        _timeLab.font = Font12();
        _timeLab.text = @"距离结束01:46:28";
    }
    return _timeLab;
}

@end
