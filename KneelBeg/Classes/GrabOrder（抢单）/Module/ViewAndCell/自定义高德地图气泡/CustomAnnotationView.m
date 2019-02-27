//
//  CustomAnnotationView.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/18.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "GrabDetialVC.h"
#import "BaseNavigationController.h"
#import "TabBarVC.h"

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
            
            
        }
        
        [self addSubview:self.calloutView];
        
    } else {
        
        [self.calloutView removeFromSuperview];
        
    }
    
    [super setSelected:selected animated:animated];
    
}

- (void)gotoDetialVC{
    
    TabBarVC *tabbar = (TabBarVC *)[UIApplication sharedApplication].keyWindow.rootViewController;
    GrabDetialVC *detial = [[GrabDetialVC alloc]init];
    detial.hidesBottomBarWhenPushed = YES;
    BaseNavigationController *nav = (BaseNavigationController *)tabbar.selectedViewController;
    [nav pushViewController:detial animated:YES];
    
}


@end
