//
//  OrderShareVIew.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/25.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "OrderShareVIew.h"
#import "UIShareButton.h"

@interface OrderShareVIew()

@property (nonatomic, strong)  UIShareButton *shareBtn;
@property (nonatomic, strong)  UIShareButton *collectionBtn;
@property (nonatomic, strong)  UIShareButton *likeBtn;
@property (nonatomic, strong)  UIShareButton *messageBtn;

@end

@implementation OrderShareVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = whiteColor();
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.shareBtn];
    [self addSubview:self.collectionBtn];
    [self addSubview:self.likeBtn];
    [self addSubview:self.messageBtn];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.height.mas_equalTo(30);
        
    }];
    
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.shareBtn);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(30);
        
    }];
    
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.shareBtn);
        make.right.equalTo(self.messageBtn.mas_left).offset(-20);
        make.height.mas_equalTo(30);
        
    }];
    
    
}

#pragma mark----懒加载
- (UIShareButton *)shareBtn{
    
    if (!_shareBtn) {
        _shareBtn = [[UIShareButton alloc]init];
        _shareBtn.imageS = @"发单分享";
        _shareBtn.titleS = @"111";
        
    }
    return _shareBtn;
}

- (UIShareButton *)likeBtn{
    
    if (!_likeBtn) {
        
        _likeBtn = [[UIShareButton alloc]init];
        _likeBtn.imageS = @"发单喜欢";
        
    }
    return _likeBtn;
}

- (UIShareButton *)collectionBtn{
    
    if (!_collectionBtn) {
        _collectionBtn = [[UIShareButton alloc]init];
        _collectionBtn.imageS = @"发单收藏";
        _collectionBtn.titleS = @"222";
        
    }
    return _collectionBtn;
}

- (UIShareButton *)messageBtn{
    
    if (!_messageBtn) {
        _messageBtn = [[UIShareButton alloc]init];
        _messageBtn.imageS = @"发单消息";
        _messageBtn.titleS = @"333";
        
    }
    return _messageBtn;
}

@end
