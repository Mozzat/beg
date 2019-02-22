//
//  SendBottomView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/19.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "SendBottomView.h"

@implementation SendBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubViews];
        
    }
    return self;
}

- (void)initSubViews{
    
    UIImageView *bgImageView = [[UIImageView alloc]init];
    bgImageView.image = [UIImage imageNamed:@"发单背景"];
    [self addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.centerX.equalTo(self);
        
    }];
    
    UIImageView *topImageV = [[UIImageView alloc]init];
    topImageV.image = [UIImage imageNamed:@"确定位置按钮"];
    [self addSubview:topImageV];
    
    [topImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(bgImageView).offset(30);
        make.centerX.equalTo(bgImageView);
        
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"确认位置";
    label.font = Font16();
    label.textColor = whiteColor();
    [self addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topImageV.mas_centerY).offset(20);
        make.centerX.equalTo(topImageV);
        
    }];
    
}

@end
