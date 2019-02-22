//
//  AlbumBottomCell.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/20.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^AlbumButtomCellBlock)(NSInteger row);
@interface AlbumBottomCell : UICollectionViewCell

/// 行数
@property (nonatomic, assign) NSInteger row;
/// 相片
@property (nonatomic, strong) PHAsset *asset;

@property (nonatomic, copy)   AlbumButtomCellBlock delBlock;

#pragma mark - 加载图片
-(void)loadImage;

@end

NS_ASSUME_NONNULL_END
