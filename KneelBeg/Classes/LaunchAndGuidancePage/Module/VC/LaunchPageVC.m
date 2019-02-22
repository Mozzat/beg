//
//  LaunchPageVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/15.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "LaunchPageVC.h"
#import "GuidancePageVC.h"

@interface LaunchPageVC ()

@property (nonatomic, weak ) UIButton *topBtn;

@end

@implementation LaunchPageVC

- (void)viewDidLoad{
    
    UIButton *topBtn = [[UIButton alloc]init];
    [topBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [topBtn setTitleColor:grayColor() forState:UIControlStateNormal];
    topBtn.titleLabel.font = Font14();
    self.topBtn = topBtn;
    [topBtn addTarget:self action:@selector(pushToGuidancePage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topBtn];
    
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(BDStatusBarHeight);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(30);
        make.height.mas_equalTo(30);
        
    }];
    
}

- (void)pushToGuidancePage{
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[GuidancePageVC alloc]init];
    
}

@end
