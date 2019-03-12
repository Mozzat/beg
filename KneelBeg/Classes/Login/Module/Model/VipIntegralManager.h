//
//  VipIntegralManager.h
//  jike
//
//  Created by 上海荣豫资产 on 2018/12/4.
//  Copyright © 2018 陶庭兴. All rights reserved.
//  会员积分管理

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipIntegralModel : BaseModel

///vip会员
@property (nonatomic, copy)   NSString *cVipType;
@property (nonatomic, copy)   NSString *cVipName;
@property (nonatomic, assign) NSInteger nVipOrder;
@property (nonatomic, assign) NSInteger nVipGrowthValue;
@property (nonatomic, assign) NSInteger nVipRequirement;

///黑钻会员
@property (nonatomic, copy)   NSString *cBlackType;
@property (nonatomic, copy)   NSString *cBlackName;
@property (nonatomic, assign) NSInteger nBlackOrder;
@property (nonatomic, strong) NSDate    *dBlackEnd;
@property (nonatomic, assign) NSInteger points;

@end

@interface VipIntegralManager : NSObject

@property (nonatomic, strong) VipIntegralModel *model;

//单例
+ (instancetype)shareInstance;

@end



NS_ASSUME_NONNULL_END
