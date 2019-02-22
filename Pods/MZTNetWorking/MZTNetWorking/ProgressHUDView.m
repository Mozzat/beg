//
//  ProgressHUDView.m
//  NetWorking
//
//  Created by lwj on 2018/4/25.
//  Copyright © 2018年 lwj. All rights reserved.
//

#import "ProgressHUDView.h"
#import "ProgressHUD.h"

@implementation ProgressHUDView

+ (void)showErrorMessage:(NSString *)message{
    
    [ProgressHUD showError:message];
    
}

+ (void)showSuccessMessage:(NSString *)message{
    
    [ProgressHUD showSuccess:message];
    
}

+ (void)showProgressMessage:(NSString *)message{
    
    [ProgressHUD show:message];
    
}

+ (void)showBlackProgessMessage:(NSString *)message{
    
    [ProgressHUD show:message];
    [ProgressHUD backgroundColor:UIColor.redColor];
    
}

+ (void)dismiss{
    
    [ProgressHUD dismiss];
    
}

@end
