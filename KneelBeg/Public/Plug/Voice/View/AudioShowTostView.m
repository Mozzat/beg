//
//  AudioShowTostView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/22.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "AudioShowTostView.h"

@interface AudioShowTostView ()

///动画组
@property (nonatomic, strong) UIImageView *topImageV;
///图片
@property (nonatomic, strong) UIImageView *topImageV1;
@property (nonatomic, strong) UILabel     *promitLab;
@property (nonatomic, assign) AudioShowTostType type;

@end

@implementation AudioShowTostView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(50, 50, 50, 0.6);
        [self rounded:8];
        
        [self addSubview:self.promitLab];
        [self addSubview:self.topImageV];
        [self addSubview:self.topImageV1];
        
        [self.promitLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self).offset(-15);
            make.height.mas_equalTo(17);
            
        }];
        
        
        [self.topImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.promitLab.mas_top).offset(-18);
            make.centerX.equalTo(self);
            
        }];
        
        [self.topImageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.promitLab.mas_top).offset(-18);
            make.centerX.equalTo(self);
            
        }];
        
    }
    return self;
}

#pragma mark---懒加载
- (UIImageView *)topImageV{
    
    if (!_topImageV) {
        _topImageV = [[UIImageView alloc]init];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger index = 1; index < 7; index ++) {
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"麦克风语音%ld",index]];
            [arr addObject:image];
            
        }
        
        ///设置动画图片
        _topImageV.animationImages = arr;
        ///设置动画播放次数
        _topImageV.animationRepeatCount = 0;
        _topImageV.animationDuration = 1.0;
        
    }
    return _topImageV;
}

- (UIImageView *)topImageV1{
    
    if (!_topImageV1) {
        _topImageV1 = [[UIImageView alloc]init];
        
    }
    return _topImageV1;
}

- (UILabel *)promitLab{
    
    if (!_promitLab) {
        _promitLab = [[UILabel alloc]init];
        _promitLab.font =Font11();
        _promitLab.text = @"松开上滑，取消录音";
        _promitLab.textColor = whiteColor();
        _promitLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _promitLab;
}

- (void)updateUIWithRecordState:(AudioShowTostType)state{
    
    self.type = state;
    self.promitLab.backgroundColor = UIColor.clearColor;
    
    if (!_topImageV.hidden) {
        self.topImageV.hidden = YES;
        [self.topImageV stopAnimating];
    }
    
    if (_topImageV1.hidden) {
        self.topImageV1.hidden = NO;
    }
    
    NSLog(@"%d,===%d",self.topImageV.hidden,self.topImageV1.hidden);
    
    if (state == AudioShowTostTypeNormal) {
        
        self.topImageV1.image = [UIImage imageNamed:@"麦克风语音1"];
        self.promitLab.text = @"手指上滑，取消录音";
        
    } else if (state == AudioShowTostTypeRecording) {
        
        if (self.topImageV.hidden) {
            self.topImageV.hidden = NO;
            [self.topImageV startAnimating];
        }
        
        if (!self.topImageV1.hidden) {
            self.topImageV1.hidden = YES;
        }
        
        self.promitLab.text = @"手指上滑，取消录音";
        
    } else if (state == AudioShowTostTypeReleaseToCancel) {
        
        self.topImageV1.image = [UIImage imageNamed:@"上滑-取消发布"];
        self.promitLab.text = @"松开手指，取消录音";
        self.promitLab.backgroundColor = RGBA(230, 49, 78, 1);
        
    } else if (state == AudioShowTostTypeReleaseToShort) {
        
        self.topImageV1.image = [UIImage imageNamed:@"说话时间太短"];
        self.promitLab.text = @"说话时间太短";
    
    }
    
}

- (void)showVoiceImage{
    
    if (self.type == AudioShowTostTypeRecording) {
        
        for (NSInteger index = 0; index < 6; index ++) {
            
            self.topImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"麦克风语音%ld",index]];
            
        }
        
    }
    
}

@end
