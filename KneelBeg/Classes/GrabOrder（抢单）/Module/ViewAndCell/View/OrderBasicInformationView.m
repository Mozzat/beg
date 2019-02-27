//
//  OrderBasicInformationView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/25.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "OrderBasicInformationView.h"

@interface OrderBasicInformationView ()

@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *timeLab;

@end

@implementation OrderBasicInformationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.priceLab];
    [self addSubview:self.timeLab];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(20);

    }];

    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.priceLab.mas_bottom).offset(5);
        make.left.equalTo(self.priceLab);
        
    }];
    
    UILabel *tagLab = [[UILabel alloc]init];
    tagLab.textColor = redColor();
    tagLab.font = Font10();
    tagLab.text = @"限时订单";
    tagLab.backgroundColor = RGBA(231, 68, 103, 0.1);
    tagLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tagLab];
    
    [tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.priceLab);
        make.left.equalTo(self.priceLab.mas_right).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
        
    }];
    
    UILabel *tagLab1 = [[UILabel alloc]init];
    tagLab1.text = @"不议价";
    tagLab1.font = Font10();
    tagLab1.textColor = HexColor(@"9b9b9b");
    tagLab1.backgroundColor = HexColor(@"ebebeb");
    tagLab1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tagLab1];
    
    [tagLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.priceLab);
        make.left.equalTo(tagLab.mas_right).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
        
    }];
    
    
}

#pragma mark----懒加载
- (UILabel *)priceLab{
    
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.textColor = redColor();
        _priceLab.font = Font12();
        _priceLab.attributedText = [Util mutableStringWithTitle:@"¥60.00" WithString1:@"60.00" WithAttrDic1:@{NSFontAttributeName : BlodFont(20)}];
    
    }
    return _priceLab;
}

- (UILabel *)timeLab{
    
    if (!_timeLab ) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = HexColor(@"9b9b9b");
        _timeLab.font = Font12();
        _timeLab.text = @"距离订单结束时间还剩01小时47分28秒";
    }
    return _timeLab;
}


@end
