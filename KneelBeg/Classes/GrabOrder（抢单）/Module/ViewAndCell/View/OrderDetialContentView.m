//
//  OrderDetialContentView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/25.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "OrderDetialContentView.h"

@interface OrderDetialContentView ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIButton *openBtn;

@end

@implementation OrderDetialContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = whiteColor();
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.titleLab];
    [self addSubview:self.contentLab];
    [self addSubview:self.openBtn];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_bottom).offset(20);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(-30);
        
    }];
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentLab.mas_bottom).offset(5);
        make.left.equalTo(self).offset(20);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(21);
        
    }];
    
}

#pragma mark----懒加载
- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = BlodFont(16);
        _titleLab.textColor = blackColor();
        _titleLab.text = @"@【跑腿】需要帅哥美女帮我带一份肯德基";
        _titleLab.numberOfLines = 0;
        
    }
    return _titleLab;
    
}

- (UILabel *)contentLab{
    
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = blackColor();
        _contentLab.font = Font15();
        _contentLab.text = @"所带内容：\n 1.上校鸡块 8块；\n2.吮指原味鸡 4块；\n3.圣代 2个；\n4.可乐大杯2杯（一杯加冰，一杯不加）";
        _contentLab.numberOfLines = 0;
    }
    return _contentLab;
}

- (UIButton *)openBtn{
    
    if (!_openBtn) {
        _openBtn = [[UIButton alloc]init];
        [_openBtn setTitle:@"展开" forState:UIControlStateNormal];
        [_openBtn setTitleColor:redColor() forState:UIControlStateNormal];
        _openBtn.titleLabel.font = BlodFont(15);
        
    }
    return _openBtn;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _dataDic = dataDic;
    NSString *content = dataDic[@"cDesc"];
    self.titleLab.text = dataDic[@"cTitle"];
    self.contentLab.text = content;
    self.contentLab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    CGSize rect = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : Font15()} context:nil].size;
    
    self.openBtn.hidden = rect.height > 150 ? NO : YES ;
    
}

@end
