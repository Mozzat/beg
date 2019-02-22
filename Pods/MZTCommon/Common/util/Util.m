//
//  Util.m
//  jike
//
//  Created by taotingxing on 2018/5/15.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import "Util.h"
#import "AppKey.h"

@implementation Util

///创建按钮
+ (UIButton *)buttonWithTitle:(NSString *)title WithFont:(UIFont *)font WihtImageName:(NSString *)imageName WithTextColor:(UIColor *)textColor{
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
    
}

///创建label
+ (UILabel *)labelWithTitle:(NSString *)title WithFont:(UIFont *)font WithTextColor:(UIColor *)textColor{
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = textColor;
    label.text = title;
    label.font =font;
    return label;
    
}

+ (NSMutableAttributedString *)mutableStringWithTitle:(NSString *)titleStr WithString1:(NSString *)string1 WithString2:(NSString *)string2 WithAttrDic1:(NSDictionary *)dic1 WithAttrDic2:(NSDictionary *)dic2{
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:titleStr];
    NSRange range1=[[aString string]rangeOfString:string1];
    [aString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
    [aString setAttributes:dic1 range:range1];
    NSRange range2=[[aString string]rangeOfString:string2];
    [aString setAttributes:dic2 range:range2];
    return aString;
    
}

+ (NSMutableAttributedString *)mutableStringWithTitle:(NSString *)titleStr WithString1:(NSString *)string1  WithAttrDic1:(NSDictionary *)dic1{
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:titleStr];
    NSRange range1=[[aString string]rangeOfString:string1];
    [aString setAttributes:dic1 range:range1];
    
    return aString;
    
}

+ (BOOL)iSMobilePhone:(NSString *)phoneNum{
    
    NSString *MOBILE = @"^1[3-9]\\d{9}$";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    BOOL isOK = [regextestmobile evaluateWithObject:phoneNum];
    
    return isOK;
    
}

//判断身份证号是否正确
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

//密码长度在6到15个字符
+(BOOL)isLoginPassword:(NSString *)password{
    
    if (password.length >= 6 && password.length <= 15) {
        return YES;
    }
    return NO;
}

+ (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
    }
    
    return NO;
}

+ (NSString *)CountReturnString:(NSInteger)num{
    
    NSString *numString = nil;
    if (num < 1000) {
        numString = @(num).stringValue;
        
    } else if ( 1000< num && num < 10000) {
        
        float count = num/1000.0;
        numString = [NSString stringWithFormat:@"%.1fk",count];
        
    } else if (num >= 10000) {
        
        float count = num/10000.0;
        numString = [NSString stringWithFormat:@"%.1fw",count];
    }
    
    return numString;
}

///时间
+ (NSString *)returnTimeStringWithDate:(NSDate *)date WithFormaterType:(NSString *)formaterString{
    
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.locale = [NSLocale currentLocale];
    formater.dateFormat = formaterString;
    NSString *timeStr = [formater stringFromDate:date];
    return timeStr;
    
}

