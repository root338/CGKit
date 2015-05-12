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

@optional
/**
 设置视图的宽度
 */
- (CGFloat)tabScrollView:(CGTabScrollView *)tabScrollView widthForIndex:(NSInteger)index;

///因为间距是两个视图之间在有的，所以还不知道单个设置两个视图的间距时 这个方法返回的值作用的是左边还是右边
///**
// *  设置视图之间的间距
// *
// *  @param tabScrollView 滑动视图
// *  @param index 所设置的控件索引
// *
// *  @return 返回设置的索引
// */
//- (CGFloat)tabScrollView:(CGTabScrollView *)tabScrollView spaceForIndex:(NSInteger)index;
@end

/**
 *  横向滑动选择视图
 *  功能： 可以横向滑动视图，当是选择视图时可以执行单选
 *
 *  @warning 1.指定刷新索引没有完成，需要完善。 2.删除功能需要添加 3.执行过程中得动画效果 4.点击边缘处如果后面还有内容应用自动滚动选择内容使后续内容可见
 */
@interface CGTabScrollView : UIView

@property (weak, nonatomic) id<CGTabScrollViewDataSource> delegate;

/**
 选择的宽度
 */
@property (assign, nonatomic) CGFloat itemWidth;

/**
 视图之间的间距
 */
@property (assign, nonatomic) CGFloat itemSpace;

/**
 刷新指定索引的视图
 */
//- (void)reloadIndexs:(NSArray *)indexs;

/**
 *  刷新整个浏览视图
 */
- (void)reloadAllData;

/**
 *  清除所有的子控件
 */
- (void)clearAllData;
@end
