//
//  RedPageageCell2.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/21.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "RedPageageCell2.h"

@interface RedPageageCell2 ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *rightLab;

@end

@implementation RedPageageCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = HexColor(@"f5f5f5");
        [self initSubviews];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)initSubviews{
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = whiteColor();
    [bgView rounded:6];
    [self.contentView addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(50);
        
    }];
    
    [bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(bgView);
        make.left.equalTo(bgView).offset(15);
        
    }];
    
    UIImageView *rightImage = [[UIImageView alloc]init];
    rightImage.image = [UIImage imageNamed:@"向右的箭头"];
    
    [bgView addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(bgView);
        make.right.equalTo(bgView).offset(-15);
        
    }];
    
    [bgView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(bgView);
        make.right.equalTo(rightImage.mas_left).offset(-10);
        
    }];
    
}


#pragma mark---懒加载
-(UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = blackColor();
        _titleLab.font = Font15();
        
    }
    return _titleLab;
}

- (UILabel *)rightLab {
    
    if (!_rightLab) {
        _rightLab = [[UILabel alloc]init];
        _rightLab.font =Font15();
        _rightLab.textColor = blackColor();
        
    }
    return _rightLab;
    
}

- (UILabel *)contentLab{
    
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = blackColor();
        _contentLab.font = Font15();
        _contentLab.textAlignment = NSTextAlignmentRight;
        
    }
    
    return _contentLab;
}

- (void)setTitleS:(NSString *)titleS{
    
    _titleS = titleS;
    self.titleLab.text = titleS;
    
}

- (void)setContentS:(NSString *)contentS{
    
    _contentS = contentS;
    self.contentLab.text = contentS;
    
}

@end