+ (BOOL)jundgeDateIsAfter:(NSString *)date{
    
    NSString *date1 = [date stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *date2 = [Util returnTimeStringWithDate:[NSDate date] WithFormaterType:@"yyyyMMdd"];
    
    NSInteger count1 = [date1 integerValue];
    NSInteger count2 = [date2 integerValue];
    
    if (count1 <= count2) {
        return YES;
    }
    
    return NO;
    
}

//+ (NSString *)returnHeadImageStr:(NSString *)headStr{
//
//    NSString *headStr1 = nil;
//    if ([BaseUrl containsString:@"www.geekerx"]) {
//        headStr1 = [NSString stringWithFormat:@"http://47.100.41.160:8686/images%@",headStr];
//
//    } else {
//        headStr1 = [NSString stringWithFormat:@"http://192.168.50.194:8686/images%@",headStr];
//    }
//
//    return headStr1;
//
//}

///时间戳转提示字符串
- (NSString *)timeBeforeInfoWithString:(NSTimeInterval)timeIntrval{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //获取此时时间戳长度
    NSTimeInterval nowTimeinterval = [[NSDate date] timeIntervalSince1970];
    int timeInt = nowTimeinterval - timeIntrval; //时间差
    
    int year = timeInt / (3600 * 24 * 30 *12);
    int month = timeInt / (3600 * 24 * 30);
    int day = timeInt / (3600 * 24);
    int hour = timeInt / 3600;
    int minute = timeInt / 60;

    if (year > 0) {
        return [NSString stringWithFormat:@"%d年以前",year];
    }else if(month > 0){
        return [NSString stringWithFormat:@"%d个月以前",month];
    }else if(day > 0){
        return [NSString stringWithFormat:@"%d天以前",day];
    }else if(hour > 0){
        return [NSString stringWithFormat:@"%d小时以前",hour];
    }else if(minute > 0){
        return [NSString stringWithFormat:@"%d分钟以前",minute];
    }else{
        return [NSString stringWithFormat:@"刚刚"];
    }
}

+ (NSString *)dateBeforeInfoWithString:(NSDate *)date{
    
    NSTimeInterval timeIntrval = [date timeIntervalSince1970];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    //获取此时时间戳长度
    NSTimeInterval nowTimeinterval = [[NSDate date] timeIntervalSince1970];
    int timeInt = nowTimeinterval - timeIntrval; //时间差
    
    int year = timeInt / (3600 * 24 * 30 *12);
    int month = timeInt / (3600 * 24 * 30);
    int day = timeInt / (3600 * 24);
    int hour = timeInt / 3600;
    int minute = timeInt / 60;

    if (year > 0 || month > 0 || day > 0) {
        return [dateFormatter stringFromDate:date];
        
    }else if(hour > 0){
        return [NSString stringWithFormat:@"%d小时以前",hour];
    }else if(minute > 0){
        return [NSString stringWithFormat:@"%d分钟以前",minute];
    }else{
        return [NSString stringWithFormat:@"刚刚"];
    }
    
}

///获取json的状态
+ (NSString *)getJsonResultState:(NSDictionary *)dic{
    
    return [dic[@"status"] stringValue];
    
}

///获取json的总数
+ (NSInteger)getJsonTotlaCount:(NSDictionary *)dic{
    
    return [dic[@"data"][@"total"] integerValue];
    
}

///获取json的是否是最后一页
+ (BOOL)getJsonIsLastPage:(NSDictionary *)dic{
    
    return [dic[@"data"][@"isLastPage"] boolValue];
    
}

///获取json的数组
+ (NSArray *)getJsonArray:(NSDictionary *)dic{
    
    NSArray *arr = dic[@"data"][@"list"];
    NSMutableArray *arr1 = [NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
        
        if (![dic isKindOfClass:[NSNull class]]) {
            
            [arr1 addObject:dic];
            
        }
    }
    NSArray *arr2 = [arr1 mutableCopy];
    
    return arr2;
    
}

+ (BOOL)returnResultStateIsRight:(NSDictionary *)dic{
    
    NSString *resultState = [Util getJsonResultState:dic];
    if ([resultState isEqualToString:successKey]) {
        
        return YES;
        
    }
    
    return NO;
    
}

+ (NSString *)getJsonMessage:(NSDictionary *)dic{
    
    NSString *message = dic[@"message"];
    return message;
    
}

+ (NSArray *)removeDuplicateArr1:(NSArray *)modelData WithArr2:(NSMutableArray *)modelData1{
    
//    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
//    for (BaseModel *model in modelData1) {
//        [mutableDic setObject:model forKey:@(model.ID).stringValue];
//
//    }
//
//    for (BaseModel *model in modelData) {
//        [mutableDic setObject:model forKey:@(model.ID).stringValue];
//
//    }
//
//    NSArray *dataArr = [mutableDic allValues];
//    NSSortDescriptor *timeSD = [NSSortDescriptor sortDescriptorWithKey:@"ID" ascending:NO];
//    NSArray *resultArr = [dataArr sortedArrayUsingDescriptors:@[timeSD]];
//    NSArray *resultArr = [dataArr sortedArrayUsingComparator:^NSComparisonResult(BaseModel *obj1, BaseModel *obj2) {
//
//        NSString *compareId = @(obj1.ID).stringValue;
//        NSString *compareId1 = @(obj2.ID).stringValue;
//        return [compareId1 compare:compareId];
//
//    }];
    return @[];
    
}

//+ (BaseNavigationController *)getCurrentNavigationVC{
//
//    MainTabBarVC *tabbar = (MainTabBarVC *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    return tabbar.selectedViewController;
//
//}

//+ (BaseViewController *)getCurrentVC
//{
//    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
//
//    BaseViewController *currentVC = [self getCurrentVCFrom:rootViewController];
//
//    return currentVC;
//}

//+ (BaseViewController *)getCurrentVCFrom:(UIViewController *)rootVC
//{
//    BaseViewController *currentVC;
//
//    if ([rootVC presentedViewController]) {
//        // 视图是被presented出来的
//
//        rootVC = [rootVC presentedViewController];
//    }
//
//    if ([rootVC isKindOfClass:[UITabBarController class]]) {
//        // 根视图为UITabBarController
//
//        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
//
//    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
//        // 根视图为UINavigationController
//
//        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
//
//    } else {
//        // 根视图为非导航类
//
//        currentVC = rootVC;
//    }
//
//    return currentVC;
//}

+ (BOOL)isValidateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

+ (int)getRandomNumber:(int)from to:(int)to{
    
    return (int)(from + (arc4random() % ((to - from )+ 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
    
}

+ (NSData *)compressWithOrgImg:(UIImage *)img{
    
    CGSize imageSize = img.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280 && height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280 && height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280 && height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [img drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length> 2 * 1024*1024) {//2M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-2M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 1);
        }
    }
    return data;

}

+ (NSData *)compressWithOrgImgData:(NSData *)imgData{
    
    UIImage *image = [[UIImage alloc]initWithData:imgData];
    NSData *data =  [Util compressWithOrgImg:image];
    return data;
    
}

+ (BOOL)compareTimeWithDate:(NSDate *)date{
    
    NSTimeInterval dateTime = [date timeIntervalSince1970];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    
    return dateTime > nowTime ? YES : NO ;
    
}

+ (BOOL)compareOrderTimeWithDate:(NSDate *)date{
    
    NSTimeInterval dateTime = [date timeIntervalSince1970] + 1800;
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    
    return dateTime > nowTime ? YES : NO ;
    
}

+ (NSString *)calculatRemindTime:(NSDate *)date{
    
    NSTimeInterval dateTime = [date timeIntervalSince1970];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    
    NSTimeInterval count = dateTime - nowTime;
    NSInteger hour = count / 3600;
    NSInteger min = (count - hour * 3600) /60;
    NSInteger second = count - hour * 3600 - min * 60;
    
    NSString *timeStr = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hour,min,second];
    return timeStr;
    
    
}

+ (NSString *)calculatPayOrderRemindTime:(NSDate *)date{
    
    NSTimeInterval dateTime = [date timeIntervalSince1970] + 1800;
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    
    NSTimeInterval count = dateTime - nowTime;
    NSInteger hour = count / 3600;
    NSInteger min = (count - hour * 3600) /60;
    NSInteger second = count - hour * 3600 - min * 60;
    
    NSString *timeStr = [NSString stringWithFormat:@"%02ld:%02ld",min,second];
    return timeStr;
    
}

+ (void)pasteStringToPasteBoard:(NSString *)text{
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = text;
    
}

+ (BOOL)isBlankArr:(NSArray *)arr {
    
    if (!arr) {
        return YES;
    }
    
    if ([arr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if (![arr isKindOfClass:[NSArray class]]) {
        return YES;
    }
    
    if (!arr.count) {
        return YES;
    }
    
    if (arr == nil) {
        return YES;
    }
    
    if (arr == NULL) {
        return YES;
    }
    
    return NO;
    
}


+ (BOOL)isBlankDictionary:(NSDictionary *)dic {
    
    if (!dic) {
        return YES;
    }
    
    if ([dic isKindOfClass:[NSNull class]]) {
        return YES;
    }

    if (![dic isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    
    if (!dic.count) {
        return YES;
    }
    
    if (dic == nil) {
        return YES;
    }
    
    if (dic == NULL) {
        return YES;
    }
    
    return NO;
    
}

+ (NSMutableAttributedString *)lineSpace:(float)lineSpace WithFont:(UIFont *)font WithColor:(UIColor *)textColor WithTextStr:(NSString *)text{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle,NSForegroundColorAttributeName : textColor};
    NSMutableAttributedString *attr = [Util mutableStringWithTitle:text WithString1:text WithAttrDic1:dic];
    return attr;
    
}

+ (NSMutableAttributedString *)lineSpace:(float)lineSpace WithAlignment:(NSTextAlignment)alignment WithKey:(float)keyLine WithFont:(UIFont *)font WithColor:(UIColor *)textColor WithTextStr:(NSString *)text{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
    paraStyle.lineSpacing = lineSpace; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle,NSForegroundColorAttributeName : textColor,NSKernAttributeName : @(keyLine)};
    NSMutableAttributedString *attr = [Util mutableStringWithTitle:text WithString1:text WithAttrDic1:dic];
    return attr;
    
}

+ (NSMutableAttributedString *)lineSpace:(float)lineSpace WithAlignment:(NSTextAlignment)alignment WithKey:(float)keyLine WithFont:(UIFont *)font WithColor:(UIColor *)textColor WithTextStr:(NSString *)text WithAttrS:(NSString *)attrS{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
    paraStyle.lineSpacing = lineSpace; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle,NSForegroundColorAttributeName : textColor,NSKernAttributeName : @(keyLine)};
    NSMutableAttributedString *attr = [Util mutableStringWithTitle:text WithString1:attrS WithAttrDic1:dic];
    return attr;
    
}

+ (UIImage *)addGaussianBlurWithImage:(NSString *)imageName withBlurNumber:(CGFloat)blur{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [[CIImage alloc]initWithImage:[UIImage imageNamed:imageName]];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey]; [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;

}

+ (NSInteger)getCurrentMonthDayCount{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
    
}

///获取当前年份
+ (NSInteger)getCurrentYearCount{
    
    NSDateComponents *components = [Util getDateComponents];
    return components.year;
    
}

///获取当前月份
+ (NSInteger)getCurrentMonthCount{
    
    NSDateComponents *components = [Util getDateComponents];
    return components.month;
    
}

///获取当前号数
+ (NSInteger)getCurrentDayCount{
    
    NSDateComponents *components = [Util getDateComponents];
    return components.day;
    
}

+ (NSDateComponents *)getDateComponents{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    return components;
    
}

@end
