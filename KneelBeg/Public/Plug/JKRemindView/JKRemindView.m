//
//  JKRemindView.m
//  jike
//
//  Created by 上海荣豫资产 on 2018/5/29.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#import "JKRemindView.h"

@implementation JKRemindView

+ (void)showReminderString:(NSString *)reminderStr{
    
    UILabel *comentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 0.75 * SCREEN_WIDTH - 40, 20)];
    comentLabel.font = Font14();
    comentLabel.textColor = [UIColor whiteColor];
    comentLabel.numberOfLines = 0;
    comentLabel.backgroundColor = blackColor();
    comentLabel.text = reminderStr;
    [comentLabel sizeToFit];
    
    CGFloat x = (SCREEN_WIDTH - 40 - comentLabel.width)/2.0;
    CGFloat y = 44;
    CGFloat width = comentLabel.width + 40;
    CGFloat height = comentLabel.height + 20;
    
    JKRemindView *commentRemind = [[JKRemindView alloc]initWithFrame:CGRectMake(x, y , width, height)];
    commentRemind.layer.cornerRadius = commentRemind.height/2.0;
    commentRemind.layer.masksToBounds = YES;
    [commentRemind addSubview:comentLabel];
    commentRemind.backgroundColor = blackColor();
    commentRemind.alpha = 0.5;
    
    [[UIApplication sharedApplication].delegate.window addSubview:commentRemind];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        commentRemind.y = 84;
        commentRemind.alpha = 1;
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.5 animations:^{
            
            commentRemind.y = 44;
            commentRemind.alpha = 0.5;
            
        } completion:^(BOOL finished) {
            
            [commentRemind removeFromSuperview];
            
        }];
        
    });
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
