//
//  AppKey.h
//  jike
//
//  Created by taotingxing on 2018/5/15.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//  配置key

#ifndef AppKey_h
#define AppKey_h

#pragma mark---返回值
static NSString *successKey = @"1";
static NSString *kPageSize = @"10";

#pragma mark---缓存的微信 微博id
static NSString *Cache_WX_ID = @"Cache_WX_ID";
static NSString *Cache_WB_ID = @"Cache_WB_ID";

#pragma mark---urlscheml
static NSString *urlScheml = @"com.geekerx.www";

#pragma mark---bugly
static NSString *BuglyAppID = @"e710aa91b6";

#pragma mark---友盟
static NSString *UMengAppKey = @"5b03d4fdb27b0a469e0000fd";

#pragma mark---微信
static NSString *WX_Appid = @"wx93043d9b62a58c02";

static NSString *WX_Secret = @"f3c25991fa1bd17ca69f094900434428";

static NSString *WX_Schemes = @"JKWXPay123";

#pragma mark---微博
static NSString *wb_Appid = @"2788477519";

static NSString *wb_secret = @"acb7c2f7632c6f28e5564942f14cb971";

#pragma mark---登录
static NSString *key_userInfo = @"key_userInfo";
static NSString *userInfo = @"userInfo";
static NSString *wxLogin = @"3";
static NSString *wbLogin = @"5";
static NSString *kUserLogin = @"kUserLogin";

#pragma mark---会员
static NSString *keyVipModel = @"keyVipModel";
static NSString *kCommon = @"COMMON";

#pragma amrk---极光
static NSString *kJPushKey = @"d48b27f481e086ac2039ef15";
static NSString *kJPushChannelKey = @"www.geekerx.com";

#pragma mark---通知key
static NSString *kPay_Success_Key = @"pay_success";
static NSString *kPay_Fail_Key = @"pay_faiCOMMENT_PRODUCT_IMAGEl";
static NSString *kPay_Cancle_Key = @"pay_cancle";

#pragma mark---优惠券
static NSString *kUser_Coupon_Key = @"User_Coupon";

#pragma mark---任务
///评论
static NSString *kComment_Product_Key = @"COMMENT_PRODUCT";
///评论COMMENT_PRODUCT_IMAGE带图
static NSString *kComment_Product_Image_Key = @"COMMENT_PRODUCT_IMAGE";
///注册
static NSString *kReist_Key = @"REGISTER";
///绑定手机号
static NSString *kBinding_Phone_Number_Key = @"BINDING_PHONE_NUMBER";
///绑定维信
static NSString *kBunding_Wechat_Key = @"BINDING_WECHAT";
///购买
static NSString *kShopping_Key = @"SHOPPING";
///体现
static NSString *kWithDraw_Key = @"WITHDRAW";
///完成个人任务
static NSString *kImprove_Personal_Info_Key = @"IMPROVE_PERSONAL_INFO";
///完成
static NSString *kMission_Complete_Key = @"MISSION_COMPLETED";
///分享
static NSString *kDaily_Share_Key = @"DAILY_SHARE";
///签到
static NSString *kSign_Key = @"SIGN_IN";

#pragma mark---高德地图key
static NSString *kAMap_Key = @"2892d6039ab6f390c9831ac12721ef3a";

#endif /* AppKey_h */
