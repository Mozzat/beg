//
//  TagView.m
//  CustomTag
//
//  Created by za4tech on 2017/12/15.
//  Copyright © 2017年 Junior. All rights reserved.
//

#import "TagView.h"
#define kScreenWidth      [UIScreen mainScreen].bounds.size.width

@interface TagView ()

@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation TagView

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    CGFloat marginX = 10;
    CGFloat marginY = 10;
    CGFloat height = 30;
    UIButton * markBtn;
    for (int i = 0; i < _arr.count; i++) {
        
        NSDictionary *dic = _arr[i];
        NSString *title = dic[@"cValue"];
        CGFloat width =  [self calculateString:title Width:12] +height;
        UIButton * tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (!markBtn) {
            tagBtn.frame = CGRectMake(marginX, marginY, width, height);
        }else{
            if (markBtn.frame.origin.x + markBtn.frame.size.width + marginX + width + marginX > 220 ) {
                tagBtn.frame = CGRectMake(marginX, markBtn.frame.origin.y + markBtn.frame.size.height + marginY, width, height);
            }else{
                tagBtn.frame = CGRectMake(markBtn.frame.origin.x + markBtn.frame.size.width + marginX, markBtn.frame.origin.y, width, height);
            }
        }
        [tagBtn setTitle:title forState:UIControlStateNormal];
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [tagBtn setTitleColor:HexColor(@"9b9b9b") forState:UIControlStateNormal];
        [tagBtn setTitleColor:HexColor(@"f3364e") forState:UIControlStateSelected];
        [tagBtn setBackgroundColor:HexColor(@"ebebeb")];
        tagBtn.tag = 1133 + i;
//        [self makeCornerRadius:4 borderColor:HexColor(@"ebebeb") layer:tagBtn.layer borderWidth:1];
        [tagBtn rounded:4];
        markBtn = tagBtn;
        
        [tagBtn addTarget:self action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];
        tagBtn.userInteractionEnabled = YES;
        
        if (i == 0) {
            
            tagBtn.selected = YES;
            self.selectBtn = tagBtn;
            tagBtn.backgroundColor = HexColor(@"fdd7dc");
            
        }
        
        [self addSubview:markBtn];
    }
    CGRect rect = self.frame;
    rect.size.height = markBtn.frame.origin.y + markBtn.frame.size.height + marginY;
    self.frame = rect;
}


-(void)clickTo:(UIButton *)sender
{
    
    if (sender == self.selectBtn) {
        
        return;
        
    }
    
    if ([self.delegate respondsToSelector:@selector(handleSelectTag:)]) {
        
        self.selectBtn.backgroundColor = HexColor(@"ebebeb");
        self.selectBtn.selected = NO;
        sender.selected = !sender.selected;
        self.selectBtn = sender;
        
        if (sender.selected) {
            sender.backgroundColor = HexColor(@"fdd7dc");
            
        } else {
            sender.backgroundColor = HexColor(@"ebebeb");
            
        }
        
        NSInteger count = sender.tag - 1133;
        NSDictionary *dic = self.arr[count];
        [self.delegate handleSelectTag:dic];
    }
}



-(void)makeCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor layer:(CALayer *)layer borderWidth:(CGFloat)borderWidth
{
    layer.cornerRadius = radius;
    layer.masksToBounds = YES;
    layer.borderColor = borderColor.CGColor;
    layer.borderWidth = borderWidth;
}

-(CGFloat)calculateString:(NSString *)str Width:(NSInteger)font
{
    CGSize size = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 100, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return size.width;
}

@end
