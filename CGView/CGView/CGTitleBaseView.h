//
//  CGTitleBaseView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGBaseAutoLayoutView.h"

/**
 加标题的视图的基类
 
 通过继承该类，创建两个任意UIView的视图，并赋值给 属性 leftView 和 rightView，当更新视图约束时自动设置leftView和rightView视图的约束
 */
@interface CGTitleBaseView : CGBaseAutoLayoutView

/**
 左边视图
 */
@property (weak, nonatomic) UIView * leftView;

/**
 *  右边视图
 */
@property (weak, nonatomic) UIView * rightView;

/**
 *  与父视图的四周边距
 *  该属性适用：leftView视图的 上、前、下三边，和rightView视图的 下、后、上三边 分别距离父视图的边距
 */
@property (assign, nonatomic) UIEdgeInsets edgeInsetView;

/**
 *  两个子视图之间的间距
 *  该属性设置：leftView和rightView两个视图之间的间距
 */
@property (assign, nonatomic) CGFloat viewSpace;

/**
 *  右边视图的横向优先级  
 *  当值大于251时右边的视图被拉伸，否则左边的视图被拉伸
 */
@property (assign, nonatomic) CGFloat rightViewPriority;
@end
