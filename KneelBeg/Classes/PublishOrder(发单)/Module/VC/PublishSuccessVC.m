//
//  PublishSuccessVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/5.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "PublishSuccessVC.h"

@interface PublishSuccessVC ()

@end

@implementation PublishSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"发布";
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [closeBtn setImage:[UIImage imageNamed:@"发单关闭"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:closeBtn];
    
    UIImageView *bgImageV = [[UIImageView alloc]init];
    bgImageV.image = [UIImage imageNamed:@"发布成功"];
    [self.view addSubview:bgImageV];
    
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(BDTopHeight + 50);
        make.centerX.equalTo(self.view);
        
    }];
    
}

#pragma mark---点击事件
- (void)closeAction{
    
    for (BaseViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[NSClassFromString(@"SendTypeOrderVC") class]]) {
            
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }
    
}

@end
