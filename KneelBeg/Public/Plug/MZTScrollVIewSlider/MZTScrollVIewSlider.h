//
//  MZTScrollVIewSlider.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/25.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MZTScrollVIewSlider : UIView

@property (nonatomic, strong) NSArray *data;

@end

@interface MZTScrollView : UIScrollView

@property (nonatomic, strong) NSArray *imageArr;
@end

NS_ASSUME_NONNULL_END
