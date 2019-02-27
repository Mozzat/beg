//
//  GrabOrderCommentView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/25.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "GrabOrderCommentView.h"

@interface GrabOrderCommentView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UIButton  *addBtn;

@end

@implementation GrabOrderCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(105);
        
    }];
    
    [self addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.topView.mas_bottom).offset(15);
        make.left.equalTo(self).offset(30);
        make.width.height.mas_equalTo(28);
        make.bottom.equalTo(self).offset(-10);
        
    }];
    
    [self addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.headImage);
        make.left.equalTo(self.headImage.mas_right).offset(10);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(21);
        
    }];
    
    UILabel *commentLab1 = [[UILabel alloc]init];
    commentLab1.textColor = HexColor(@"191919");
    commentLab1.font = Font14();
    commentLab1.numberOfLines = 2;
    commentLab1.attributedText = [Util mutableStringWithTitle:@"逆风蒲公英：我想接单，65块可以吗？" WithString1:@"逆风蒲公英：" WithAttrDic1:@{NSFontAttributeName : BlodFont(14),NSForegroundColorAttributeName : blackColor()}];
    [self.topView addSubview:commentLab1];

    [commentLab1 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.left.equalTo(self.topView).offset(15);

    }];

    UILabel *commentLab = [[UILabel alloc]init];
    commentLab.textColor = HexColor(@"191919");
    commentLab.font = Font14();
    commentLab.numberOfLines = 2;
    commentLab.attributedText = [Util mutableStringWithTitle:@"双笙：60块有点便宜啊…" WithString1:@"双笙：" WithAttrDic1:@{NSFontAttributeName : BlodFont(14),NSForegroundColorAttributeName : blackColor()}];
    [self.topView addSubview:commentLab];

    [commentLab mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(commentLab1.mas_bottom).offset(15);
        make.left.equalTo(self.topView).offset(15);

    }];

    UIButton *lookAll = [[UIButton alloc]init];
    [lookAll setTitle:@"查看12条评论" forState:UIControlStateNormal];
    [lookAll setTitleColor:HexColor(@"9b9b9b") forState:UIControlStateNormal];
    lookAll.titleLabel.font = Font12();
    lookAll.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.topView addSubview:lookAll];

    [lookAll mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(commentLab.mas_bottom).offset(15);
        make.left.equalTo(self.topView).offset(15);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(18);

    }];
    
}

#pragma mark---懒加载
- (UIView *)topView{
    
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = HexColor(@"f5f5f5");
        
    }
    return _topView;
}

- (UIImageView *)headImage{
    
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        [_headImage rounded:14];
        _headImage.backgroundColor = redColor();
        
    }
    return _headImage;
}

- (UIButton *)addBtn{
    
    if (!_addBtn) {
        _addBtn = [[UIButton alloc]init];
        [_addBtn setTitle:@"添加评论..." forState:UIControlStateNormal];
        [_addBtn setTitleColor:HexColor(@"b9b9b9") forState:UIControlStateNormal];
        _addBtn.titleLabel.font = Font15();
        
    }
    return _addBtn;
}

@end
