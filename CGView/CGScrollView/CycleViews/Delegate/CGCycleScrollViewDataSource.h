//
//  CGCycleScrollViewDataSource.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CGCycleScrollView;

@protocol CGCycleScrollViewDataSource <NSObject>

/**
 *  设置滑动视图有多少个视图
 *
 *  @param cycleScrollView 当前循环滑动视图
 *
 *  @return 添加多少个子视图
 */
- (NSInteger)numberInCycleScrollView:(CGCycleScrollView *)cycleScrollView;

/**
 *  设置每个自定义的滑动视图
 *
 *  @param cycleScrollView 当前循环滑动视图
 *  @param index           设置滑动视图的索引
 *
 *  @return 返回设置的当前的滑动视图
 */
- (UIView *)cycleScrollView:(CGCycleScrollView *)cycleScrollView viewForNumberAtIndex:(NSInteger)index;

@end
