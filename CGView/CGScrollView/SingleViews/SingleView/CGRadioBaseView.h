//
//  CGRadioBaseView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGRadioView.h"
#import "CGSingleViewDataSource.h"

@interface CGRadioBaseView : CGRadioView

/**
 加载源数据时必要的方法
 */
@property (weak, nonatomic) id<CGSingleViewDataSource> dataSource;

/**
 总数
 */
@property (assign, readonly, nonatomic) NSInteger totalNumber;

/**
 总宽度
 */
@property (assign, nonatomic) CGFloat totalWidths;

/**
 是否使用约束
 */
@property (assign, nonatomic) BOOL isAutoLaout;

/**
 设置子按钮的高度
 */
@property (assign, nonatomic) CGFloat itemHeight;

/**
 设置子按钮的间距
 */
@property (assign, nonatomic) CGFloat itemSpace;

/**
 设置子按钮的宽度
 */
@property (assign, nonatomic) CGFloat itemWidth;

/**
 当加载视图完成后，回调此block
 */
@property (copy, nonatomic) void(^didSetupViewFinish)(void);

/**
 刷新整个单选视图
 */
- (void)reloadAllView;

/**
 *  设置单选视图的内容
 */
- (UIControl *)setupRadioContentViewAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  设置单选视图的宽度
 *
 *  @param indexPath 所选视图的索引
 */
- (void)setupRadioContent:(UIControl *)control frameAtIndexPath:(NSIndexPath *)indexPath totalWidth:(CGFloat *)totalWidth;

/**
 *  设置默认按钮的样式
 *
 *  @param indexPath 所选视图的索引
 */
- (UIControl *)setupRadioDefaultControlAtIndexPath:(NSIndexPath *)indexPath title:(NSString *)title;

/**
 获取选中视图的下一个视图
 */
- (UIView *)selectedNextView;

/**
 获取选中视图的上一个视图
 */
- (UIView *)selectedPreviousView;
@end