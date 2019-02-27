//
//  UIShareButton.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/25.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "UIShareButton.h"

@interface UIShareButton ()

@property (nonatomic, strong) UIImageView *leftImageV;
@property (nonatomic, strong) UILabel     *rightLab;

@end

@implementation UIShareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.leftImageV];
    [self addSubview:self.rightLab];
    
    [self.leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self);
        
    }];
    
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.leftImageV.mas_top);
        make.left.equalTo(self.leftImageV.mas_right).offset(3);
        make.right.equalTo(self);
        
    }];
    
}

#pragma mark---懒加载
- (UIImageView *)leftImageV{
    
    if (!_leftImageV) {
        _leftImageV = [[UIImageView alloc]init];
        
    }
    return _leftImageV;
}

- (UILabel *)rightLab{
    
    if (!_rightLab) {
        _rightLab = [[UILabel alloc]init];
        _rightLab.text = @"1111";
        _rightLab.textColor = blackColor();
        _rightLab.font = Font10();
        
    }
    return _rightLab;
}

- (void)setTitleS:(NSString *)titleS{
    
    _titleS = titleS;
    self.rightLab.text = titleS;
    
}

- (void)setImageS:(NSString *)imageS{
    
    _imageS = imageS;
    self.leftImageV.image = [UIImage imageNamed:imageS];
    
}

@end
