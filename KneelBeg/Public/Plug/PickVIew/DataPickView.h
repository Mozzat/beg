//
//  DataPickView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/4.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DataPickViewBlock)(NSString *title);
NS_ASSUME_NONNULL_BEGIN

@interface DataPickView : UIControl

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy)   DataPickViewBlock block;

- (void)startAnimation;

- (void)hideAnimation;

@end

NS_ASSUME_NONNULL_END
