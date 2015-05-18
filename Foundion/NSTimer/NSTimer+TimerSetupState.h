//
//  NSTimer+TimerSetupState.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 更新计时器的状态
 */
@interface NSTimer (TimerSetupState)

/**
 开始
 */
- (void)startTimer;

/**
 暂停
 */
- (void)pauseTimer;

/**
 停止计时器，并关闭计时器
 */
- (void)stopTimer;

/**
 在当前多少时间后开启计时器
 */
- (void)startTimerAfterTimeInterval:(NSTimeInterval)timeInterval;
@end
