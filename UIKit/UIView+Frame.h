//
//  UIView+Frame.h
//  iOSTestProject
//
//  Created by 345 on 15/1/11.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/**
 设置视图大小
 */
@property (nonatomic) CGSize size;

/**
 视图的宽度
 */
@property (nonatomic) CGFloat width;

/**
 设置视图高度
 */
@property (nonatomic) CGFloat height;

/**
 设置视图的坐标
 */
@property (nonatomic) CGPoint origin;

/**
 设置视图的x坐标
 */
@property (nonatomic) CGFloat x;

/**
 设置视图的y坐标
 */
@property (nonatomic) CGFloat y;

@end
