//
//  VipIntegralManager.m
//  jike
//
//  Created by 上海荣豫资产 on 2018/12/4.
//  Copyright © 2018 陶庭兴. All rights reserved.
//

#import "VipIntegralManager.h"

static VipIntegralManager *instance = nil;
@implementation VipIntegralManager

- (instancetype)initSingleton {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initSingleton];
        
    });
    
    return instance;
    
}

- (void)setModel:(VipIntegralModel *)model{
    
    if (model) {
        NSData *dataInformation = [NSKeyedArchiver archivedDataWithRootObject:model];
        [[NSUserDefaults standardUserDefaults] setObject:dataInformation forKey:keyVipModel];
    }
    
}

- (VipIntegralModel *)model{
    
    id userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:keyVipModel];
    if (userInfo && [userInfo isKindOfClass:[NSData class]]) {
        VipIntegralModel   *vip = (VipIntegralModel *)[NSKeyedUnarchiver unarchiveObjectWithData:userInfo];
        return vip;
    }
    return nil;
}

@end

@implementation VipIntegralModel



@end
