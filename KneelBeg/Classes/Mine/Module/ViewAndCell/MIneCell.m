//
//  MIneCell.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/12.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "MIneCell.h"

@interface MIneCell ()

@property (nonatomic, strong) UILabel *leftTitle;
@property (nonatomic, strong) UIImageView *leftImageV;
@property (nonatomic, strong) UIImageView *rightImageV;

@end

@implementation MIneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self.contentView addSubview:self.leftImageV];
    [self.leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(20);
        make.width.height.mas_equalTo(32);
        make.bottom.equalTo(self.contentView).offset(-10);
        
    }];
    
    [self.contentView addSubview:self.leftTitle];
    [self.leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.leftImageV);
        make.left.equalTo(self.leftImageV.mas_right).offset(20);
        
    }];
    
    [self.contentView addSubview:self.rightImageV];
    self.rightImageV.image = [UIImage imageNamed:@"向右的箭头"];
    [self.rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.leftTitle);
        make.right.equalTo(self.contentView).offset(-20);

    }];
    
}

#pragma mark----懒加载
- (UILabel *)leftTitle{
    
    if (!_leftTitle) {
        _leftTitle = [[UILabel alloc]init];
        _leftTitle.textColor = blackColor();
        _leftTitle.font = Font15();
        
    }
    return _leftTitle;
}

- (UIImageView *)leftImageV{
    
    if (!_leftImageV) {
        
        _leftImageV = [[UIImageView alloc]init];
        
    }
    return _leftImageV;
}

- (UIImageView *)rightImageV{
    
    if (!_rightImageV) {
        _rightImageV = [[UIImageView alloc]init];
        
    }
    return _rightImageV;
}

- (void)setTitleS:(NSString *)titleS{
    
    _titleS = titleS;
    
    self.leftTitle.text = titleS;
    self.leftImageV.image = [UIImage imageNamed:titleS];
    
}

@end
