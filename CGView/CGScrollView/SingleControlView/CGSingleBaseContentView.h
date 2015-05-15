//
//  CGSingleBaseContentView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGRadioBaseView.h"
#import "CGSingleViewDataSource.h"

@protocol CGSingleViewDataSource;
/**
 *  继承单选视图，对视图属性进行了扩展，主要添加子按钮之间位置的设定（添加约束显示内容）
 */
@interface CGSingleBaseContentView : CGRadioBaseView

/**
 加载控件之间的间距
 
 注意：仅在当只有一个控件时起作用
 */
@property (assign, nonatomic) UIEdgeInsets controlEdgeInset;

/**
 当有多个控件时设置之间的间距, 默认为0
 */
@property (assign, nonatomic) CGFloat itemMarginSpace;

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
