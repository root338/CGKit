//
//  CGTabScrollView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGSingleScrollView;
@protocol CGSingleScrollViewDataSource <NSObject>

/**
 添加多少个视图
 */
- (NSInteger)tabScrollViewNumberView:(CGSingleScrollView *)tabScrollView;

/**
 添加视图的样式
 */
- (UIView *)tabScrollView:(CGSingleScrollView *)tabScrollView numberViewAtIndex:(NSInteger)index;

/**
 设置视图的宽度
 */
- (CGFloat)tabScrollView:(CGSingleScrollView *)tabScrollView widthForIndex:(NSInteger)index;
@end

/**
 滑动选择视图
 */
@interface CGSingleScrollView : UIView



@end
