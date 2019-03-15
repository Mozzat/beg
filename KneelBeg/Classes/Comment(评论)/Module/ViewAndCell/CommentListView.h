//
//  CommentListView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/11.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapClickAction)(NSDictionary *dic);
NS_ASSUME_NONNULL_BEGIN

@interface CommentListView : UIControl

@property (nonatomic, copy)   NSString *orderNo;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, copy)   TapClickAction tapClick;

- (void)startAnimation;

- (void)hideAnimation;

@end

NS_ASSUME_NONNULL_END
