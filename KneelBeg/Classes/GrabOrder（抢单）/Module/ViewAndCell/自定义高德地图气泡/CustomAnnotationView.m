//
//  CustomAnnotationView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/18.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "CustomAnnotationView.h"

#define kCalloutWidth       212.0
#define kCalloutHeight      80.0

@interface CustomAnnotationView ()

@property (nonatomic, strong, readwrite) CustomCallouView *calloutView;

@end

@implementation CustomAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    if (self.selected == selected) {
        return;
    }
    
    if (selected) {
        
        if (self.calloutView == nil) {
            
            self.calloutView = [[CustomCallouView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            self.calloutView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoDetialVC)];
            [self.calloutView addGestureRecognizer:tap];
            self.calloutView.dataDic = self.dataDic;
            
        }
        
        [self addSubview:self.calloutView];
        
    } else {
        
        [self.calloutView removeFromSuperview];
        
    }
    
    [super setSelected:selected animated:animated];
    
}


- (void)gotoDetialVC{
    
//    NSString *type = self.dataDic[@"type"];
    if (self.block) {
        self.block(self.dataDic);
    }
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _dataDic = dataDic;
    
}


@end
