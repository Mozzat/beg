//
//  AlbumBottomCell.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/20.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "AlbumBottomCell.h"

@interface AlbumBottomCell ()

@property (nonatomic, strong) UIImageView *bgImageV;
@property (nonatomic, strong) UIButton    *delBtn;

@end

@implementation AlbumBottomCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.bgImageV];
        [self.bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(self.contentView);
            make.width.height.mas_equalTo(40);
            
        }];
        
        [self.contentView addSubview:self.delBtn];
        [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.bgImageV.mas_left);
            make.centerY.equalTo(self.bgImageV.mas_top);
            make.width.height.mas_equalTo(10);
            
        }];
        
    }
    return self;
}


#pragma mark---懒加载
- (UIImageView *)bgImageV{
    
    if (!_bgImageV) {
        _bgImageV = [[UIImageView alloc]init];
        
    }
    return _bgImageV;
}

- (UIButton *)delBtn{
    
    if (!_delBtn) {
        _delBtn = [[UIButton alloc]init];
        [_delBtn setTitle:@"X" forState:UIControlStateNormal];
        [_delBtn setTitleColor:blackColor() forState:UIControlStateNormal];
        _delBtn.titleLabel.font =Font14();
        [_delBtn addTarget:self action:@selector(delAlblumImage) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _delBtn;
}

-(void)loadImage{
    
    self.delBtn.enabled = YES;
    CGFloat imageWidth = (SCREEN_WIDTH - 20.f) / 5.5;
    self.bgImageV.image = nil;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = NO;
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:self.asset targetSize:CGSizeMake(imageWidth * [UIScreen mainScreen].scale, imageWidth * [UIScreen mainScreen].scale) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        self.bgImageV.image = result;
        
    }];
    
}

- (void)delAlblumImage{
    
    self.delBtn.enabled = NO;
    if (self.delBlock) {
        self.delBlock(self.row);
    }
    
}

@end
