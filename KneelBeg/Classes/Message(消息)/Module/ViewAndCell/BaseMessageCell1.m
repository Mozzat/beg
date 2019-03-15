//
//  BaseMessageCell1.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/14.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "BaseMessageCell1.h"

@implementation BaseMessageCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setConversation:(JMSGConversation *)conversation{
    
    _conversation = conversation;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    
    if (_conversation) {
    
        if (_conversation.conversationType == kJMSGTransMessageTypeSingle) {

//            JMSGUser *user = (JMSGUser *)conversation.target;
            self.titleLab.text = [NSString stringWithFormat:@"^%@",conversation.title];
        }
        
    }
    
    self.subTitleLab.text = conversation.latestMessageContentText;
    
}

@end
