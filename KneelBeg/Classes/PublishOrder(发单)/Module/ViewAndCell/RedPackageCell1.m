//
//  RedPackageCell1.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/21.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "RedPackageCell1.h"

@interface RedPackageCell1 ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *rightLab;

@end

@implementation RedPackageCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = HexColor(@"f5f5f5");
        [self initSubviews];
        
    }
    return self;
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
    
    [bgView addSubview:self.rightLab];
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(bgView);
        make.right.equalTo(bgView).offset(-15);
        
    }];
    
    [bgView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(bgView);
        make.right.equalTo(self.rightLab.mas_left).offset(-15);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(100);
        
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

- (UITextField *)textField{
    
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.textColor = blackColor();
        _textField.font = Font15();
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.tintColor = blackColor();
        [_textField addTarget:self action:@selector(textChangeTextField:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _textField;
}

- (void)setTitleS:(NSString *)titleS{
    
    _titleS = titleS;
    self.titleLab.text = titleS;
    
}

- (void)setRightS:(NSString *)rightS{
    
    _rightS = rightS;
    self.rightLab.text = rightS;
    
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    
    _placeHolder = placeHolder;
    self.textField.placeholder = placeHolder;
    
}

- (void)textChangeTextField:(UITextField *)textF{
    
    if (self.block) {
        self.block(textF.text, self.row);
    }
    
}

@end
