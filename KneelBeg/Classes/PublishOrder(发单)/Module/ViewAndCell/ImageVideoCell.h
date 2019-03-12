//
//  ImageVideoCell.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/20.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYFPhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageVideoCell : UICollectionViewCell

- (void)setLocationImage:(NSString *)image;

@property (nonatomic, strong) LYFPhotoModel *imageModel;

@end

NS_ASSUME_NONNULL_END
