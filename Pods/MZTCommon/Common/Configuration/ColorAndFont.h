//
//  ColorAndFont.h
//  jike
//
//  Created by taotingxing on 2018/5/16.
//  Copyright © 2018年 陶庭兴. All rights reserved.
//

#ifndef ColorAndFont_h
#define ColorAndFont_h
#import "InlineDefault1.h"

///字体颜色
static inline UIColor *greenColor() {
    
    return HexColor(@"28c8aa");
    
}

static inline UIColor *redColor() {
    
    return HexColor(@"E74467");
    
}

static inline UIColor *redColorAlpha() {
    
    return RGBA(231, 68, 103, 0.8);
    
}

static inline UIColor *organColor(){
    
    return HexColor(@"EEB251");
    
}

static inline UIColor *whiteColor(){
    
    return UIColor.whiteColor;
    
}

static inline UIColor *blackColor() {
    
    return HexColor(@"373737");
    
}

static inline UIColor *Color4B(){
    
    return HexColor(@"4b4b4b");
    
}

static inline UIColor *Color4A(){
    
    return HexColor(@"4a4a4a");
    
}

static inline UIColor *lineColor() {
    
    return HexColor(@"f5f5f5");
    
}

static inline UIColor *grayColor() {
    
    return HexColor(@"9b9b9b");
    
}

static inline UIColor *B9Color() {
    
    return HexColor(@"b9b9b9");
    
}

static inline UIColor *F5Color(){
    
    return HexColor(@"f5f5f5");
    
}

static inline UIColor *blackBgColor(){
    
    return HexColor(@"1e1e1e");
    
}

static inline UIColor *GoldColor() {
    
    return HexColor(@"D4BA7C");

}

///字号

static inline UIFont *Font48() {
    
    return [UIFont systemFontOfSize:48];
    
}

static inline UIFont *Font36() {
    
    return [UIFont systemFontOfSize:36];
    
}

static inline UIFont *Font32() {
    
    return [UIFont systemFontOfSize:32];
    
}

static inline UIFont *Font28() {
    
    return [UIFont systemFontOfSize:28];
    
}

static inline UIFont *Font26() {
    
    return [UIFont systemFontOfSize:26];
    
}

static inline UIFont *Font22() {
    
    return [UIFont systemFontOfSize:22];
    
}

static inline UIFont *Font24() {
    
    return [UIFont systemFontOfSize:24];
    
}

static inline UIFont *Font18() {
    
    return [UIFont systemFontOfSize:18];
    
}

static inline UIFont *Font16() {
    
    return [UIFont systemFontOfSize:16];
    
}

static inline UIFont *Font15() {
    
    return [UIFont systemFontOfSize:15];
    
}

static inline UIFont *Font14() {
    
    return [UIFont systemFontOfSize:14];
    
}

static inline UIFont *Font12() {
    
    return [UIFont systemFontOfSize:12];
    
}

static inline UIFont *Font11() {
    
    return [UIFont systemFontOfSize:11];
    
}

static inline UIFont *Font10() {
    
    return [UIFont systemFontOfSize:10];
    
}

#pragma mark----特殊字体 汉仪力量
static inline UIFont *HYFont(NSInteger font) {
    
    return [UIFont fontWithName:@"HYLiLiangHeiJ" size:font];
    
}

#pragma mark---汉仪瑞意宋
static inline UIFont *HYRYSFont(NSInteger font) {
    
    return [UIFont fontWithName:@"HYRuiYiSongW" size:font];
    
}

#pragma mark---加粗
static inline UIFont *BlodFont(NSInteger font) {
  
    return [UIFont fontWithName:@"Helvetica-Bold" size:font];
    
};

#endif /* ColorAndFont_h */
