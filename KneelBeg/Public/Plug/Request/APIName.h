//
//  APIName.h
//  NetWorking
//
//  Created by lwj on 2018/4/25.
//  Copyright © 2018年 lwj. All rights reserved.
//

#ifndef APIName_h
#define APIName_h

static NSString *User_Info_API = @"/apis/msmy/user-info/user-info";

///获取验证码
static NSString *getVirCode = @"/Sms/sendMs";

///用户注册接口
static NSString *User_Regist_API = @"/Shiro/register";

///注册时验证验证码
static NSString *User_ValidateCaptcha_API = @"/Shiro/validateCaptcha";

///用户密码登录
//static NSString *User_Login_API = @"/Shiro/login";
static NSString *User_Login_API = @"/Shiro/loginMulti";

///使用验证码登录
//static NSString *User_LoginWithCaptcha_API = @"/Shiro/loginWithCaptcha";
static NSString *User_LoginWithCaptcha_API = @"/Shiro/loginWithCaptchaType";

///判断用户是否存在
static NSString *User_IsUserExisted_API = @"/User/isUserExisted";

///忘记密码
static NSString *User_ForgotPassword_API = @"/User/forgotPassword";

///修改密码
static NSString *User_ModifyPassword_API = @"/User/modifyPassword";

///登出
static NSString *User_Logout_API = @"/Shiro/logout";
///
static NSString *Product_Home_API = @"/ProductCategory/index";

///添加绑定信息
static NSString *UserBinding_Add_API = @"/UserBinding/add";

///解除绑定信息
static NSString *UserBinding_Delete_API = @"/UserBinding/delete";

///第三方登录
static NSString *Shiro_LoginByThirdParty_API = @"/Shiro/loginByThirdPartyToken";

///发送邮件
static NSString *Email_sendEmail_API = @"/Email/sendEmail";

#pragma mark----app版本信息
static NSString *Config_GetIOSInformation_API = @"/Config/getIOSInformation";

#pragma mark---支付宝支付
///获取支付宝sign
static NSString *AliPay_API = @"/Pay/doAlipay";

///支付
static NSString *Pay_Pay_API = @"/Pay/doPay";
///开通超级会员支付
static NSString *Pay_DoPayBody_API = @"/Pay/doPayBody";

#pragma mark---查询订单
static NSString *Datasearch_Around_API = @"/datasearch/around";

///发布订单
static NSString *Order_Release_API = @"/order/release";

///发单详情页词汇
static NSString *Voc_ReleaseOrder_API = @"/voc/releaseOrder";

///红包详情页词汇
static NSString *Voc_ReleaseRedPacket_API = @"/voc/releaseRedPacket";

///根据订单编号查询红包详情
static NSString *RedPacketc_QueryDetail_API = @"/redPacket/queryDetail";

///抢红包
static NSString *RedPacketc_Get_API = @"/redPacket/get";

///查看红包领取详情
static NSString *RedPacketc_QueryGetDetail_API = @"/redPacket/queryGetDetail";

///我的红包
static NSString *RedPacketc_MyRedPacketRecord_API = @"/redPacket/myRedPacketRecord";

#pragma mark---上传文件
static NSString *File_UploadFile_API = @"/File/uploadFile";

static NSString *File_UploadFileBatch_API = @"/File/uploadFileBatch";

#endif /* APIName_h */
