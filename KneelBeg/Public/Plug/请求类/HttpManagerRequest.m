//
//  HttpManagerRequest.m
//  NetWorking
//
//  Created by lwj on 2018/4/25.
//  Copyright © 2018年 lwj. All rights reserved.
//

#import "HttpManagerRequest.h"

@implementation HttpManagerRequest

- (void)getOrderWordWithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [HttpNetworkManager requestMethedWithType:Get WithIsFile:NO WithUrl:GetUrl(VOC_ReleaseOrder_API) WithParametr:parameter WithFileArray:@[] WithSuccessBlock:successBlock WithFaileBlock:failBlock];
    
}

@end
