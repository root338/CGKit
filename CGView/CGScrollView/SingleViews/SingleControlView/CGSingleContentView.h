//
//  CGSingleContentView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGSingleBaseContentView;

@protocol CGSingleViewDataSource;

/**
 *  加载需要显示的单选视图中的各按钮数据
 */
@interface CGSingleContentView : UIView

@property (nonatomic) id<CGSingleViewDataSource> dataSource;

/**
 *  需要加载的标题列表
 *  @warning 当设置dataSource时设置titles没有效果
 */
@property (strong, nonatomic) NSMutableArray *titleArray;

#pragma mark - 内部的特别定制
//仅在使用此类自动实现自定义按钮的实现时才有用
/**
 设置按钮默认标题颜色 默认颜色为黑色
 */
@property (strong, nonatomic) UIColor *normalTitleColor;

/**
 设置按钮默认选中颜色 默认颜色为红色
 */
@property (strong, nonatomic) UIColor *selectedTitleColor;

/**
 默认选择的控件索引
 */
@property (assign, nonatomic) NSInteger defaultSelectedIndex;

/**
 *  选择控件后的回调block
 */
@property (copy, nonatomic) void(^selectCallback)(UIButton *selectControl);

//不可以将单选视图变为公有属性，会破坏数据实现
//@property (readonly, nonatomic) CGSingleBaseContentView *contentView;

/**
 *  获取选择控件的索引
 *
 *  @param selectedControl 选择控件
 *
 *  @return 返回相应索引
 */
- (NSInteger)indexAtSelected:(UIControl *)selectedControl;
@end
