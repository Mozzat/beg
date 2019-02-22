//
//  AlbumBottomView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/20.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "AlbumBottomView.h"
#import "AlbumBottomCell.h"

@interface AlbumBottomView()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSString *cellID = @"AlbumBottomView";
@implementation AlbumBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.collectionView];
        
    }
    return self;
}

#pragma mark---懒加载
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
        flow.itemSize = CGSizeMake(50, 70);
        flow.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 150, 70) collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = whiteColor();
        
        [_collectionView registerClass:[AlbumBottomCell class] forCellWithReuseIdentifier:cellID];
        
    }
    
    return _collectionView;
}

- (void)setAlbumModel:(LYFAlbumModel *)albumModel{
    
    _albumModel = albumModel;
    [self.collectionView reloadData];
    
}

#pragma mark---<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AlbumBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    NSInteger rows = [self.albumModel.selectRows[indexPath.row] integerValue];
    cell.row = rows;
    cell.asset = self.albumModel.assets[rows];
    [cell loadImage];
    
    LRWeakSelf(self);
    cell.delBlock = ^(NSInteger row) {
      
        LRStrongSelf(self);
        if (self.delBlack) {
            self.delBlack(row);
        }
        
    };
    
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.albumModel.selectRows.count;
    
}

@end
