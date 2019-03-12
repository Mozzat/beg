//
//  UserModelManager.h
//  jike
//
//  Created by 上海荣豫资产 on 2018/6/4.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserBaseModel.h"

@interface UserModelManager : NSObject

@property (nonatomic, copy)     UserBaseModel       *data;

//单例
+ (instancetype)shareInstance;

///判断用户是否登录
+ (BOOL)userIsLogin;

///获取用户的id
+ (NSString *)getUserId;

///设置手机号
+ (void)setPhoneNum:(NSString *)phone;

///获取手机号
+ (NSString *)getPhoneNum;

///获取微信id
+ (NSString *)getWeiXinId;

///设置微信id
+ (void)setWeixinID:(NSString *)wxId;

///获取微博id
+ (NSString *)getWeiboId;

///设置微博ID
+ (void)setWeiBoID:(NSString *)wbId;

///设置邮箱
+ (void)setEmail:(NSString *)email;

///获取邮箱地址
+ (NSString *)getEmail;

///获取用户唯一标识
+ (NSString *)getUserOrderNO;


/**
 保存用户信息

 @param dic 数据
 */
+ (void)saveUserData:(NSDictionary *)dic;

@end
