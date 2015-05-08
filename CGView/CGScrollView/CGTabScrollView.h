//
//  CGTabScrollView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGTabScrollView;
@protocol CGTabScrollViewDataSource <NSObject>

/**
 添加多少个视图
 */
- (NSInteger)tabScrollViewNumberView:(CGTabScrollView *)tabScrollView;

/**
 添加视图的样式
 */
- (UIView *)tabScrollView:(CGTabScrollView *)tabScrollView numberViewAtIndex:(NSInteger)index;

/**
 设置视图的宽度
 */
- (CGFloat)tabScrollView:(CGTabScrollView *)tabScrollView widthForIndex:(NSInteger)index;
@end

/**
 滑动选择视图
 */
@interface CGTabScrollView : UIView



@end
