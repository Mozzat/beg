//
//  SendTypeOrderVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/19.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "SendTypeOrderVC.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "SendOrderBtn.h"
#import "LYFPhotosManager.h"
#import "PublistWordsOrderVC.h"
#import "BaseNavigationController.h"
#import "PublishRedPackageVC.h"
#import "VoiceAuthorManager.h"

@interface SendTypeOrderVC ()

@end

@implementation SendTypeOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = whiteColor();
    [self setLocationUI];
    // Do any additional setup after loading the view.
}

- (BOOL)fd_prefersNavigationBarHidden{
    
    return YES;
    
}

- (void)setLocationUI{
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"发单关闭"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-30 - BDBottomHeight);
        make.width.height.mas_equalTo(20);
        
    }];
    
    NSArray *titleArr = @[@"图文发布",@"语音发布",@"红包发布"];
    CGFloat width = 66;
    CGFloat height = 96;
    CGFloat marigin = (SCREEN_WIDTH - 3 * width)/4.0;
    
    for (NSInteger index = 0; index < titleArr.count; index ++ ) {
        
        SendOrderBtn *btn = [[SendOrderBtn alloc]initWithFrame:CGRectMake(marigin + (marigin + width) * index , SCREENH_HEIGHT - BDBottomHeight - 30 - 20 - 50 - height, width, height) WithTitle:titleArr[index] WithImageString:titleArr[index]];
        btn.tag = 1222 + index;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
    
    
}

#pragma mark ---点击事件
- (void)closeAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)btnAction:(SendOrderBtn *)btn{
    
    NSInteger index = btn.tag - 1222;
    
    if (index == 0) {
       
        [self openImageAndWordVC];
        
    } else if (index == 1) {
        [self openAudioVC];
        
    } else {
        
        [self openRedPackage];
        
    }
    
}

- (void)openImageAndWordVC{
    
    [LYFPhotosManager showPhotosManager:self withMaxImageCount:3 withAlbumArray:^(NSMutableArray<LYFPhotoModel *> *albumArray) {

        NSLog(@"%@",albumArray);
        PublistWordsOrderVC *word = [[PublistWordsOrderVC alloc]init];
        [self.navigationController pushViewController:word animated:YES];

    }];
    
}

- (void)openAudioVC{
    
    [VoiceAuthorManager showVoiceManager:self];
    
}

- (void)openRedPackage{
    
    PublishRedPackageVC *redPackage = [[PublishRedPackageVC alloc]init];
    [self.navigationController pushViewController:redPackage animated:YES];
    
}

@end
