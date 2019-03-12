//
//  UserModel.h
//  jike
//
//  Created by 上海荣豫资产 on 2018/6/4.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import "BaseModel.h"

@interface UserBaseModel : BaseModel

@property (nonatomic, assign) double userId;
@property (nonatomic, strong) NSString *credentialsSalt;
@property (nonatomic, strong) NSString *cHeadImage;
@property (nonatomic, assign) NSInteger cPhoneNum;
@property (nonatomic, assign) double nCheckState;
//@property (nonatomic, assign) id cCheckBy;
//@property (nonatomic, assign) id cUpdateBy;
//@property (nonatomic, assign) id cLoginIp;
@property (nonatomic, strong) NSString *cUsername;
@property (nonatomic, strong) NSString *cPassword;
@property (nonatomic, strong) NSString *cEmail;
@property (nonatomic, strong) NSString *cIden;
@property (nonatomic, strong) NSString *cSalt;
@property (nonatomic, strong) NSString *cName;
@property (nonatomic, strong) NSString *dDate;
@property (nonatomic, strong) NSString *cSign;
@property (nonatomic, copy)   NSString *cSex;
@property (nonatomic, copy)   NSString *cUserNo;
@property (nonatomic, strong) NSDate *dLoginDate;
@property (nonatomic, strong) NSDate *dCheckTime;
@property (nonatomic, strong) NSDate *dUpdateTime;

@property (nonatomic, assign) double sex;
@property (nonatomic, assign) double subscribe;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *unionId;
@property (nonatomic, assign) id subscribeTime;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *openId;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *privilege;
@property (nonatomic, strong) NSString *headImgUrl;
@property (nonatomic, assign) BOOL     isThird;

@property (nonatomic, copy)   NSString *wechatId;
@property (nonatomic, copy)   NSString *weiboId;
@property (nonatomic, copy)   NSString *cTradeCode; ///行业
@property (nonatomic, copy)   NSString *area;
@property (nonatomic, copy)   NSString *cityId;
@property (nonatomic, copy)   NSString *cBirthday;
@property (nonatomic, copy)   NSString *provinceId;
@property (nonatomic, copy)   NSString *trade;

///vip会员
@property (nonatomic, copy)   NSString *cVipType;
@property (nonatomic, copy)   NSString *cVipName;
@property (nonatomic, assign) NSInteger nVipOrder;
@property (nonatomic, assign) NSInteger nVipGrowthValue;

///黑钻会员
@property (nonatomic, copy)   NSString *cBlackType;
@property (nonatomic, copy)   NSString *cBlackName;
@property (nonatomic, assign) NSInteger nBlackOrder;
@property (nonatomic, strong) NSDate    *dBlackEnd;
@property (nonatomic, assign) NSInteger points;

@end
