//
//  OpenRedPackageView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/6.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "OpenRedPackageView.h"

@interface OpenRedPackageView ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView            *bgView;
@property (nonatomic, strong) UIImageView       *headImageV;
@property (nonatomic, strong) UILabel           *titleLab;
@property (nonatomic, strong) UILabel           *contentLab;
@property (nonatomic, strong) UIButton          *openBtn;
@property (nonatomic, strong) UILabel           *promitLab;
@property (nonatomic, assign) float             scale;

@end

@implementation OpenRedPackageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = blackColor();
        self.scale = SCREEN_WIDTH/414;
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    self.backgroundColor =RGBA(255, 255, 255, 0.9);
    
    [self addSubview:self.bgView];
    [self.bgView rounded:4];
    
    UIImageView *bottomImage  = [[UIImageView alloc]init];
    bottomImage.image = [UIImage imageNamed:@"红包底"];
    bottomImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.bgView addSubview:bottomImage];
    
    [bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.left.equalTo(self.bgView);
        make.width.equalTo(self.bgView);
        
    }];
    
    UIImageView *topImageV = [[UIImageView alloc]init];
    topImageV.image = [UIImage imageNamed:@"红包上"];
    topImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.bgView addSubview:topImageV];
    
    [topImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(self.bgView);
        make.width.equalTo(self.bgView);
        
    }];
    
    UIView *topView = [[UIView alloc]init];
    [self.bgView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bgView).offset(150);
        make.centerX.equalTo(self.bgView);
        
    }];
    
    [topView addSubview:self.headImageV];
    [self.headImageV rounded:18];
    self.headImageV.backgroundColor = whiteColor();
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView);
        make.left.equalTo(topView);
        make.width.height.mas_equalTo(36);
        make.bottom.equalTo(topView);
        
    }];
    
    [topView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.headImageV);
        make.left.equalTo(self.headImageV.mas_right).offset(15);
        make.right.equalTo(topView);
        make.width.mas_lessThanOrEqualTo(200);
        
    }];
    
    [self.bgView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView.mas_bottom).offset(20);
        make.left.equalTo(self.bgView).offset(20);
        make.right.equalTo(self.bgView).offset(-20);
    }];
    
    [self.bgView addSubview:self.openBtn];
    self.openBtn.enabled = NO;
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.bgView);
        make.centerY.equalTo(topImageV.mas_bottom);
        make.width.height.mas_equalTo(96);
        
    }];
    
    [self.bgView addSubview:self.promitLab];
    [self.promitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.openBtn.mas_bottom).offset(20);
        make.centerX.equalTo(self.bgView);
        
    }];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"红包关闭"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bgView.mas_bottom).offset(30);
        make.centerX.equalTo(self);
        make.height.width.mas_equalTo(44);
        
    }];
    
    self.bgView.hidden = YES;
    
}

#pragma mark----懒加载
- (UIView *)bgView{
    
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake( (SCREEN_WIDTH - 315)/2.0,BDTopHeight + 10, 315 , 534)];
        
    }
    return _bgView;
}

- (UIImageView *)headImageV{
    
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc]init];
    }
    return _headImageV;
}

- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"Alice的红包";
        _titleLab.textColor = HexColor(@"FFE3B2");
        _titleLab.font = Font18();
        _titleLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLab;
}

- (UILabel *)contentLab{
    
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.textColor = HexColor(@"FFE3B2");
        _contentLab.text = @"”求人不如求己，红包就在这里“";
        _contentLab.font = Font18();
        _contentLab.numberOfLines = 0;
        _contentLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _contentLab;
}

- (UIButton *)openBtn{
    
    if (!_openBtn) {
        _openBtn = [[UIButton alloc]init];
        [_openBtn setImage:[UIImage imageNamed:@"红包不能领取"] forState:UIControlStateDisabled];
        [_openBtn setImage:[UIImage imageNamed:@"红包领取"] forState:UIControlStateNormal];
        [_openBtn addTarget:self action:@selector(grabRedPacketAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _openBtn;
}

- (UILabel *)promitLab{
    
    if (!_promitLab) {
        _promitLab = [[UILabel alloc]init];
        _promitLab.textAlignment = NSTextAlignmentCenter;
        _promitLab.font = Font12();
        _promitLab.textColor = whiteColor();
        _promitLab.text = @"当前不在领取范围内，查看领取范围";
        
    }
    return _promitLab;
}

#pragma mark---数据处理
- (void)setDic:(NSDictionary *)dic{
    
    _dic = dic;
    
    BOOL nIsReach = dic[@"nIsRanch"];
    if (nIsReach) {
        
        self.openBtn.enabled = NO;
        
    } else {
        
        self.openBtn.enabled = YES;
        self.promitLab.hidden = YES;
        
    }
    
}

- (void)setDistance:(float)distance{
    
    _distance = distance;
    
    float range = [self.dic[@"nRange"] floatValue];
    
    if (distance <= range) {
        
        self.openBtn.enabled = YES;
        self.promitLab.hidden = YES;
        
    } else {
        
        self.openBtn.enabled = NO;
        
    }
    
    
}

#pragma mark---事件
- (void)closeAction{
    
    [self minScaleToShow:self.bgView];
    
}

- (void)grabRedPacketAction{
    
    if (self.block) {
        self.block(self.dic);
    }
    
}

- (void)scaleToShow:(UIView *)aView{
    
    aView.hidden = NO;
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:@"scaleMax"];
    
}

- (void)startAnimation{
    
    [self scaleToShow:self.bgView];
    
}

- (void)hide{
    
    [self removeFromSuperview];
    
}

- (void)minScaleToShow:(UIView *)aView{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.duration = 0.2;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];

    animation.values = values;
    [aView.layer addAnimation:animation forKey:@"scaleMin"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [self removeFromSuperview];
    
}

@end
