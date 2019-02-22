//
//  PublishVoiceView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/21.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "PublishVoiceView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface PublishVoiceView()

@property (nonatomic, strong) UIControl *voiceControl;
@property (nonatomic, strong) UILabel   *secondLab;
@property (nonatomic, strong) UIImageView *leftImageV;
@property (nonatomic, strong) UIButton    *delBtn;

@end

@implementation PublishVoiceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = whiteColor();
        [self initSubvies];
        
    }
    return self;
}

- (void)initSubvies{
    
    [self addSubview:self.voiceControl];
    [self.voiceControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(140);
        
    }];
    
    [self addSubview:self.secondLab];
    [self.secondLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.right.equalTo(self.voiceControl).offset(-20);
        
    }];
    
    [self addSubview:self.leftImageV];
    [self.leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self.voiceControl).offset(14);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(18);
        
    }];
    
    [self addSubview:self.delBtn];
    self.delBtn.hidden = YES;
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.voiceControl);
        make.centerY.equalTo(self.voiceControl.mas_top);
        make.width.height.mas_equalTo(15);
        
    }];
    
}

#pragma mark---懒加载
- (UIControl *)voiceControl{
    
    if (!_voiceControl) {
        _voiceControl = [[UIControl alloc]init];
        
        [_voiceControl rounded:20];
        _voiceControl.backgroundColor = redColor();
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(delAction)];
        longPress.minimumPressDuration = 1;
        [_voiceControl addGestureRecognizer:longPress];
        
        
    }
    return _voiceControl;
}

- (UILabel *)secondLab{
    
    if (!_secondLab) {
        _secondLab = [[UILabel alloc]init];
        _secondLab.textColor = whiteColor();
        _secondLab.font =Font15();
        _secondLab.text = @"30''";
    }
    return _secondLab;
}

- (UIImageView *)leftImageV{
    
    if (!_leftImageV) {
        _leftImageV = [[UIImageView alloc]init];
        _leftImageV.image = [UIImage imageNamed:@"语音3"];
        
    }
    return _leftImageV;
}

- (UIButton *)delBtn{
    
    if (!_delBtn) {
        _delBtn = [[UIButton alloc]init];
        [_delBtn setImage:[UIImage imageNamed:@"组件删除"] forState:UIControlStateNormal];
        
    }
    return _delBtn;
}

- (void)delAction{
    
    if (self.delBtn.hidden) {
        
        AudioServicesPlaySystemSound(1521);
        self.delBtn.hidden = NO;
    }

}

@end
