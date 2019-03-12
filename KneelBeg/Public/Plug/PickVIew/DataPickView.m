//
//  DataPickView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/4.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "DataPickView.h"

@interface DataPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView            *bottomView;
@property (nonatomic, weak)   UIPickerView      *pickView;
@property (nonatomic, copy)   NSString          *title;

@end
@implementation DataPickView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(53, 53, 53, 0.6);
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews{
    
    [self addSubview:self.bottomView];
    
    UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 120)];
    pickView.delegate = self;
    pickView.dataSource = self;
    self.pickView = pickView;
    [self.bottomView addSubview:pickView];
    
}

- (void)setData:(NSArray *)data{
    
    _data = data;
    [self.pickView reloadComponent:0];
    
}

#pragma mark---懒加载
- (UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 200)];
        _bottomView.backgroundColor = whiteColor();
        
        UIButton *canncleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 40)];
        [canncleBtn setTitle:@"取消" forState:UIControlStateNormal];
        canncleBtn.titleLabel.font = Font16();
        [canncleBtn setTitleColor:blackColor() forState:UIControlStateNormal];
        [canncleBtn addTarget:self action:@selector(hideAnimation) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:canncleBtn];
        
        UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 45, 0, 45, 40)];
        [sureBtn setTitleColor:blackColor() forState:UIControlStateNormal];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        sureBtn.titleLabel.font =Font16();
        [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:sureBtn];
        
    }
    return _bottomView;
}


#pragma mark----<UIPickerViewDelegate,UIPickerViewDataSource>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.data.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *title = self.data[row];
    return [NSString stringWithFormat:@"%@",title];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSString *title = self.data[row];
    self.title = title;
    
}

- (void)startAnimation{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.1 animations:^{
       
        self.bottomView.y = SCREENH_HEIGHT - 200;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)hideAnimation{
    
    [UIView animateWithDuration:0.1 animations:^{
       
        self.bottomView.y = SCREENH_HEIGHT;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}

- (void)sureAction{
    
    if (self.block) {
        self.block(self.title);
    }
    
}

@end
