//
//  HomeFilterView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/8.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "HomeFilterView.h"

@interface HomeFilterView ()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) HomeFilterBtnView *btnView;
//@property (nonatomic, )

@end

@implementation HomeFilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(55, 55, 55, 0.4);
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.bottomView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    topView.backgroundColor = whiteColor();
    [self.bottomView addSubview:topView];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"发单关闭"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(topView);
        make.left.equalTo(topView).offset(20);
        make.width.height.mas_equalTo(30);
        
    }];
    
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setImage:[UIImage imageNamed:@"选中确定勾勾"] forState:UIControlStateNormal];
    [topView addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(topView);
        make.right.equalTo(topView).offset(-20);
        make.width.height.mas_equalTo(30);
        
    }];
    
    UIButton *resetBtn = [[UIButton alloc]init];
    [resetBtn setTitle:@"重置所有偏好" forState:UIControlStateNormal];
    [resetBtn setTitleColor:blackColor() forState:UIControlStateNormal];
    resetBtn.titleLabel.font = Font15();
    [self.bottomView addSubview:resetBtn];
    
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.left.right.equalTo(self.bottomView);
        make.height.mas_equalTo(60);
        
    }];
    
    UIScrollView *scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topView.bottom, SCREEN_WIDTH, self.bottomView.height- topView.height - 60)];
    scrollerView.backgroundColor = whiteColor();
    [self.bottomView addSubview:scrollerView];
    
    UIView *contentView = [[UIView alloc]init];
    [scrollerView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(scrollerView);
        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(500);
        
    }];
    
    HomeFilterSubviews *amountView = [[HomeFilterSubviews alloc]init];
    amountView.titleS = @"金额（元)";
    [contentView addSubview:amountView];
    
    [amountView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(contentView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(140);
        
    }];
    
    HomeFilterSubviews *distanceView = [[HomeFilterSubviews alloc]init];
    distanceView.titleS = @"距离（米)";
    [contentView addSubview:distanceView];
    
    [distanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(amountView.mas_bottom).offset(10);
        make.left.equalTo(contentView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(140);
        
    }];
    
    [contentView addSubview:self.btnView];
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(distanceView.mas_bottom);
        make.left.equalTo(contentView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(150);
        make.bottom.equalTo(contentView).offset(-20);
        
    }];
    
}

#pragma mark----懒加载
- (UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT - 600, SCREEN_WIDTH, 600)];
        _bottomView.backgroundColor = whiteColor();
    }
    return _bottomView;
}

- (HomeFilterBtnView *)btnView{
    
    if (!_btnView) {
        _btnView = [[HomeFilterBtnView alloc]init];
        
    }
    return _btnView;
}

- (void)closeBtnAction{
    
    self.hidden = YES;
    
}

- (void)setData:(NSArray *)data{
    
    _data = data;
    self.btnView.data = @[@"1",@"1",@"1",@"1"];
    
}

@end

@interface HomeFilterSubviews ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *rightImageV;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIImageView *leftImageV;
@property (nonatomic, strong) UILabel     *countLab;
@property (nonatomic, assign) NSInteger   max;

@end

@implementation HomeFilterSubviews

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = whiteColor();
        [self initSubviews];
        
    }
    return self;
}


- (void)initSubviews{
    
    self.max = SCREEN_WIDTH - 70;
    
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(40);
        
    }];
    
    [self addSubview:self.rightImageV];
    [self.rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.titleLab);
        make.left.equalTo(self.titleLab.mas_right).offset(10);
        
    }];
    
    [self addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_bottom).offset(55);
        make.left.equalTo(self).offset(55);
        make.right.equalTo(self).offset(-55);
        make.height.mas_equalTo(3);
        
    }];
    
    [self addSubview:self.leftImageV];
    
    [self addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.leftImageV);
        make.bottom.equalTo(self.leftImageV.mas_top).offset(-5);
        
    }];
    
    UIImageView *bottomLine = [[UIImageView alloc]init];
    bottomLine.image = [UIImage imageNamed:@"分割线"];
    [self addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(40);
        make.right.equalTo(self).offset(-40);
        make.bottom.equalTo(self);
        
    }];

}


#pragma mark---懒加载
- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"金额（元）";
        _titleLab.font = Font15();
        _titleLab.textColor = HexColor(@"f3364e");
        
    }
    return _titleLab;
}

