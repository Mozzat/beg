//
//  AppDelegate+AMapService.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/15.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "AppDelegate+AMapService.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@implementation AppDelegate (AMapService)

- (void)registAMapServiceAction{
    
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = kAMap_Key;
    
}

@end
