//
//  BaseMessageView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/14.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMessageCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , BaseMessageType){
    
    BaseMessageViewTypeOrder = 1,
    BaseMessageViewTypeTrad = 2,
    BaseMessageViewTypeSystem = 3,
    BaseMessageViewTypeUser  = 4
    
};

@interface BaseMessageView : UIView

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) BOOL           isEdit;

- (instancetype)initWithFrame:(CGRect)frame WithType:(BaseMessageType)type;

@end

NS_ASSUME_NONNULL_END
