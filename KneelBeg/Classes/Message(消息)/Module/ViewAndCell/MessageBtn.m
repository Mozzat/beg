//
//  MessageBtn.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/14.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "MessageBtn.h"

@interface MessageBtn ()

@property (nonatomic, strong) UIView *redView;

@end

@implementation MessageBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.redView];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.titleLabel.mas_right);
        make.centerY.equalTo(self.titleLabel.mas_top);
        make.width.height.mas_equalTo(10);
        
    }];
    
}

#pragma mark---懒加载
- (UIView *)redView{
    
    if (!_redView) {
        _redView = [[UIView alloc]init];
        _redView.backgroundColor = redColor();
        [_redView rounded:5];
        
    }
    return _redView;
}

- (void)setShowPoint:(BOOL)showPoint{
    
    _showPoint = showPoint;
    self.redView.hidden = !showPoint;
    
}

@end
