//
//  LocationManager.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/28.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LocationManagerDelegate <NSObject>

@optional
- (void)finishLocationWithLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode;


@end

@interface LocationManager : AMapLocationManager

@property (nonatomic, weak) id locationDelegate;

///当前定位后的位置
@property (nonatomic, assign) CLLocationCoordinate2D currentCoordinaate2D;
///地址
@property (nonatomic, copy)   NSString *cLocationIntro;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
