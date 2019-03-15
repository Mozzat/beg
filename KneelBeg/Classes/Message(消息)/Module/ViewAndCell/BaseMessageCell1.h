//
//  BaseMessageCell1.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/14.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "BaseMessageCell.h"
#import <JMessage/JMessage.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseMessageCell1 : BaseMessageCell

@property (nonatomic, strong) JMSGConversation *conversation;

@end

NS_ASSUME_NONNULL_END
