//
//  PublishPayMethedView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/4.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "PublishPayMethedView.h"
#import "TagView.h"

@interface PublishPayMethedView ()<TagViewDelegate>

@property (nonatomic, strong) UILabel   *titleLab;
@property (nonatomic, strong) TagView   *tagView;

@end

@implementation PublishPayMethedView


-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

        [self initSubviews];
        
    }
    return self;
}


- (void)initSubviews{
    
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(20);
        
    }];
    
    [self addSubview:self.tagView];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HexColor(@"f5f5f5");
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(1);
        
    }];
    
}

#pragma mark---懒加载
- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = blackColor();
        _titleLab.font = Font15();
    }
    
    return _titleLab;
}

-(TagView *)tagView{
    
    if (!_tagView) {
        _tagView = [[TagView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 220, 6, 220, 40)];
        _tagView.backgroundColor = UIColor.whiteColor;
        _tagView.userInteractionEnabled = YES;
        _tagView.delegate = self;
    }
    return _tagView;
}

- (void)setTitleS:(NSString *)titleS{
    
    _titleS = titleS;
    self.titleLab.text = titleS;
    
}

- (void)setData:(NSArray *)data{
    
    _data = data;
    
    if (_data.count) {
        self.tagView.arr = data;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(self.tagView.bottom + 6);
            
        }];
        
    }
    
}

#pragma mark---<TagViewDelegate>
- (void)handleSelectTag:(NSDictionary *)dic{
    
    if (self.bloack) {
        self.bloack(dic);
    }
    
}

@end
