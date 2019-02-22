//
//  ProgressHUDView.h
//  NetWorking
//
//  Created by lwj on 2018/4/25.
//  Copyright © 2018年 lwj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressHUDView : NSObject

///展示失败
+ (void)showErrorMessage:(NSString *)message;

///展示成功
+ (void)showSuccessMessage:(NSString *)message;

+ (void)showProgressMessage:(NSString *)message;

+ (void)showBlackProgessMessage:(NSString *)message;

+ (void)dismiss;

//+ (void)showUploadAlert;

@end
