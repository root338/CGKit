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
 *  当前组需要显示多少个选择按钮
 *
 *  @param singleView 单选视图
 *  @param index      当前组索引，现在为恒定值 0
 *
 *  @return 返回行数
 */
- (NSInteger)singleView:(CGRadioView *)singleView numberOfSections:(NSInteger)index;

@optional
/**
 *  创建单选视图需要加载的按钮
 *
 *
 *  @param singleView 单选视图
 *  @param index      所要加载视图的索引
 *
 *  @return 返回设置的按钮
 */
- (UIView *)singleView:(CGRadioView *)singleView controlAtIndex:(NSIndexPath *)indexPath;

/**
 *  创建单选视图需要加载的标题
 *  @warning singleView:controlAtIndex:方法会覆盖此方法
 *
 *  @param singleView 单选视图
 *  @param indexPath  所要加载标题的索引
 *
 *  @return 返回所要设置的标题
 */
- (NSString *)singleView:(CGRadioView *)singleView controlTitleAtIndex:(NSIndexPath *)indexPath;

/**
 *  单选视图设置标题的颜色，
 *  与singleView:controlTitleAtIndex:方法结合使用
 *
 *  @param singleView  单选视图
 *  @param normalColor 默认颜色
 *  @param selectColor 选择时的颜色
 */
- (void)singleView:(CGRadioView *)singleView titleAtIndexPath:(NSIndexPath *)indexPath normalColor:(UIColor **)normalColor selectColor:(UIColor **)selectColor;

/**
 设置视图的宽度，
 */
- (CGFloat)singleView:(CGRadioView *)tabScrollView widthForIndexPath:(NSIndexPath *)indexPath;

///因为间距是两个视图之间在有的，所以还不知道单个设置两个视图的间距时 这个方法返回的值作用的是左边还是右边
///**
// *  设置视图之间的间距
// *
// *  @param tabScrollView 滑动视图
// *  @param index 所设置的控件索引
// *
// *  @return 返回设置的索引
// */
//- (CGFloat)tabScrollView:(CGSingleScrollView *)tabScrollView spaceForIndex:(NSInteger)index;
@end
