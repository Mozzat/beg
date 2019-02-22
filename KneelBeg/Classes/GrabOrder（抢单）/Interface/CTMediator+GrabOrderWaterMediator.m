//
//  CTMediator+GrabOrderWaterMediator.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/18.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "CTMediator+GrabOrderWaterMediator.h"

NSString *const kCTMediaTargetShop = @"GrabOrderWater";
NSString *const kCTMediatorShopVC = @"gotoGrabOrderWaterViewController";

@implementation CTMediator (GrabOrderWaterMediator)

- (BaseViewController *)grabOrderWaterMediatorWithParame:(NSDictionary *)parame{
    
    BaseViewController *viewController = [self performTarget:kCTMediaTargetShop action:kCTMediatorShopVC params:parame shouldCacheTarget:NO];
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[BaseViewController alloc] init];
    }
    
}

@end
