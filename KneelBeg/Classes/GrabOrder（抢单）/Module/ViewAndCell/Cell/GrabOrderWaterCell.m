//
//  GrabOrderWaterCell.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/18.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//  抢单瀑布流cell

#import "GrabOrderWaterCell.h"

@interface GrabOrderWaterCell ()

@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel     *realName;
@property (nonatomic, strong) UILabel     *amountLab;
@property (nonatomic, strong) UILabel     *contentLab;
@property (nonatomic, strong) UIImageView *mainImage;

@end

@implementation GrabOrderWaterCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self rounded:8];
        self.backgroundColor = whiteColor();
        [self setLocationUI];
        
    }
    return self;
}

- (void)setLocationUI{
    
    
    [self.contentView addSubview:self.headView];
    [self.contentView addSubview:self.realName];
    [self.contentView addSubview:self.amountLab];
    [self.contentView addSubview:self.contentLab];
    [self.contentView addSubview:self.mainImage];
    
    CGFloat height = arc4random() % 101 + 100;
    
    [self.mainImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(height);
        
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mainImage.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        
        
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentLab.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.height.mas_equalTo(24);
        
    }];
    
    self.amountLab.attributedText = [Util mutableStringWithTitle:@"¥ 399" WithString1:@"399" WithAttrDic1:@{NSFontAttributeName:Font22()}];
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.headView);
        make.right.equalTo(self.contentView).offset(-10);
        
    }];
    
    [self.realName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.headView);
        make.left.equalTo(self.headView.mas_right).offset(8);
        make.right.lessThanOrEqualTo(self.amountLab).offset(-10);
        
    }];
    
    self.headView.backgroundColor = redColor();
    self.mainImage.backgroundColor = blackColor();
    
}

#pragma mark---懒加载
- (UIImageView *)headView{
    
    if (!_headView) {
        _headView = [[UIImageView alloc]init];
        [_headView rounded:12];
    }
    return  _headView;
}

- (UILabel *)amountLab{
    
    if (!_amountLab) {
        _amountLab = [[UILabel alloc]init];
        _amountLab.textColor = redColor();
        _amountLab.font = Font14();
        
    }
    return _amountLab;
}

- (UILabel *)realName{
    
    if (!_realName) {
        _realName = [[UILabel alloc]init];
        _realName.textColor = blackColor();
        _realName.font = BlodFont(12);
        _realName.text = @"可乐戒指";
    }
    return _realName;
}

- (UILabel *)contentLab{
    
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.font = Font14();
        _contentLab.text = @"上海水族馆有约起的吗？同行我出门票，来妹纸👧";
        _contentLab.numberOfLines = 2;
        _contentLab.textColor = blackColor();
        
    }
    return _contentLab;
}

- (UIImageView *)mainImage{
    
    if (!_mainImage) {
        _mainImage = [[UIImageView alloc]init];
        
    }
    return _mainImage;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height= size.height;
    layoutAttributes.frame= cellFrame;
    
    return layoutAttributes;
    
}

- (void)setImageHeight:(CGFloat)imageHeight{
    
    _imageHeight = imageHeight;
    
    [self.mainImage mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(imageHeight);
    }];
    
}

@end
