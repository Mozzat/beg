//
//  PublishOrderLineView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/20.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "PublishOrderLineView.h"

@interface PublishOrderLineView ()

@property (nonatomic, assign) PublishOrderLineType type;
@property (nonatomic, strong) UILabel   *titleLab;
@property (nonatomic, strong) UILabel   *contentLab;
@property (nonatomic, strong) UITextField *textF;

@end

@implementation PublishOrderLineView

-(instancetype)initWithFrame:(CGRect)frame WithType:(PublishOrderLineType)type{
    
    if (self = [super initWithFrame:frame]) {
        
        self.type = type;
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
        
    }];
    
    UIImageView *imageV = nil;
    if (self.type != PublishOrderLineTypeInput) {
        
        imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:@"向右的箭头"];
        [self addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-20);
            
        }];
        
        [self addSubview:self.contentLab];
        [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.right.equalTo(imageV.mas_right).offset(-10);
            make.left.lessThanOrEqualTo(self.titleLab.mas_right).offset(20);
            
        }];
        
    } else {
        
        [self addSubview:self.textF];
        [self.textF mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-20);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(30);
            
        }];
        
    }
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HexColor(@"f5f5f5");
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(1);
        
    }];
    
}

#pragma mark---懒加载
- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = blackColor();
        _titleLab.font = Font15();
    }
    
    return _titleLab;
}

- (UILabel *)contentLab{
    
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = HexColor(@"9b9b9b");
        _contentLab.font = Font15();
        _contentLab.textAlignment = NSTextAlignmentRight;
    }
    return _contentLab;
}

- (UITextField *)textF{
    
    if (!_textF) {
        _textF = [[UITextField alloc]init];
        _textF.textColor = blackColor();
        _textF.font = Font15();
        _textF.textAlignment = NSTextAlignmentRight;
        _textF.tintColor = blackColor();
        _textF.keyboardType = UIKeyboardTypeNumberPad;
        [_textF addTarget:self action:@selector(textFieldChangeTextF:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _textF;
}

- (void)setTitles:(NSString *)title{
    
    self.titleLab.text = title;
    
}

- (void)textFieldChangeTextF:(UITextField *)textF{
    
    if (self.block) {
        self.block(textF.text);
    }
    
}

- (void)setContent:(NSString *)content WithTextColor:(UIColor *)textColor{
    
    self.contentLab.text = content;
    self.contentLab.textColor = textColor;
    
}

@end
