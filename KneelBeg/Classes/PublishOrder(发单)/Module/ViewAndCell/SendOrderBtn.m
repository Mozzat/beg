//
//  SendOrderBtn.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/19.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "SendOrderBtn.h"

@implementation SendOrderBtn

- (instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString *)title WithImageString:(NSString *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:image];
        [self addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self);
            make.centerX.equalTo(self);
            
        }];
        
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = title;
        titleLab.font = Font15();
        titleLab.textColor = blackColor();
        [self addSubview:titleLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(imageV.mas_bottom).offset(10);
            make.left.right.equalTo(self);
            
        }];
        
    }
    return self;
}

@end
