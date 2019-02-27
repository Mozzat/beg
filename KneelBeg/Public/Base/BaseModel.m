//
//  BaseModel.m
//  BDSAAS
//
//  Created by ebadu on 2017/2/14.
//  Copyright © 2017年 深圳市八度云计算信息技术有限公司. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel


#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        unsigned int outCount;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *strPropertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            NSString *strPropertyPrivateName = [@"_" stringByAppendingString:strPropertyName];
            id idDecoderValue = [aDecoder decodeObjectForKey:strPropertyName];
            if (idDecoderValue) {
                //NSLog(@"%@:%@", strPropertyPrivateName, idDecoderValue);
                [self setValue:idDecoderValue forKeyPath:strPropertyPrivateName];
            }
        }
        
        free(properties);
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *strPropertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id idValue = [self valueForKey:strPropertyName];
        if (idValue) {
            //NSLog(%@"%@:%@", strPropertyName, idValue);
            //            NSLog(@"%@",strPropertyName);
            [aCoder encodeObject:idValue forKey:strPropertyName];
        }
    }
    
    free(properties);
}

+ (NSDictionary *)modelCustomPropertyMapper {
    
    NSDictionary *dic=@{@"ID" :@"id"
                        };
    
    return dic;
    
}

@end
