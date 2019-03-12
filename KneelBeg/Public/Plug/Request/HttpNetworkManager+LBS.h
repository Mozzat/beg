//
//  HttpNetworkManager+LBS.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/28.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "HttpNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HttpNetworkManager (LBS)


/**
 获取本地lbs云服务

 @param url utl
 @param parameter 参数
 @param sueessBlock 成功回调
 @param faileBlock 失败回调
 */
+ (void)getLBSCloudDataWithUrl:(NSString *)url WithParametr:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)sueessBlock WithFaileBlock:(HttpRequestFaileureBlock)faileBlock;

@end

NS_ASSUME_NONNULL_END
