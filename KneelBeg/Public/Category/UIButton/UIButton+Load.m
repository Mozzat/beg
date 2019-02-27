//
//  UIButton+Load.m
//  jike
//
//  Created by 上海荣豫资产 on 2018/8/23.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import "UIButton+Load.h"

@implementation UIButton (Load)

- (void)loadImageViewWithImageString:(NSString *)imageUrl WithPlaceHoldeImage:(NSString *)imageStr forState:(UIControlState)state{
    
    NSString *currentImageStr = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [self sd_setImageWithURL:[NSURL URLWithString:currentImageStr] forState:state placeholderImage:[UIImage imageNamed:imageStr] completed:nil];
    
}

@end
