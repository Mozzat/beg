//
//  GrabOrderCommentView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/25.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GrabOrderWriteAction)(void);

@interface GrabOrderCommentView : UIView

@property (nonatomic, copy) GrabOrderWriteAction writeAction;

@end

NS_ASSUME_NONNULL_END
