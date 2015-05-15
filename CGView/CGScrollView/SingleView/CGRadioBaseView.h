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

@end