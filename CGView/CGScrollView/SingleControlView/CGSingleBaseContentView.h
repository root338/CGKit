//
//  CGSingleBaseContentView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGRadioView.h"
#import "CGSingleViewDataSource.h"

@interface CGSingleBaseContentView : CGRadioView

/**
 加载源数据时必要的方法
 */
@property (weak, nonatomic) id<CGSingleViewDataSource> dataSource;

/**
 加载控件之间的间距
 
 注意：仅在当只有一个控件时起作用
 */
@property (assign, nonatomic) UIEdgeInsets controlEdgeInset;

/**
 当有多个控件时设置之间的间距, 默认为0
 */
@property (assign, nonatomic) CGFloat itemSpace;

/**
 两端的按钮是否距离边界 ItemSpace 的距离, 默认为YES
 */
@property (assign, nonatomic) BOOL spaceMargin;

/**
 按钮的宽度是否相等，默认为YES
 */
@property (assign, nonatomic) BOOL matchedSize;

/**
 *  初始化单选视图
 *
 *  @return 返回单选视图
 */
- (instancetype)init;

- (void)reloadAllView;
@end
