//
//  NSTimer+TimerSetupState.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSTimer+TimerSetupState.h"

@implementation NSTimer (TimerSetupState)

- (void)startTimer
{
    if (!self.isValid) {
        return ;
    }
    
    [self setFireDate:[NSDate date]];
}

- (void)pauseTimer
{
    if (!self.isValid) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}

- (void)stopTimer
{
    if (!self.isValid) {
        return;
    }
    [self invalidate];
}

- (void)startTimerAfterTimeInterval:(NSTimeInterval)timeInterval
{
    if (!self.isValid) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval]];
}
@end
