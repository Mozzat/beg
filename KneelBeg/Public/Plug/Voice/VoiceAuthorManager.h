//
//  VoiceAuthorManager.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/21.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <Foundation/Foundation.h>

///授权
typedef void(^PermissGrandted)(void);
///没有授权
typedef void(^NotPermissGrandted)(void);
NS_ASSUME_NONNULL_BEGIN

@interface VoiceAuthorManager : NSObject

+ (void)showVoiceManager:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
