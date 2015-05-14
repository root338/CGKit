//
//  CGSingleViewDataSource.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CGRadioView;

@protocol CGSingleViewDataSource <NSObject>

/**
 *  创建单选视图需要加载的按钮
 *
 *  @param singleView 单选视图
 *  @param index      所要加载视图的索引
 *
 *  @return 返回设置的按钮
 */
- (UIControl *)singleView:(CGRadioView *)singleView controlAtIndex:(NSIndexPath *)indexPath;

/**
 *  当前组需要显示多少个选择按钮
 *
 *  @param singleView 单选视图
 *  @param index      当前组索引，现在为恒定值 0
 *
 *  @return 返回行数
 */
- (NSInteger)singleView:(CGRadioView *)singleView numberOfSections:(NSInteger)index;

@end

@end
