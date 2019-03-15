//
//  BaseMessageCell.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/14.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseMessageCell : BaseTableViewCell

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, assign) BOOL         isEditing;

@property (nonatomic, strong ) UIImageView  *headImageV;
@property (nonatomic, strong)  UILabel      *titleLab;
@property (nonatomic, strong)  UILabel      *subTitleLab;
@property (nonatomic, strong)  UILabel      *timeLab;
@property (nonatomic, strong)  UIButton     *circieBtn;

@end

NS_ASSUME_NONNULL_END
