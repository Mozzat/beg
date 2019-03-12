//
//  HttpNetworkManager+LBS.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/28.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "HttpNetworkManager+LBS.h"
#import "ProgressHUDView.h"
#import <AFNetworking/AFNetworking.h>
#import "inlineDefine.h"
#import <ProgressHUD/ProgressHUD.h>

@implementation HttpNetworkManager (LBS)

+ (void)getLBSCloudDataWithUrl:(NSString *)url WithParametr:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)sueessBlock WithFaileBlock:(HttpRequestFaileureBlock)faileBlock{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    ///get请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.0f;
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 1.设置非校验证书模式
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    
    [manager GET:GetUrl1(url) parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err;
        
        NSLog(@"请求报文:%@",task.response);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (dic) {
                
                NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"返回的数据:===%@",jsonStr);
                if (sueessBlock) {
                    sueessBlock(dic);
                }
            } else {
                if (faileBlock) {
                    faileBlock(@"数据异常");
                }
            }
            
            if (err) {
                if (faileBlock) {
                    @try {
                        faileBlock(err.localizedDescription);
                    }
                    @catch (NSException *exception) {
                        faileBlock(@"网络异常!");
                    }
                    @finally {
                        
                    }
                }
            }
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ProgressHUDView showErrorMessage:@"您的网络异常~"];
        NSLog(@"错误日志+++++%@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            // 在状态栏关闭有网络请求的提示器
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (faileBlock) {
                @try {
                    faileBlock(error.localizedDescription);
                }
                @catch (NSException *exception) {
                    faileBlock(@"解析异常!");
                }
                @finally {
                    
                }
            }
        });
        
    }];
    
}

@end
