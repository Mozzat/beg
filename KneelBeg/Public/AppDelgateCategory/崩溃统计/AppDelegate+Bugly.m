//
//  AppDelegate+Bugly.m
//  jike
//
//  Created by 上海荣豫资产 on 2018/5/18.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import "AppDelegate+Bugly.h"
#import <Bugly/Bugly.h>

@implementation AppDelegate (Bugly)

- (void)registBuglySDK{
    
    [Bugly startWithAppId:BuglyAppID];
    
}

@end
