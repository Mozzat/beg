//
//  AlbumBottomView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/20.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYFAlbumModel.h"

typedef void(^AlbumBottomBlock)(NSInteger row);
NS_ASSUME_NONNULL_BEGIN

@interface AlbumBottomView : UIView

/// 当前相册
@property (nonatomic, strong) LYFAlbumModel *albumModel;


/**
 删除图片
 */
@property (nonatomic, copy)   AlbumBottomBlock delBlack;

@end

NS_ASSUME_NONNULL_END
