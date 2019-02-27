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
static NSString *BaseUrl = @"http://192.168.100.150:8812";

///正式服务器
//static NSString *BaseUrl = @"https://www.geekerx.com";

static inline NSString *GetUrl(NSString *path) {
    
    return  [NSString stringWithFormat:@"%@%@",BaseUrl,path];
    
}


#endif /* inlineDefine_h */
