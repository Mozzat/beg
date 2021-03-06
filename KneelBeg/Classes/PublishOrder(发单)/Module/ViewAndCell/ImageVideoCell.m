//
//  ImageVideoCell.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/20.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "ImageVideoCell.h"
#import <Photos/Photos.h>

@interface ImageVideoCell ()

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation ImageVideoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView rounded:4];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(self.contentView);
            make.width.height.mas_equalTo(72);
            
        }];
        
    }
    return self;
}

#pragma mark----懒加载
- (UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.backgroundColor = HexColor(@"ebebeb");
        
    }
    return _bgImageView;
}

- (void)setLocationImage:(NSString *)image{
    
    self.bgImageView.image = [UIImage imageNamed:image];
    
}

- (void)setImageModel:(LYFPhotoModel *)imageModel{
    
    _imageModel = imageModel;
    
    PHImageRequestOptions *opt = [[PHImageRequestOptions alloc]init];
    opt.networkAccessAllowed = YES;
    opt.resizeMode = PHImageRequestOptionsResizeModeExact;
    CGSize targetSize = CGSizeMake(70, 70);
    
    LRWeakSelf(self);
    [[PHImageManager defaultManager] requestImageForAsset:imageModel.asset targetSize:targetSize contentMode:PHImageContentModeDefault options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        LRStrongSelf(self);
        self.bgImageView.image = result;
        
        
    }];


    
}

@end
