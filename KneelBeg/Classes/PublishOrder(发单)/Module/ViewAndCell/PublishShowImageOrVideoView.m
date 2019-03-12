//
//  PublishShowImageOrVideoView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/20.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "PublishShowImageOrVideoView.h"
#import "ImageVideoCell.h"

@interface PublishShowImageOrVideoView  ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSString *cellId = @"PublishShowImageOrVideoView";
@implementation PublishShowImageOrVideoView

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
        flow.itemSize = CGSizeMake(72, 72);
        flow.minimumLineSpacing = 10;
        flow.minimumInteritemSpacing = 10;
        flow.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 72) collectionViewLayout:flow];
        _collectionView.backgroundColor = whiteColor();
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ImageVideoCell class] forCellWithReuseIdentifier:cellId];
        
    }
    return _collectionView;
}

#pragma mark---<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSInteger count = self.data.count;
    
    if (count < 3) {
        count = self.data.count + 1;
        
    } else {
        count = self.data.count;
        
    }
    
    return count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.item < self.data.count) {
        
        cell.imageModel = self.data[indexPath.row];
        
    } else {
        
        [cell setLocationImage:@"添加图片视频"];
        
    }
    
    return cell;
    
}

-(void)setData:(NSArray *)data{
    
    _data = data;
    [self.collectionView reloadData];
    
}

@end
