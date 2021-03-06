//
//  TextFieldInputView.h
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/11.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TextFieldEndInputBlock)(NSString *text);

@interface TextFieldInputView : UIView

@property (nonatomic, copy) TextFieldEndInputBlock endBlock;

@property (nonatomic, weak) UITextView  *textView;

@end

NS_ASSUME_NONNULL_END
