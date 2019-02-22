//
//  Target_GrabOrderWater.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/18.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "Target_GrabOrderWater.h"
#import "GrabOrderWaterFallVC.h"

@implementation Target_GrabOrderWater

- (BaseViewController *)Action_gotoGrabOrderWaterViewController:(NSDictionary *)params{
    
    GrabOrderWaterFallVC *water = [[GrabOrderWaterFallVC alloc]init];
    return water;
    
}

@end
