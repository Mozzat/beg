//
//  PublishOrderLineView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/20.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , PublishOrderLineType) {
    
    PublishOrderLineTypeInput = 0 ,///输入
    PublishOrderLineTypeTap = 1 ///点击
    
};
NS_ASSUME_NONNULL_BEGIN

@interface PublishOrderLineView : UIControl


/**
 创建填写控件

 @param frame frame
 @param type 类型
 @return 对象
 */
-(instancetype)initWithFrame:(CGRect)frame WithType:(PublishOrderLineType)type;


/**
 设置标题

 @param title 标题
 */
- (void)setTitles:(NSString *)title;


/**
 文字颜色

 @param content 内容
 @param textColor 文字颜色
 */
- (void)setContent:(NSString *)content WithTextColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
