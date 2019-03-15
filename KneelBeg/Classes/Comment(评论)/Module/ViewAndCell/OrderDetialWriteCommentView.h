//
//  OrderDetialWriteCommentView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/12.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WriteCommentFinishBlock)(NSString *message);
NS_ASSUME_NONNULL_BEGIN

@interface OrderDetialWriteCommentView : UIControl

@property (nonatomic, copy) WriteCommentFinishBlock writeBlock;

- (void)showAnimation;

- (void)hideAnimation;

@end

NS_ASSUME_NONNULL_END
