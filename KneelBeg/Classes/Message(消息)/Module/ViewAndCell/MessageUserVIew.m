//
//  MessageUserVIew.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/14.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "MessageUserVIew.h"
#import "BaseMessageCell1.h"
#import <JMessage/JMessage.h>

@interface MessageUserVIew ()<UITableViewDelegate,UITableViewDataSource,JMessageDelegate>

@end

static NSString *cellId = @"MessageUserVIew";

@implementation MessageUserVIew

- (instancetype)initWithFrame:(CGRect)frame WithType:(BaseMessageType)type{
    
    if (self = [super initWithFrame:frame WithType:type]) {
        
        [self.data removeAllObjects];
        [self.tableView registerClass:[BaseMessageCell1 class] forCellReuseIdentifier:cellId];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [JMessage addDelegate:self withConversation:nil];
        [self getAllConversionList];
        
    }
    return self;
}

#pragma mark---<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseMessageCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (self.data.count) {
        cell.conversation= self.data[indexPath.row];
    }
    
    return cell;
    
}

- (void)getAllConversionList{
    
    [JMSGConversation allConversations:^(id resultObject, NSError *error) {
        if (!error) {
            NSArray *conversationList = (NSArray *)resultObject;
            [self.data removeAllObjects];
            self.data = [NSMutableArray arrayWithArray:conversationList];
            [self.tableView reloadData];
//            [self.listTableView reloadData];
        } else {
//            [JMSGTools showResponseResultWithInfo:@"get all conversation list error" error:error];
        }
    }];
    
}

- (void)onReceiveMessage:(JMSGMessage *)message error:(NSError *)error{
    [self getAllConversionList];
}

@end
