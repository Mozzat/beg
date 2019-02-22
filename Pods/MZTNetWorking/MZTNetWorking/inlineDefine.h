//
//  inlineDefine.h
//  NetWorking
//
//  Created by lwj on 2018/4/25.
//  Copyright © 2018年 lwj. All rights reserved.
//

#ifndef inlineDefine_h
#define inlineDefine_h  

///亮仔本地服务器地址
//static NSString *BaseUrl = @"http://192.168.70.30:8888";

///小新本地服务器地址
//static NSString *BaseUrl = @"http://192.168.70.115:8888";

///测试服务器地址
//static NSString *BaseUrl = @"http://192.168.100.150:9999";

///正式服务器
static NSString *BaseUrl = @"https://www.geekerx.com";

static inline NSString *GetUrl(NSString *path) {
    
    return  [NSString stringWithFormat:@"%@%@",BaseUrl,path];
    
}

//#define isIOS11 [[UIDevice currentDevice].systemVersion floatValue] >= 11
//
//#pragma mark---屏幕高度
////状态栏高度
//#define BDStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//#define BDNavBarHeight 44.0
////整个导航栏高度
//#define BDTopHeight (BDStatusBarHeight + BDNavBarHeight)
////底部tabbar高度
//#define BDTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
////底部需要减去的高度
//#define BDBottomHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)
/////屏幕宽度
//#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
/////屏幕高度
//#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
//
////3.弱引用/强引用
////弱引用/强引用  可配对引用在外面用MPWeakSelf(self)，block用MPStrongSelf(self)  也可以单独引用在外面用MPWeakSelf(self) block里面用weakself
//#define LRWeakSelf(type)  __weak typeof(type) weak##type = type;
//#define LRStrongSelf(type)  __strong typeof(type) type = weak##type;
//
//#pragma mark- 获取RGB颜色
//static inline UIColor *RGBCOLOR(CGFloat r,CGFloat g,CGFloat b){
//    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1];
//};
//
//static inline UIColor *RGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a){
//    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
//};
//
//static inline UIColor *HexColor(NSString *color){
//
//    color = [color stringByReplacingOccurrencesOfString:@"#" withString:@""];
//    color = [color stringByReplacingOccurrencesOfString:@" " withString:@""];
//
//    long red = strtoul([[color substringWithRange:NSMakeRange(0, 2)] UTF8String] , 0, 16);
//    long green = strtoul([[color substringWithRange:NSMakeRange(2, 2)] UTF8String] , 0, 16);
//    long blue = strtoul([[color substringWithRange:NSMakeRange(4, 2)] UTF8String] , 0, 16);
//
//    return RGBCOLOR(red, green, blue);
//};
//
//static inline UIColor *HexColorWithAlpha(NSString *color , float aphla){
//
//    color = [color stringByReplacingOccurrencesOfString:@"#" withString:@""];
//    color = [color stringByReplacingOccurrencesOfString:@" " withString:@""];
//
//    long red = strtoul([[color substringWithRange:NSMakeRange(0, 2)] UTF8String] , 0, 16);
//    long green = strtoul([[color substringWithRange:NSMakeRange(2, 2)] UTF8String] , 0, 16);
//    long blue = strtoul([[color substringWithRange:NSMakeRange(4, 2)] UTF8String] , 0, 16);
//
//    return RGBA(red, green, blue, aphla);
//};

#endif /* inlineDefine_h */
