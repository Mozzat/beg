//
//  GrabRedPacketCell.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/7.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "GrabRedPacketCell.h"
#import "UIImageView+Load.h"

@interface GrabRedPacketCell ()

@property (nonatomic, strong) UIImageView   *headImageV;
@property (nonatomic, strong) UILabel       *nameLab;
@property (nonatomic, strong) UILabel       *timeLab;
@property (nonatomic, strong) UILabel       *amountLab;

@end

@implementation GrabRedPacketCell

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

#pragma mark---懒加载
- (UIImageView *)headImageV{
    
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc]init];
        
    }
    return _headImageV;
}

- (UILabel *)nameLab{
    
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"Alice的红包";
        _nameLab.textColor = blackColor();
        _nameLab.font = BlodFont(15);
        
    }
    return _nameLab;
    
}

- (UILabel *)timeLab{
    
    if (!_timeLab ) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = HexColor(@"9b9b9b");
        _timeLab.text = @"02-12  17:53";
        _timeLab.font = Font12();
    }
    return _timeLab;
}

- (UILabel *)amountLab{
    
    if (!_amountLab) {
        _amountLab = [[UILabel alloc]init];
        _amountLab.textColor = blackColor();
        _amountLab.font = Font15();
        _amountLab.text = @"13.22元";
    }
    return _amountLab;
}

- (void)initSubviews{
    
    [self.contentView addSubview:self.headImageV];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.timeLab];
    [self.contentView addSubview:self.amountLab];
    
    [self.headImageV rounded:24];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
        make.width.height.mas_equalTo(48);
        
    }];
    
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headImageV).offset(5);
        make.left.equalTo(self.headImageV.mas_right).offset(15);
        
    }];
    
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.nameLab.mas_bottom).offset(5);
        make.left.equalTo(self.nameLab);
        
    }];
    
    [self.contentView addSubview:self.amountLab];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-20);
        
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HexColor(@"ebebeb");
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        
    }];
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _dataDic =  dataDic;
    
    float time = [dataDic[@"dDate"] floatValue];
    self.timeLab.text = [Util returnTimeStringWithDate:[NSDate dateWithTimeIntervalSince1970:time] WithFormaterType:@"MM-dd hh:mm"];
    self.amountLab.text = [NSString stringWithFormat:@"%.2f元",[dataDic[@"nMoney"] floatValue]];
    [self.headImageV loadImageViewWithImageString:dataDic[@"headImage"] WithPlaceHoldeImage:@"默认头像"];
    self.nameLab.text = dataDic[@"nickName"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
