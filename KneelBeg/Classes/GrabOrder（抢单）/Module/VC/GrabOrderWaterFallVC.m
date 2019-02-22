//
//  GrabOrderWaterFallVC.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/18.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "GrabOrderWaterFallVC.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "BaseCollectionView.h"
//#import "WaterLayout.h"
#import "GrabOrderWaterCell.h"

@interface GrabOrderWaterFallVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView       *topView;
@property (nonatomic, strong) BaseCollectionView *collectionView;

@end

NSString *cellID = @"GrabOrderWaterFallVC";
@implementation GrabOrderWaterFallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLocationUI];

}

- (BOOL)fd_prefersNavigationBarHidden{
 
    return YES;
}

- (void)setLocationUI{
 
    [self.view addSubview:self.topView];
    [self.view addSubview:self.collectionView];
    
    ///添加头部按钮
    UIButton *search = [[UIButton alloc]init];
    search.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [search setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [self.topView addSubview:search];
    
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(44);
        make.left.equalTo(self.topView).offset(20);
        make.bottom.equalTo(self.topView);
        
    }];
    
    UIImageView *titleImageV = [[UIImageView alloc]init];
    titleImageV.image = [UIImage imageNamed:@"跪求标题"];
    [self.topView addSubview:titleImageV];
    
    [titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(search);
        make.centerX.equalTo(self.topView);
        
    }];
    
    UIButton *menuBtn = [[UIButton alloc]init];
    [menuBtn setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
    [self.topView addSubview:menuBtn];
    
    [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(44);
        make.right.equalTo(self.topView).offset(-10);
        make.bottom.equalTo(self.topView);
        
    }];
    
    UIButton *listBtn = [[UIButton alloc]init];
    [listBtn setImage:[UIImage imageNamed:@"坐标模式"] forState:UIControlStateNormal];
    [self.topView addSubview:listBtn];
    
    [listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(44);
        make.right.equalTo(menuBtn.mas_left);
        make.bottom.equalTo(self.topView);
        
    }];

}

#pragma mark---懒加载
- (UIView *)topView{
 
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BDTopHeight)];
        _topView.backgroundColor = whiteColor();
    }
    return _topView;
}

- (BaseCollectionView *)collectionView{
 
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[BaseCollectionView alloc]initWithFrame:CGRectMake(0, BDTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - BDTopHeight - BDBottomHeight) collectionViewLayout:flow];
        _collectionView.dataSource =self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[GrabOrderWaterCell class] forCellWithReuseIdentifier:cellID];
        
    }
    return _collectionView;
}
    
#pragma mark----UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GrabOrderWaterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
    
}


@end
