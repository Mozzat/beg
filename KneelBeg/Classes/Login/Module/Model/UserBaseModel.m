//
//  UserModel.m
//  jike
//
//  Created by 上海荣豫资产 on 2018/6/4.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import "UserBaseModel.h"

@implementation UserBaseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    NSDictionary *dic=@{@"userId" :@"id"};
    
    return dic;
    
}

- (void)setNickname:(NSString *)nickname{
    
    _nickname = nickname;
    self.cName = nickname;
    
}



@end
