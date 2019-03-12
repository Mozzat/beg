//
//  PublishPayMethedView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/4.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PayTypeMethodBlock)(NSDictionary *dic);
NS_ASSUME_NONNULL_BEGIN

@interface PublishPayMethedView : UIControl

@property (nonatomic, copy)   NSString *titleS;
@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy)   PayTypeMethodBlock bloack;

@end

NS_ASSUME_NONNULL_END
