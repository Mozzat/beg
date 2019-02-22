//
//  VoiceAuthorManager.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/21.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "VoiceAuthorManager.h"
#import "RecorderVC.h"
#import <AVFoundation/AVFoundation.h>

@implementation VoiceAuthorManager

+ (void)showVoiceManager:(UIViewController *)viewController{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
        {
            //第一次提示用户授权
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                
                if (granted) {
                    
                    [self performSelectorOnMainThread:@selector(openRecorderVC:) withObject:viewController waitUntilDone:NO];
                    
                }
                
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:
        {
            //通过授权
            [self openRecorderVC:viewController];
            
            break;
        }
        case AVAuthorizationStatusRestricted:
            //不能授权
            NSLog(@"不能完成授权，可能开启了访问限制");
        case AVAuthorizationStatusDenied:{
            
            UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"访问麦克风" message:@"您还没有打开麦克风权限" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"去打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了取消");
            }];
            
            [alertViewController addAction:action1];
            [alertViewController addAction:action2];
            
            //相当于之前的[actionSheet show];
            [viewController presentViewController:alertViewController animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

+ (void)openRecorderVC:(UIViewController *)vc{
    
    RecorderVC *recorder = [[RecorderVC alloc]init];
    [vc.navigationController pushViewController:recorder animated:NO];
    
}

@end
