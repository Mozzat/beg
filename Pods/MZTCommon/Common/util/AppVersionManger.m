//
//  AppVersionManger.m
//  jike
//
//  Created by 上海荣豫资产 on 2018/7/23.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import "AppVersionManger.h"
//#import "HttpManagerRequest.h"

@implementation AppVersionManger

+ (void)checkAppVersion{
    
//    [HttpManagerRequest getAppVersionDataWithSuccessBlock:^(id result) {
//
//        NSDictionary *dic = (NSDictionary *)result;
//        if ([Util getJsonResultState:dic]) {
//
//            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//            // 本地app版本
//            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//            ///web app版本
//            NSString *web_Version = dic[@"data"][@"version"];
//
//            NSInteger app_VersionCount = [[app_Version stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
//            NSInteger web_VersionCount = [[web_Version stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
//
//            NSString *update = dic[@"data"][@"update"];
//
//            if (app_VersionCount < web_VersionCount) {
//
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"有新版本，去更新" message:nil preferredStyle:UIAlertControllerStyleAlert];
//
//                if ([update isEqualToString:@"Y"]) { ///强制更新
//
//                    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E5%87%A0%E5%85%8B/id1395028172?mt=8"]];
//
//                    }];
//                    [alert addAction:sureAction];
//
//                } else {
//
//                    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleDefault handler:nil];
//
//                    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E5%87%A0%E5%85%8B/id1395028172?mt=8"]];
//
//                    }];
//                    [alert addAction:cancleAction];
//                    [alert addAction:sureAction];
//
//                }
//
//                [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
//
//            }
//
//
//
//        }
//        
//    } WithFaileBlock:^(id result) {
//
//    }];
    
}

@end
