//
//  Util.h
//  jike
//
//  Created by taotingxing on 2018/5/15.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Util : NSObject

///创建按钮
+ (UIButton *)buttonWithTitle:(NSString *)title WithFont:(UIFont *)font WihtImageName:(NSString *)imageName WithTextColor:(UIColor *)textColor;

///创建label
+ (UILabel *)labelWithTitle:(NSString *)title WithFont:(UIFont *)font WithTextColor:(UIColor *)textColor;


/**
 字符串富文本颜色

 @param titleStr 字符串
 @param string1 字符串1
 @param string2 字符串2
 @param dic1 样式1
 @param dic2 样式2
 @return 处理后的字符串
 */
+ (NSMutableAttributedString *)mutableStringWithTitle:(NSString *)titleStr WithString1:(NSString *)string1 WithString2:(NSString *)string2 WithAttrDic1:(NSDictionary *)dic1 WithAttrDic2:(NSDictionary *)dic2;

+ (NSMutableAttributedString *)mutableStringWithTitle:(NSString *)titleStr WithString1:(NSString *)string1  WithAttrDic1:(NSDictionary *)dic1;

/**
 判断手机号是否正确

 @param phoneNum 手机号
 @return YES NO
 */
+ (BOOL)iSMobilePhone:(NSString *)phoneNum;

//判断身份证是否正确
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;

//密码长度在6到15个字符
+(BOOL)isLoginPassword:(NSString *)password;

//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;

///数量单位转换
+ (NSString *)CountReturnString:(NSInteger)num;

//+ (NSString *)returnHeadImageStr:(NSString *)headStr;

#pragma mark---时间转换
+ (NSString *)returnTimeStringWithDate:(NSDate *)date WithFormaterType:(NSString *)formaer;

///时间戳转提示文字
//+ (NSString *)timeBeforeInfoWithString:(NSTimeInterval)timeIntrval;

+ (NSString *)dateBeforeInfoWithString:(NSDate *)date;

///获取json的状态
+ (NSString *)getJsonResultState:(NSDictionary *)dic;

///获取json的总数
+ (NSInteger)getJsonTotlaCount:(NSDictionary *)dic;

///获取json的是否是最后一页
+ (BOOL)getJsonIsLastPage:(NSDictionary *)dic;

///获取json的数组
+ (NSArray *)getJsonArray:(NSDictionary *)dic;

///判断后台返回的接口的状态
+ (BOOL)returnResultStateIsRight:(NSDictionary *)dic;

///获取json返回的message
+ (NSString *)getJsonMessage:(NSDictionary *)dic;

///判断时间与当前时间对比
+ (BOOL)jundgeDateIsAfter:(NSString *)date;

///去重
+ (NSArray *)removeDuplicateArr1:(NSArray *)modelData WithArr2:(NSMutableArray *)modelData1;

///获取当前控制器的导航栏控制器
+ (UINavigationController *)getCurrentNavigationVC;

///获取邮箱地址
+ (BOOL)isValidateEmail:(NSString *)email;


///获取一个随机整数，范围在[from,to），包括from，不包括to
+ (int)getRandomNumber:(int)from to:(int)to;

///图片压缩
+ (NSData *)compressWithOrgImg:(UIImage *)img;


/**
 图片压缩传入的是个二进制数据流

 @param imgData 数据流
 @return 数据流
 */
+ (NSData *)compressWithOrgImgData:(NSData *)imgData;


/**
 获取当前控制器

 @return 当前控制器
 */
//+ (BaseViewController *)getCurrentVC;


/**
 和当前时间作比较

 @param date 时间
 @return yes or no
 */
+ (BOOL)compareTimeWithDate:(NSDate *)date;

/**
 订单时间和当前时间作比较
 
 @param date 时间
 @return yes or no
 */
+ (BOOL)compareOrderTimeWithDate:(NSDate *)date;

/**
 计算剩余时间

 @param date 时间
 @return 时间
 */
+ (NSString *)calculatRemindTime:(NSDate *)date;


/**
 计算订单剩余时间

 @param date 时间
 @return 时间
 */
+ (NSString *)calculatPayOrderRemindTime:(NSDate *)date;


/**
 复制到剪切板

 @param text 文字
 */
+ (void)pasteStringToPasteBoard:(NSString *)text;


/**
 判断字典是否为空

 @param dic 字典
 @return yes 为空 no 不为空
 */
+ (BOOL)isBlankDictionary:(NSDictionary *)dic;


/**
 行间距

 @param lineSpace 行高
 @param textColor 颜色
 @return 富文本
 
 */
+ (NSMutableAttributedString *)lineSpace:(float)lineSpace WithFont:(UIFont *)font WithColor:(UIColor *)textColor WithTextStr:(NSString *)text;


/**
 设置行间距字间距

 @param lineSpace 行间距
 @param keyLine 字间距
 @param font 字号
 @param textColor 文字颜色
 @param text 文字
 @return 富文本文字
 */
+ (NSMutableAttributedString *)lineSpace:(float)lineSpace WithAlignment:(NSTextAlignment)alignment WithKey:(float)keyLine WithFont:(UIFont *)font WithColor:(UIColor *)textColor WithTextStr:(NSString *)text;


/**
 设置行间距

 @param lineSpace 行间距
 @param keyLine 字间距
 @param font 字号
 @param textColor 文字颜色
 @param text 文字
 @param attrS 需要样式的文字
 @return 富文本文字
 */
+ (NSMutableAttributedString *)lineSpace:(float)lineSpace WithAlignment:(NSTextAlignment)alignment WithKey:(float)keyLine WithFont:(UIFont *)font WithColor:(UIColor *)textColor WithTextStr:(NSString *)text WithAttrS:(NSString *)attrS;

/**
 添加高斯模糊

 @param imageName 图片名称
 @param blur 高斯模糊度
 @return 图片
 */
+ (UIImage *)addGaussianBlurWithImage:(NSString *)imageName withBlurNumber:(CGFloat)blur;

///获取当前月份天数
+ (NSInteger)getCurrentMonthDayCount;

///获取当前年份
+ (NSInteger)getCurrentYearCount;

///获取当前月份
+ (NSInteger)getCurrentMonthCount;

///获取当前号数
+ (NSInteger)getCurrentDayCount;

@end
