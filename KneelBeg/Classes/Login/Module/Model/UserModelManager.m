//
//  UserModelManager.m
//  jike
//
//  Created by 上海荣豫资产 on 2018/6/4.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import "UserModelManager.h"

static UserModelManager *instance = nil;
@implementation UserModelManager

- (instancetype)initSingleton {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initSingleton];
        
    });
    
    return instance;
    
}

#pragma mark - setter方法
- (void)setData:(UserBaseModel *)data{
    if (data) {
        NSData *dataInformation = [NSKeyedArchiver archivedDataWithRootObject:data];
        [[NSUserDefaults standardUserDefaults] setObject:dataInformation forKey:key_userInfo];
    }
}

#pragma mark - getter方法
- (UserBaseModel *)data{
    
    id userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:key_userInfo];
    if (userInfo && [userInfo isKindOfClass:[NSData class]]) {
        UserBaseModel   *user = (UserBaseModel *)[NSKeyedUnarchiver unarchiveObjectWithData:userInfo];
        return user;
    }
    return nil;
    
    
}

+ (BOOL)userIsLogin{
    
    UserBaseModel *model = [UserModelManager shareInstance].data ;
    if (!model) {
        
        return NO;
        
    }
    
    return YES;
}

+ (NSString *)getUserId{
    
    NSString *userId =  @([UserModelManager shareInstance].data.userId).stringValue;
    return userId;
    
}

+ (void)setPhoneNum:(NSString *)phone{
    
    UserBaseModel *model = [UserModelManager shareInstance].data;
    model.cPhoneNum = [phone doubleValue];
    [UserModelManager shareInstance].data = model;
    
}

+ (NSString *)getPhoneNum{
    
    NSString *phoneNum =  @([UserModelManager shareInstance].data.cPhoneNum).stringValue;
    if ([phoneNum isEqualToString:@"0"]) {
        phoneNum = @"";
    }
    
    return phoneNum;
}

+ (NSString *)getWeiXinId{
    
    UserBaseModel *model = [UserModelManager shareInstance].data;
//    NSString *weixinId = [[NSUserDefaults standardUserDefaults] valueForKey:Cache_WX_ID];
    NSString *weixinId = model.wechatId;
    return weixinId;
    
}

+ (void)setWeixinID:(NSString *)wxId{
    
    UserBaseModel *model = [UserModelManager shareInstance].data;
    model.wechatId = wxId;
    [UserModelManager shareInstance].data = model;
    
//    [[NSUserDefaults standardUserDefaults] setValue:wxId forKey:Cache_WX_ID];
    
}

+ (NSString *)getWeiboId{
    
    UserBaseModel *model = [UserModelManager shareInstance].data;
    NSString *weiboId = model.weiboId;
//    NSString *weiboId = [[NSUserDefaults standardUserDefaults] valueForKey:Cache_WB_ID];
    return weiboId;
    
}

+ (void)setWeiBoID:(NSString *)wbId{
    
    UserBaseModel *model = [UserModelManager shareInstance].data;
    model.weiboId = wbId;
    [UserModelManager shareInstance].data = model;
//    [[NSUserDefaults standardUserDefaults] setValue:wbId forKey:Cache_WB_ID];
    
}

+ (void)setEmail:(NSString *)email{
    
    UserBaseModel *model = [UserModelManager shareInstance].data;
    model.cEmail = email;
    [UserModelManager shareInstance].data = model;
}

+ (NSString *)getEmail{
    
    NSString *email = [UserModelManager shareInstance].data.cEmail;
    return email;
    
}

+ (NSString *)getUserOrderNO{
    
    NSString *userOrderNo = [UserModelManager shareInstance].data.cUserNo;
    return userOrderNo;
    
}

+ (void)saveUserData:(NSDictionary *)dic{
    
    UserBaseModel *userModel = [UserBaseModel modelWithJSON:dic[@"data"]];
    NSDictionary *excDic = dic[@"dataExt"][@"userBinding"];
    if (![excDic isKindOfClass:[NSNull class]]) {
        userModel.wechatId = [Util isBlankString:excDic[@"wechatId"]] ? @"": excDic[@"wechatId"];
        userModel.weiboId = [Util isBlankString:excDic[@"weiboId"]] ? @"": excDic[@"weiboId"];
    }
    
    NSDictionary *userDic = dic[@"dataExt"][@"userInfo"];
    if (![userDic isKindOfClass:[NSNull class]]) {
        
        userModel.cName = userDic[@"cName"];
        userModel.cSex = userDic[@"cSex"];
        userModel.cSign = userDic[@"cSign"];
        userModel.provinceId = userDic[@"provinceId"];
        userModel.cityId = userDic[@"cityId"];
        userModel.cHeadImage = userDic[@"cHeadImage"];
    }
    [UserModelManager shareInstance].data = userModel;
    
}

@end
