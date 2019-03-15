//
//  TextFieldInputView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/3/11.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "TextFieldInputView.h"
#import "UITextView+Placeholder.h"

@interface TextFieldInputView ()<UITextViewDelegate>

@property (nonatomic, assign) float     keyboardHeight;
@property (nonatomic, assign) float     lastTextHeight;

@end

@implementation TextFieldInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
        
        [self initSubviews];
        
    }
    return self;
}


- (void)initSubviews{
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = lineColor();
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(1);
        
    }];
    
    self.backgroundColor = whiteColor();
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(20, (67 - 35)/2.0 , SCREEN_WIDTH - 100, 35)];
    self.textView = textView;
    textView.textColor = blackColor();
    textView.font =Font15();
    textView.backgroundColor = HexColor(@"f5f5f5");
    [textView rounded:17.5];
    textView.placeholder = @"回复xxx:";
    textView.delegate = self;
    textView.returnKeyType = UIReturnKeyDone;
    textView.delegate = self;
    [self addSubview:textView];
    
//    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self).offset(16);
//        make.left.equalTo(self).offset(20);
//        make.right.equalTo(self).offset(-80);
//        make.height.mas_equalTo(35);
//        make.bottom.equalTo(self).offset(-16);
//
//    }];
    
    UIButton *emojyBtn = [[UIButton alloc]init];
    [emojyBtn setImage:[UIImage imageNamed:@"键盘表情"] forState:UIControlStateNormal];
    [emojyBtn addTarget:self action:@selector(changeKeyBoardAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:emojyBtn];
    
    [emojyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(23);
        make.right.equalTo(self).offset(30);
        make.width.height.mas_equalTo(25);
        
    }];
    
}

- (void)changeKeyBoardAction:(UIButton *)btn{
    
//    if (btn.selected) {
//        self.textView.keyboardType = UIkeyboardty
//    }
    
}

#pragma mark----监听键盘
- (void)keyboardAction:(NSNotification *)sender{
    
    // 通过通知对象获取键盘frame: [value CGRectValue]
    NSDictionary *useInfo = [sender userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // <注意>具有约束的控件通过改变约束值进行frame的改变处理
    if([sender.name isEqualToString:UIKeyboardWillShowNotification]){
        
        self.y = SCREENH_HEIGHT  - BDBottomHeight - 67 - [value CGRectValue].size.height;
        self.keyboardHeight = [value CGRectValue].size.height;
        
    }else{
         
        self.y = SCREENH_HEIGHT  - BDBottomHeight - 67;
        self.keyboardHeight = 0 ;
    }

}

-(void)textViewDidChange:(UITextView *)textView{

    static CGFloat maxHeight =60.0f;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(SCREEN_WIDTH - 100, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    
    if (size.height<=frame.size.height) {
        
//        size.height=frame.size.height;
        frame.size.height = size.height;
        
    }else{
        
        if (size.height >= maxHeight)
        {
            size.height = maxHeight;
            textView.scrollEnabled = YES;   // 允许滚动
        }
        else
        {
            textView.scrollEnabled = NO;    // 不允许滚动
        }
    }
    
    if ([Util isBlankString:textView.text]) {
        
        size.height = 35;
        
    }
    
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    self.frame = CGRectMake(0, SCREENH_HEIGHT - BDBottomHeight - self.keyboardHeight - (size.height + 32), SCREEN_WIDTH, size.height + 32);
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        
        if (![Util isBlankString:textView.text]) {
            
            [self endEditing:YES];
            
            if (self.endBlock) {
                self.endBlock(textView.text);
            }
            
        }
        
        return NO;
    }
    return YES;
}

@end
