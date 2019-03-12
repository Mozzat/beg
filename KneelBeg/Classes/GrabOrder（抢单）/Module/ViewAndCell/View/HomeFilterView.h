//
//  HomeFilterView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/8.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//  筛选

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface HomeFilterView : UIControl

@property (nonatomic, strong) NSArray *data;

@end

@interface HomeFilterSubviews : UIView

@property (nonatomic, copy) NSString *titleS;
@property (nonatomic, assign) NSInteger currentValue;
@property (nonatomic, assign) NSInteger totalValue;

@end

@interface HomeFilterBtnView : UIView

@property (nonatomic, strong) NSArray   *data;

@end

NS_ASSUME_NONNULL_END
