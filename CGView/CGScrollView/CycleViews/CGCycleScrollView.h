//
//  CGCycleScrollView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGCycleScrollViewDataSource.h"

/**
 循环滑动视图
    目的：
        1. 浏览视图时可以分页展示视图，并且可以循环展示
 
    目前希望实现功能：
        1. 可以循环滑动，也可以不循环滑动
        2. 可以设置自动滑动，时间自定义，但是在用户滑动时不会自动滑动
        3. 有提示标志 参考pageViewController的效果，提示状态可以加入自定义图片
        4. 提示标志提供默认展示位置，目前添加（下左，下中，下右） 注意：如果提示标志太多怎样显示，现在需要预留更改空间
 */

/**
 循环滑动视图的基类
 */
@interface CGCycleScrollView : UIView

/**
 是否循环滑动视图 默认为YES
 */
@property (assign, nonatomic) BOOL isCycle;

/**
 添加数据代理
 */
@property (weak, nonatomic) id<CGCycleScrollViewDataSource> dataSource;

/**
 是否自动滑动，默认为NO
 当设值为YES时，delayTimeInterval属性为 2
 */
@property (assign, nonatomic) BOOL isAutoScrollView;

/**
 每隔多少秒滑动一次
 必须设置isAutoScrollView为YES，才能启动自动滑动
 */
@property (assign, nonatomic) NSTimeInterval delayTimeInterval;



/**
 *  刷新视图
 */
- (void)reloadAllView;

/**
 当实现自动滑动视图时需要在视图消失，或移除时调用此方法
 @warning: 否则会产生内存泄露
 */
- (void)stopTimer;
@end
