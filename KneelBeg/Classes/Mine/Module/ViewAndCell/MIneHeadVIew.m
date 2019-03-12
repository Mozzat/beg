//
//  MIneHeadVIew.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/12.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "MIneHeadVIew.h"

@interface MIneHeadVIew ()

@property (nonatomic, strong) UIImageView   *headImageV;
@property (nonatomic, strong) UILabel       *focuesLab;
@property (nonatomic, strong) UILabel       *fansBtn;
@property (nonatomic, strong) UILabel       *collectBtn;

@end

@implementation MIneHeadVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.headImageV];
    [self.headImageV rounded:36];
    
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.width.height.mas_equalTo(72);
        
    }];
    
    [self addSubview:self.focuesLab];
    [self.focuesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_left).offset(0.375 * SCREEN_WIDTH);
        make.centerY.equalTo(self);
        
    }];
    
    [self addSubview:self.fansBtn];
    [self.fansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_left).offset(0.625 * SCREEN_WIDTH);
        make.centerY.equalTo(self);
        
    }];
    
    [self addSubview:self.collectBtn];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_left).offset(0.875 * SCREEN_WIDTH);
        make.centerY.equalTo(self);
        
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HexColor(@"ebebeb");
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
        
    }];
    
}

#pragma mark----懒加载
- (UIImageView *)headImageV{
    
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc]init];
        _headImageV.image= [UIImage imageNamed:@"默认头像"];
        _headImageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadAction)];
        [_headImageV addGestureRecognizer:tap];
    }
    return _headImageV;
}

- (UILabel *)focuesLab{
    
    if (!_focuesLab) {
        _focuesLab = [[UILabel alloc]init];
        _focuesLab.numberOfLines = 2;
        _focuesLab.textColor = HexColor(@"9b9b9b");
        _focuesLab.attributedText = [self getLineAttrString:@"253\n关注" WithString1:@"253" WithString2:@"关注"];
    }
    return _focuesLab;
}

- (UILabel *)fansBtn{
    
    if (!_fansBtn) {
        _fansBtn = [[UILabel alloc]init];
        _fansBtn.numberOfLines = 2;
        _fansBtn.textColor = HexColor(@"9b9b9b");
        _fansBtn.attributedText = [self getLineAttrString:@"4933\n粉丝" WithString1:@"4933" WithString2:@"粉丝"];
        
        
    }
    return _fansBtn;
}

- (UILabel *)collectBtn{
    
    if (!_collectBtn) {
        _collectBtn = [[UILabel alloc]init];
        _collectBtn.numberOfLines = 2;
        _collectBtn.textColor = HexColor(@"9b9b9b");
        _collectBtn.attributedText = [self getLineAttrString:@"17\n收藏" WithString1:@"17" WithString2:@"收藏"];
        
    }
    return _collectBtn;
}

- (NSMutableAttributedString *)getLineAttrString:(NSString *)totalStr WithString1:(NSString *)string1 WithString2:(NSString *)string2{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = 15; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:BlodFont(18), NSParagraphStyleAttributeName:paraStyle,NSForegroundColorAttributeName : blackColor()};
    NSDictionary *dic1 = @{NSFontAttributeName:Font12(), NSParagraphStyleAttributeName:paraStyle,NSForegroundColorAttributeName : HexColor(@"9b9b9b")};
    NSMutableAttributedString *attr = [Util mutableStringWithTitle:totalStr WithString1:string1 WithString2:string2 WithAttrDic1:dic WithAttrDic2:dic1];
    
    return attr;
    
}

- (void)tapHeadAction{
    
    if (self.block) {
        self.block();
    }
    
}

@end