- (UIImageView *)leftImageV{
    
    if (!_leftImageV) {
        _leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(40, 80, 30, 30)];
        [_leftImageV rounded:15];
        _leftImageV.image = [UIImage imageNamed:@"圆圈"];
        _leftImageV.userInteractionEnabled = YES;
        
    }
    return _leftImageV;
}

- (UIProgressView *)progressView{
    
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]init];
        _progressView.trackTintColor = HexColor(@"ebebeb");
        _progressView.progressTintColor = HexColor(@"F3364E");
        
    }
    return _progressView;
}

- (UIImageView *)rightImageV{
    
    if (!_rightImageV) {
        _rightImageV = [[UIImageView alloc]init];
        _rightImageV.image = [UIImage imageNamed:@"箭头复选"];
        
    }
    return _rightImageV;
}

- (UILabel *)countLab{
    
    if (!_countLab) {
        _countLab = [[UILabel alloc]init];
        _countLab.textColor = HexColor(@"9b9b9b");
        _countLab.font =Font12();
        
    }
    return _countLab;
}

- (void)setTitleS:(NSString *)titleS{
    
    _titleS = titleS;
    self.titleLab.text = titleS;
    
}

/////视图移动
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    
    if (touch.view == self.leftImageV) {
        [touch locationInView:self.leftImageV];
        
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    
    
    if (touch.view == self.leftImageV) {
        
        CGPoint point = [touch locationInView:self];
        NSLog(@"%f",point.x);
        CGPoint newCenter = self.leftImageV.center;
        newCenter.x = point.x;
        
        if (newCenter.x >= self.max + 15) {
            newCenter.x = self.max + 15;
            
        } else if (newCenter.x <= 55) {
            newCenter.x = 55;
            
        }
    
        
        self.currentValue = [self returnValueWithX:newCenter.x];
        self.countLab.text = [NSString stringWithFormat:@"%.f",newCenter.x];
        self.leftImageV.center = newCenter;
        
    }
    
}

- (NSInteger)returnValueWithX:(CGFloat)x{
    

    float count = self.totalValue/(self.max - 40 );
    self.progressView.progress = count;
    NSInteger result = count * (x - 40);
    return result;
    
    
}


@end

@interface HomeFilterBtnView ()

@property (nonatomic, strong) UIButton     *selectBtn;

@end

@implementation HomeFilterBtnView

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
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = @"金额（元）";
    titleLab.font = Font15();
    titleLab.textColor = HexColor(@"f3364e");
    [self addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(40);
        
    }];
    
    UIImageView *rightImageV = [[UIImageView alloc]init];
    rightImageV.image = [UIImage imageNamed:@"箭头复选"];
    [self addSubview:rightImageV];
    
    [rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(titleLab);
        make.left.equalTo(titleLab.mas_right).offset(10);
        
    }];

    
}

- (void)setData:(NSArray *)data{
    
    _data = data;
    CGFloat margin1 = 40;
    CGFloat margin2 = 15;
    CGFloat width = (SCREEN_WIDTH - 2 * margin1 - 2 * margin2)/3.0;
    CGFloat height = 45;
    
    CGFloat maxHeight = 0;
    for (NSInteger index = 0; index < data.count; index++) {
        
        NSInteger row = index/3;
        NSInteger col = index % 3;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(margin1 + col * (width + margin2) , row * (height + 15) + 70, width, height)];
        [btn rounded:4 width:0.5 color:HexColor(@"ebebeb")];
        [btn setTitle:@"跑腿" forState:UIControlStateNormal];
        [btn setTitleColor:HexColor(@"b9b9b9") forState:UIControlStateNormal];
        [btn setTitleColor:HexColor(@"f3364e") forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = Font15();
        [self addSubview:btn];
        
        maxHeight = btn.bottom;
        
    }
    
//    CGRect frame = self.frame;
//    frame.size.height = maxHeight;
//    self.frame = frame;
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {

        make.height.mas_equalTo(maxHeight);

    }];
    
}

- (void)changeBtn:(UIButton *)btn{
    
    if (btn == self.selectBtn) {
        return;
    }
    
    [self.selectBtn rounded:4 width:0.5 color:HexColor(@"ebebeb")];
    self.selectBtn.selected = NO;
    btn.selected = !btn.selected;
    self.selectBtn = btn;
    
    if (btn.selected) {
        [btn rounded:4 width:0.5 color:redColor()];
    } else {
        [btn rounded:4 width:0.5 color:HexColor(@"ebebeb")];
    }
    
}

@end
