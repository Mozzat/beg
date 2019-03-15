//
//  CTMediator+Comment.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/11.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "CTMediator+Comment.h"

NSString *const kCTMediaTargetCommment = @"Comment";
NSString *const kCTMediatorCommentVC = @"gotoCommentVC";

@implementation CTMediator (Comment)

- (UIViewController *)commentVCMediatorWithParame:(NSDictionary *)parame{
    
    UIViewController *viewController = [self performTarget:kCTMediaTargetCommment action:kCTMediatorCommentVC params:parame shouldCacheTarget:NO];
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
    
}

@end
