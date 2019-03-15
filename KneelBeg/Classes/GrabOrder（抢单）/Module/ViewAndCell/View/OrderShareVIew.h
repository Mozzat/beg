//
//  OrderShareVIew.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/25.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OrderShareViewCommentBlock)(void);

@interface OrderShareVIew : UIView

@property (nonatomic, copy) OrderShareViewCommentBlock commentBlock;

@property (nonatomic, copy) NSString *nForward;
@property (nonatomic, copy) NSString *nCollect;
@property (nonatomic, copy) NSString *nMsgCount;

@end

NS_ASSUME_NONNULL_END
