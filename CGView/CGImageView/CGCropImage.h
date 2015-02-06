//
//  CGCropImage.h
//  Corp
//
//  Created by 345 on 15/1/30.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGCropImage : UIView

@property (strong, nonatomic) UIImage *image;

/**
 宽高比
 
 已宽为 基数 1  aspectRaio 为比例因子
 默认为 1：1
 用于截取框的固定比例
 */
@property (assign, nonatomic) CGFloat aspectRatio;

/**
 最大的放大比例
 */
@property (assign, nonatomic) CGFloat maxZoomScale;

/**
 最小的缩小比例
 */
@property (assign, nonatomic) CGFloat minZoomScale;

/**
 是否使用自动判断的图片加载模式显示图片
 */
@property (assign, nonatomic) BOOL isAutoImageViewContentMode;

@end
