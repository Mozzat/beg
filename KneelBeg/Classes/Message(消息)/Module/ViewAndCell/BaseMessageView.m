//
//  BaseMessageView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/14.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "BaseMessageView.h"


@implementation BaseMessageView

- (instancetype)initWithFrame:(CGRect)frame WithType:(BaseMessageType)type{
    
    if (self = [super initWithFrame:frame]) {
        
        [self initSubviews];
        self.isEdit = NO;
    }
    return self;
}

- (void)initSubviews{
    
    [self.data addObjectsFromArray:@[@"1",@"2"]];
    [self addSubview:self.tableView];
    
}

#pragma mark---懒加载
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = whiteColor();
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 97;
        
    }
    return _tableView;
}

- (NSMutableArray *)data{
    
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}


@end
