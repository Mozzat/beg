//
//  HttpNetworkManager.m
//  NetWorking
//
//  Created by lwj on 2018/4/25.
//  Copyright © 2018年 lwj. All rights reserved.
//

#import "HttpNetworkManager.h"
#import "ProgressHUDView.h"
#import <AFNetworking/AFNetworking.h>
#import "inlineDefine.h"
#import <ProgressHUD/ProgressHUD.h>

#ifdef DEBUG

#define NSLog( s, ... ) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] );

#else

#define NSLog( s, ... )

#endif

@implementation UpLoadFileModel

@end

@implementation HttpNetworkManager

+ (void)requestMethedWithType:(HttpNetworkManagerType)type WithIsFile:(BOOL)isFile WithUrl:(NSString *)url WithParametr:(NSMutableDictionary *)parameter WithFileArray:(NSArray *)fileArray  WithSuccessBlock:(HttpRequestSuccessBlock)sueessBlock WithFaileBlock:(HttpRequestFaileureBlock)faileBlock{
    
    if (!isFile) {
        
        if (type == Post) {
            
//            [HttpNetworkManager postRequestWithUrl:url WithParametr:parameter WithFileArray:fileArray WithSuccessBlock:sueessBlock WithFaileBlock:faileBlock];
            [HttpNetworkManager postRequestWithUrl:url WithParametr:parameter WithSuccessBlock:sueessBlock WithFaileBlock:faileBlock];
            
        } else {
            
            [HttpNetworkManager getRequestWithUrl:url WithParametr:parameter WithSuccessBlock:sueessBlock WithFaileBlock:faileBlock];
            
        }
        
    } else {
        
        [HttpNetworkManager postRequestWithUrl:url WithParametr:parameter WithFileArray:fileArray WithSuccessBlock:sueessBlock WithFaileBlock:faileBlock];
        
    }
    
}

+ (void)getRequestWithUrl:(NSString *)url WithParametr:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)sueessBlock WithFaileBlock:(HttpRequestFaileureBlock)faileBlock{
    
    ///状态栏菊花
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
    
    [manager GET:GetUrl(url) parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
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

+ (void)postRequestWithUrl:(NSString *)url WithParametr:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)sueessBlock WithFaileBlock:(HttpRequestFaileureBlock)faileBlock{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // 1.设置非校验证书模式
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    
    [manager POST:GetUrl(url) parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *err;
        NSDictionary *dic = nil;
        if ([responseObject isKindOfClass:[NSData class]]) {
            dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dic = responseObject;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if (dic) {
                
                NSError *error;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
                NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
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

+ (void)postRequestWithUrl:(NSString *)url WithParametr:(NSMutableDictionary *)parameter WithFileArray:(NSArray *)fileArray  WithSuccessBlock:(HttpRequestSuccessBlock)sueessBlock WithFaileBlock:(HttpRequestFaileureBlock)faileBlock{
    
    [ProgressHUD show:@"上传中"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
    // 1.设置非校验证书模式
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    
    [manager POST:GetUrl(url) parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (UpLoadFileModel *fileModel in fileArray) {
            
            [formData appendPartWithFileData:fileModel.data name:fileModel.file fileName:fileModel.fileName mimeType:fileModel.mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [ProgressHUD showSuccess:@"上传成功"];
        [ProgressHUD dismiss];
        NSError *err;
        NSDictionary *dic = nil;
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dic = responseObject;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if (dic) {
            
                NSLog(@"返回的数据:===%@",dic);
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
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"响应信息====%@===",response);
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

#pragma mark -- url 是否有效
+ (BOOL)validateURL:(NSString *) url
{
    NSString* number=@"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:url];
}

@end
