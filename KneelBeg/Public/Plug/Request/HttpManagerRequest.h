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
 订单收藏或者取消

 @param orderNo 订单号
 @param handle 1 收藏 0 取消
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)getCollectionActionWithOrderNo:(NSString *)orderNo WithHandle:(BOOL)handle WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;

/**
 根据订单编号查询普通订单的信息

 @param orderNo 订单编号
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)getCommentOrderDataWithOrderNo:(NSString *)orderNo WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 接单处理

 @param orderNo 订单编号
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)acceptOrderWithOrderNo:(NSString *)orderNo WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;

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


/**
 查询评论列表

 @param parameter 参数
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)getCommentListData:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 查询评论总数
 
 @param parameter 参数
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)getCommentCount:(NSMutableDictionary *)parameter WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 评论点赞或者取消

 @param commentId 评论id
 @param handle 点赞或取消
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)commentLikeOrDislike:(NSString *)commentId WithHandle:(BOOL)handle WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 添加评论

 @param orderNo 订单编号
 @param message 消息
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)addCommentDataWithOrderNo:(NSString *)orderNo WithMessage:(NSString *)message WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 对评论进行回复

 @param message 消息
 @param type 类型 1对顶级评论进行回复 1 2.对回复的回复2
 @param commentId 顶级n评论的id
 @param replayId 回复id type = 1 replyid = 0
 @param successBlock 成功回调h
 @param failBlock 失败回调
 */
+ (void)addReplyCommentDataWithMessage:(NSString *)message WithType:(NSInteger)type WithCommentId:(NSInteger)commentId WithReplayId:(NSInteger)replayId WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 回复点赞

 @param replyId 回复id
 @param handle  取消
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)replyCommentLikeOrDislike:(NSString *)replyId WithHandle:(BOOL)handle WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 根据评论id查询回复

 @param commentId 评论id
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)selectByCommentId:(NSInteger)commentId WithPage:(NSInteger)page WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;


/**
 根据评论id查询评论本省

 @param commentId 评论id
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)selectByCommentId:(NSInteger)commentId WithSuccessBlock:(HttpRequestSuccessBlock)successBlock WithFailBlock:(HttpRequestFaileureBlock)failBlock;

@end
