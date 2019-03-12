
//
//  OrderDetialWriteCommentView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/12.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "OrderDetialWriteCommentView.h"
#import "TextFieldInputView.h"

@interface OrderDetialWriteCommentView ()

@property (nonatomic, strong) TextFieldInputView  *inputTextView;

@end

@implementation OrderDetialWriteCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self addSubview:self.inputTextView];
    }
    return self;
}

#pragma mark---懒加载
- (TextFieldInputView *)inputTextView{
    
    if (!_inputTextView) {
        _inputTextView = [[TextFieldInputView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 67)];
        
    }
    return _inputTextView;
}

- (void)showAnimation{
    
    self.hidden = NO;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       
        self.inputTextView.y = SCREENH_HEIGHT - BDBottomHeight - 67;
        
    } completion:^(BOOL finished) {
        
        [self.inputTextView.textView resignFirstResponder];
        
    }];
    
}

- (void)hideAnimation{
    
    [self.inputTextView endEditing:YES];
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       
        self.inputTextView.y = SCREENH_HEIGHT;
        
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
        
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hideAnimation];
    
}

@end
