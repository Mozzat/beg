//
//  CustomCallouView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/18.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "CustomCallouView.h"

@interface CustomCallouView ()

@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel     *amountLab;
@property (nonatomic, strong) UILabel     *detialLab;
//@property (nonatomic, strong)

@end

@implementation CustomCallouView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self= [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColor.clearColor;
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.headView];
    self.headView.image = [UIImage imageNamed:@"红包图标"];
    [self.headView rounded:25];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self).offset(-5);
        make.left.equalTo(self).offset(10);
        make.width.height.mas_equalTo(50);
        
    }];
    
    [self addSubview:self.amountLab];
    self.amountLab.attributedText = [Util mutableStringWithTitle:@"¥60" WithString1:@"60" WithAttrDic1:@{NSFontAttributeName : Font22()}];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headView);
        make.left.equalTo(self.headView.mas_right).offset(10);
        make.right.lessThanOrEqualTo(self).offset(-10);
        
    }];
    
    [self addSubview:self.detialLab];
    [self.detialLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.amountLab.mas_bottom);
        make.left.equalTo(self.headView.mas_right).offset(10);
        make.right.lessThanOrEqualTo(self).offset(-10);
        
    }];
    
}

#pragma mark---懒加载
- (UIImageView *)headView{
    
    if (!_headView) {
        _headView = [[UIImageView alloc]init];
        
    }
    return _headView;
}

- (UILabel *)amountLab{
    
    if (!_amountLab) {
        _amountLab = [[UILabel alloc]init];
        _amountLab.textColor = redColor();
        _amountLab.font = Font16();
    }
    return _amountLab;
}

- (UILabel *)detialLab{
    
    if (!_detialLab) {
        _detialLab = [[UILabel alloc]init];
        _detialLab.textColor = Color4A();
        _detialLab.font = Font12();
        _detialLab.text = @"需求美女帅哥帮我";
        
    }
    return _detialLab;
}

- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [HexColor(@"b9b9b9") CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 35.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-10;
    
    CGContextMoveToPoint(context, midx+10, maxy);
    CGContextAddLineToPoint(context,midx, maxy+10);
    CGContextAddLineToPoint(context,midx-10, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

@end
