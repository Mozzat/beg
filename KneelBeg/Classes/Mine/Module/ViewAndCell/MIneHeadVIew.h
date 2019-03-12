//
//  MIneHeadVIew.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/12.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^headLoginBlock)(void);

@interface MIneHeadVIew : UIView

@property (nonatomic, copy) headLoginBlock block;

@end

NS_ASSUME_NONNULL_END
