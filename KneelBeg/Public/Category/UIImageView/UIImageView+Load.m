//
//  UIImageView+Load.m
//  jike
//
//  Created by 上海荣豫资产 on 2018/6/5.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import "UIImageView+Load.h"
#import <SDWebImage/UIImageView+WebCache.h>
//#import <YYKit/YYWebImageManager.h>

@implementation UIImageView (Load)

- (void)loadImageViewWithImageString:(NSString *)imageUrl WithPlaceHoldeImage:(NSString *)imageStr{
    
    if (![Util isBlankString:imageUrl]) {
        
        NSString *currentImageStr = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self sd_setImageWithURL:[NSURL URLWithString:currentImageStr] placeholderImage:[UIImage imageNamed:imageStr] options: SDWebImageProgressiveDownload];
        
    } else {
        
        self.image = [UIImage imageNamed:imageStr];
        
    }
    
}

@end
