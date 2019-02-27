//
//  HttpManagerRequest.h
//  NetWorking
//
//  Created by lwj on 2018/4/25.
//  Copyright © 2018年 lwj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MZTNetWorking/HttpNetworkManager.h>
#import "APIName.h"

@interface HttpManagerRequest : NSObject


/**
 查询发单词汇

 @param successBlock 成功回调
 @param failBlock 失败回调
 */
- (void)getOrderWordWithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;

@end
