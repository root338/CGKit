//
//  CGSingleContentView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGSingleBaseContentView.h"

@interface CGSingleContentView : CGRadioView<CGSingleViewDataSource>

/**
 *  需要加载的标题列表
 */
@property (strong, nonatomic) NSMutableArray *titleArray;

#pragma mark - 内部的特别定制
//仅在使用此类自动实现自定义按钮的实现时才有用
/**
 设置按钮默认标题颜色
 */
@property (strong, nonatomic) UIColor *normalTitleColor;

/**
 设置按钮默认选中颜色
 */
@property (strong, nonatomic) UIColor *selectedTitleColor;
@end
