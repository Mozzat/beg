//
//  CommentReplyCell.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/11.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "CommentReplyCell.h"

@interface CommentReplyCell ()

@property (nonatomic, strong) UIImageView *headImgeV;
@property (nonatomic, strong) UILabel     *nameLab;
@property (nonatomic, strong) UILabel     *timeLab;
@property (nonatomic, strong) UILabel     *commentLab;
@property (nonatomic, strong) UILabel     *replyComment;
@property (nonatomic, strong) UIImageView *likeImageV;
@property (nonatomic, strong) UILabel     *countLab;
@property (nonatomic, weak)   UIView      *line;

@end

@implementation CommentReplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    self.headImgeV.image = [UIImage imageNamed:@"默认头像"];
    [self.headImgeV rounded:24];
    [self.contentView addSubview:self.headImgeV];
    [self.headImgeV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self.contentView).offset(20);
        make.width.height.mas_equalTo(48);
        
    }];
    
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headImgeV).offset(5);
        make.left.equalTo(self.headImgeV.mas_right).offset(10);
        
    }];
    
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.nameLab.mas_bottom).offset(2);
        make.left.equalTo(self.nameLab);
        
    }];
    
    [self.contentView addSubview:self.countLab] ;
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.headImgeV);
        make.right.equalTo(self.contentView).offset(-20);
        
    }];
    
    [self.contentView addSubview:self.likeImageV];
    [self.likeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.countLab);
        make.right.equalTo(self.countLab.mas_left).offset(-10);
        
    }];
    
    [self.contentView addSubview:self.commentLab];
    [self.commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.headImgeV.mas_right).offset(10);
        make.top.equalTo(self.headImgeV.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        
    }];
    
    [self.contentView addSubview:self.replyComment];
    [self.replyComment mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.headImgeV.mas_right).offset(10);
        make.top.equalTo(self.commentLab.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView).offset(-10);
        
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HexColor(@"f5f5f5");
    self.line = line;
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        
    }];
    
}

#pragma mark---懒加载
-(UIImageView *)headImgeV{
    
    if (!_headImgeV) {
        _headImgeV = [[UIImageView alloc]init];
        _headImgeV.image = [UIImage imageNamed:@"默认头像"];
        
    }
    return _headImgeV;
}

- (UILabel *)nameLab{
    
    
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"Elyse";
        _nameLab.textColor = blackColor();
        _nameLab.font = BlodFont(16);
        
    }
    
    return _nameLab;
    
}

- (UILabel *)timeLab{
    
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = HexColor(@"9b9b9b");
        _timeLab.text = @"19/01/22";
        _timeLab.font = Font12();
        
    }
    return _timeLab;
}

- (UIImageView *)likeImageV{
    
    if (!_likeImageV) {
        _likeImageV = [[UIImageView alloc]init];
        _likeImageV.image = [UIImage imageNamed:@"发单喜欢"];
        
    }
    return _likeImageV;
}

- (UILabel *)countLab{
    
    if (!_countLab) {
        _countLab = [[UILabel alloc]init];
        _countLab.text = @"22";
        _countLab.textColor = blackColor();
        _countLab.font = Font15();
        
    }
    return _countLab;
}

- (UILabel *)commentLab{
    
    if (!_commentLab) {
        _commentLab = [[UILabel alloc]init];
        _commentLab.textColor = blackColor();
        _commentLab.text = @"请问下你是怎么拍出这么随性又文艺又可爱又贵气的照片。";
        _commentLab.font = Font15();
        _commentLab.numberOfLines = 0;
        
    }
    return _commentLab;
}

- (UILabel *)replyComment{
    
    if (!_replyComment) {
        
        _replyComment = [[UILabel alloc]init];
        _replyComment.textColor = HexColor(@"9b9b9b");
        _replyComment.font = Font15();
        _replyComment.attributedText = [Util mutableStringWithTitle:@"回复 明明就：小哥哥，我美吗？" WithString1:@"回复 明明就" WithAttrDic1:@{NSForegroundColorAttributeName : redColor()}]
        ;
        _replyComment.numberOfLines = 0;
        
    }
    return _replyComment;
}

- (void)setLineHide:(BOOL)lineHide{
    
    _lineHide = lineHide;
    self.line.hidden = lineHide;
    self.replyComment.hidden = YES;
    
//    if (lineHide) {
//        
//        
//        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
//        
//            make.bottom.equalTo(self.commentLab.mas_bottom).offset(10);
//            
//        }];
//        
//    }
    
}

@end
