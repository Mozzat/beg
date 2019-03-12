//
//  YUTimer.h
//  MasonryDemo
//
//  Created by yu on 2018/3/16.
//  Copyright © 2018年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 当定时器 开启后 只可以 暂停 和 关闭
 当定时器 关闭后 只可以 重新开启
 当定时器 暂停后 只可以 恢复
 当定时器 恢复后 只可以 暂停 和 关闭
 */
typedef NS_ENUM(NSInteger,YUTimerStatus) {
    YUTimerStatusIng,       //执行中
    YUTimerStatusSuspend,   //暂停
    YUTimerStatusStop,      //关闭
};

@interface YUTimer : NSObject

@property (nonatomic, assign) YUTimerStatus timerStatus;

/**
 初始化加开始

 @param timeNum 循环时间
 @param block 循环方法
 */
- (void)startTimerWithSpace:(float)timeNum block:(void(^)(void))block;


/**
 恢复
 */
- (void)resume;

/**
 暂停
 */
- (void)suspend;


/**
 关闭
 */
- (void)stopTimer;

@end
