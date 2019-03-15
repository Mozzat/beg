//
//  MessageSystemView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/14.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "MessageSystemView.h"

@interface MessageSystemView ()<UITableViewDelegate,UITableViewDataSource>

@end

static NSString *cellId = @"MessageSystemView";

@implementation MessageSystemView

- (instancetype)initWithFrame:(CGRect)frame WithType:(BaseMessageType)type{
    
    if (self = [super initWithFrame:frame WithType:type]) {
        
        [self.tableView registerClass:[BaseMessageCell class] forCellReuseIdentifier:cellId];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

#pragma mark---<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[BaseMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    return cell;
    
}

@end
