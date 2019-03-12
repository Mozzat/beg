//
//  LocationManager.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/28.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager ()<AMapLocationManagerDelegate>

@end

static LocationManager *locationManager = nil;
@implementation LocationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initLocationManager];
        
    }
    return self;
}

///初始化定位
- (void)initLocationManager{
    
    self.distanceFilter = 100;
    self.delegate = self;
    self.locatingWithReGeocode = YES;
    
}

+ (instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[LocationManager alloc] init];
    });
    
    return locationManager;
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"locationManager :{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    self.currentCoordinaate2D = location.coordinate;
    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
        self.cLocationIntro = reGeocode.formattedAddress;
        
    }
    
    if (self.locationDelegate && [self.locationDelegate respondsToSelector:@selector(finishLocationWithLocation:reGeocode:)]) {
        
        [self.locationDelegate finishLocationWithLocation:location reGeocode:reGeocode];
        
    }
    
}


@end
