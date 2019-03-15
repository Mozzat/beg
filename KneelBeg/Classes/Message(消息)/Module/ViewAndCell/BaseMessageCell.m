//
//  BaseMessageCell.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/14.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "BaseMessageCell.h"

@interface BaseMessageCell ()

@end

@implementation BaseMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self.contentView addSubview:self.circieBtn];
    self.circieBtn.hidden = YES;
    [self.circieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
        make.width.height.mas_equalTo(24);
        
    }];
    
    [self.contentView addSubview:self.headImageV];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
        make.width.height.mas_equalTo(48);
        
    }];
    
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headImageV).offset(2);
        make.left.equalTo(self.headImageV.mas_right).offset(10);
        
    }];
    
    [self.contentView addSubview:self.subTitleLab];
    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_bottom).offset(5);
        make.left.equalTo(self.headImageV.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        
    }];
    
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.titleLab);
        make.right.equalTo(self.contentView).offset(-20);
        
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HexColor(@"f5f5f5");
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.headImageV);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        
    }];
    
}

#pragma mark---懒加载
- (UIImageView *)headImageV{
    
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc]init];
        _headImageV.image = [UIImage imageNamed:@"美女头像.jpg"];
        [_headImageV rounded:24];
    }
    return _headImageV;
}

- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = blackColor();
        _titleLab.font = BlodFont(16);
        _titleLab.text = @"交易信息";
        
    }
    return _titleLab;
}

- (UILabel *)subTitleLab{
    
    if (!_subTitleLab) {
        _subTitleLab = [[UILabel alloc]init];
        _subTitleLab.textColor = HexColor(@"9b9b9b");
        _subTitleLab.font = Font15();
        _subTitleLab.numberOfLines = 2;
        _subTitleLab.text = @"你有一条订单消息";
        
    }
    return _subTitleLab;
}

- (UILabel *)timeLab{
    
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = HexColor(@"9b9b9b");
        _timeLab.font = Font12();
        _timeLab.text = @"19/02/12";
    }
    return _timeLab;
}

- (UIButton *)circieBtn{
    
    if (!_circieBtn) {
        _circieBtn = [[UIButton alloc]init];
        [_circieBtn setImage:[UIImage imageNamed:@"普通状态"] forState:UIControlStateNormal];
        [_circieBtn setImage:[UIImage imageNamed:@"编辑状态"] forState:UIControlStateSelected];
        [_circieBtn addTarget:self action:@selector(tapCircileAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _circieBtn;
}

- (void)setIsEditing:(BOOL)isEditing{
    
    _isEditing = isEditing;
    self.circieBtn.hidden = !isEditing;
    
    if (isEditing) {
        
        [self.headImageV mas_updateConstraints:^(MASConstraintMaker *make) {
          
            make.left.equalTo(self.contentView).offset(60);
            
        }];
        
    } else {
        
        [self.headImageV mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(20);
            
        }];
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)tapCircileAction:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
}

@end
