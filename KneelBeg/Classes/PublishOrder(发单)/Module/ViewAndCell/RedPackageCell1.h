//
//  RedPackageCell1.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/21.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RedPackageCell1Block)(NSString *str, NSInteger row);
NS_ASSUME_NONNULL_BEGIN

@interface RedPackageCell1 : UITableViewCell

@property (nonatomic, copy) NSString  *titleS;
@property (nonatomic, copy) NSString  *rightS;
@property (nonatomic, copy) NSString  *placeHolder;

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, copy)   RedPackageCell1Block block;

@end

NS_ASSUME_NONNULL_END
