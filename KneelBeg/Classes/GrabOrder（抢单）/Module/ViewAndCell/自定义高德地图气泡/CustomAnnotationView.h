//
//  CustomAnnotationView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/18.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCallouView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) CustomCallouView *calloutView;

@end

NS_ASSUME_NONNULL_END
