//
//  OpenRedPackageView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/6.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//  开启红包页面

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GrabRedPacketBlock)(NSDictionary *dic);
@interface OpenRedPackageView : UIControl

@property (nonatomic, strong)  NSDictionary *dic ;

@property (nonatomic, assign)  float        distance;

@property (nonatomic, copy)    GrabRedPacketBlock block;

- (void)startAnimation;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
