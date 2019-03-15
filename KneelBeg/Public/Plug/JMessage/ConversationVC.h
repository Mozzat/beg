//
//  ConversationVC.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/13.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "BaseViewController.h"
#import <JMessage/JMessage.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConversationVC : BaseViewController

@property (strong, nonatomic)JMSGConversation *conversation;

@end

NS_ASSUME_NONNULL_END
