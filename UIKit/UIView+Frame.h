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
@property (nonatomic, setter = setSize:, getter= size) CGSize size;

/**
 视图的宽度
 */
@property (nonatomic, setter = setWidth:, getter= width) CGFloat width;

/**
 设置视图高度
 */
@property (nonatomic, setter = setHeight:, getter= height) CGFloat height;

/**
 设置视图的坐标
 */
@property (nonatomic, setter = setOrigin:, getter= origin) CGPoint origin;

/**
 设置视图的x坐标
 */
@property (nonatomic, setter = setOriginX:, getter= originX) CGFloat originX;

/**
 设置视图的y坐标
 */
@property (nonatomic, setter = setOriginY:, getter=originY) CGFloat originY;

@end
