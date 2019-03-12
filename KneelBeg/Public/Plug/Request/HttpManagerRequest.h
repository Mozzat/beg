//
//  HttpManagerRequest.h
//  NetWorking
//
//  Created by lwj on 2018/4/25.
//  Copyright © 2018年 lwj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIName.h"
#import <MZTNetWorking/HttpNetworkManager.h>

@interface HttpManagerRequest : NSObject

#pragma mark---登录注册
/**
 获取验证码
 
 @param phoneNum 手机号
 @param sueessBlock 成功回调
 @param faileBlock 失败回调
 */
+ (void)getPhoneVirCodeWithPhoneNum:(NSString *)phoneNum WithSuccessBlock:(HttpRequestSuccessBlock)sueessBlock WithFaileBlock:(HttpRequestFaileureBlock)faileBlock;

/**
 用户验证码登录
 
 @param parameter 参数
 @param sueessBlock 成功回调
 @param faileBlock 失败回调
 */
+ (void)UserVirCodeLoginWithParameter:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)sueessBlock WithFaileBlock:(HttpRequestFaileureBlock)faileBlock;

#pragma mark---订单
/**
 获取lbs数据

 @param parameter 参数
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)getLBSDataWithParameter:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 发布订单

 @param parameter 参数
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)publishOrderWithParameter:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 查询发单词汇

 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)publishOrderWithWordsWithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 查询发单词汇

 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)publishRedPacketWithWordsWithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 根据orderNo查询红包详情

 @param orderNo 订单标号
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)getRedPacketDataWithOrderNo:(NSString *)orderNo WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 抢红包

 @param parameter 参数
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)grabRedPacketWithParameter:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 红包列表

 @param orderNo 订单id
 @param successBlock 成功回调
 @param failBlock 是吧回调
 */
+ (void)redPacketListWithORderNo:(NSString *)orderNo WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 获取我的红包记录

 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)getMyRedPacketListWithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;
/**
 上传订单图片

 @param imageArr 图片数组
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)uploadOrderImageWithArr:(NSArray *)imageArr WithSort:(NSInteger)sort WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 上传语音

 @param audioPath 语音路径
 @param sort 排序
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)uploadOrderAudioWithArr:(NSString *)audioPath WithSort:(NSInteger)sort WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;

@end
