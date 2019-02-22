//
//  GrabWaterView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/18.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "GrabWaterView.h"
#import "GrabOrderWaterFlowLayout.h"
#import "GrabOrderWaterCell.h"

@interface GrabWaterView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray          *heightData;

@end

static NSString *cellID = @"GrabWaterView";
@implementation GrabWaterView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.heightData = @[@"200",@"170",@"240",@"160",@"140",@"160",@"190",@"180",@"140",@"180"];
        self.backgroundColor = whiteColor();
        [self addSubview:self.collectionView];
    
    }
    return self;
}


#pragma mark----懒加载
- (UIView *)collectionView{
    
    if (!_collectionView) {
        
        CGFloat margin = 10;
        
        GrabOrderWaterFlowLayout *flowLayout = [[GrabOrderWaterFlowLayout alloc]init];
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.estimatedItemSize = CGSizeMake((SCREEN_WIDTH - 3 * margin)/2.0, 140);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = HexColor(@"f5f5f5");
        
        [_collectionView registerClass:[GrabOrderWaterCell class] forCellWithReuseIdentifier:cellID];
        
    }
    return _collectionView;
}

#pragma mark---<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GrabOrderWaterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    CGFloat height = [self.heightData[indexPath.item] floatValue];
    cell.imageHeight = height;
    
    return cell;
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
    
}


@end
