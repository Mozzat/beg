//
//  GrabOrderWaterFlowLayout.m
//  KneelBeg
//
//  Created by 上海荣豫资产 on 2019/2/18.
//  Copyright © 2019 上海荣豫资产. All rights reserved.
//

#import "GrabOrderWaterFlowLayout.h"

@interface GrabOrderWaterFlowLayout ()

/** 记录每个cell的初始y值 */
@property (nonatomic, strong) NSDictionary * attrsDic;

@end

@implementation GrabOrderWaterFlowLayout

#pragma mark 懒加载
- (NSDictionary *)attrsDic{
    
    if (!_attrsDic) {
        _attrsDic = [[NSMutableDictionary alloc]init];
        
    }
    return _attrsDic;
}

///初始化
- (void)prepareLayout{
    
    [super prepareLayout];
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    UICollectionViewLayoutAttributes *attr1 = arr[0];
    UICollectionViewLayoutAttributes *attr2 = arr[1];
    CGFloat margin = 10;
    
    CGFloat y0 = 0;
    CGFloat y1 = 0;
    
    if (attr1.indexPath.item > 0) {
        
        
        y0 = [[self.attrsDic valueForKey:@(attr1.indexPath.item - 2).stringValue] floatValue];
        
    }
    
    if (attr2.indexPath.item > 1) {
        
        y1 = [[self.attrsDic valueForKey:@(attr2.indexPath.item - 2).stringValue] floatValue];
        
    }
    
    for (NSInteger index = 0; index < arr.count ; index ++ ) {
        
        UICollectionViewLayoutAttributes *attr = arr[index];
        CGRect frame = attr.frame;
        NSInteger c1 = attr.indexPath.item % 2 ;
        
        if (attr.indexPath.item == 0 || attr.indexPath.item == 1) {
            attr.frame = CGRectMake(CGRectGetMinX(frame), 10, CGRectGetWidth(frame), CGRectGetHeight(frame));
            [self.attrsDic setValue:@"10" forKey:@(index).stringValue];
            
            if (attr.indexPath.item == 0) {
                y0 = CGRectGetMaxY(attr.frame);
                
            } else {
                y1 = CGRectGetMaxY(attr.frame);
                
            }
            
        } else {
            
            if (c1 == 0) {
                
                if (CGRectGetMinY(frame) > y0 + margin) {
                    frame.origin.y = y0 + margin;
                    
                }
                
                y0 = CGRectGetMaxY(frame);
                
            } else {
                
                if (CGRectGetMinY(frame) > y1 + margin) {
                    frame.origin.y = y1 + margin;
                    
                }
                
                y1 = CGRectGetMaxY(frame);
                
            }
            
            [self.attrsDic setValue:@(CGRectGetMaxY(frame)).stringValue forKey:@(attr.indexPath.item).stringValue];
            attr.frame = frame;
            
        }
        
    }
    
    return arr;
    
}



@end
