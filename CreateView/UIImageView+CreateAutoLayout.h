//
//  UIImageView+CreateAutoLayout.h
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CreateAutoLayout)

/**
 *  创建适配auto layout的图像视图
 *
 *  @param imageName 本地图像名
 *
 *  @return 返回创建好的图像视图
 */
+ (UIImageView *)createImageViewImageName:(NSString *)imageName;

/**
 *  创建适配auto layout的图像，指定加载图片的方式
 *
 *  @param imageName    本地图像名
 *  @param contentModel 加载的图片类型
 *
 *  @return 返回创建好的图像视图
 */
+ (UIImageView *)createImageViewImageName:(NSString *)imageName contentModel:(UIViewContentMode)contentModel;

/**
 *  创建适配auto layout的图像视图，执行拉伸的区域
 *
 *  @param imageName 本地图像名
 *  @param capInset  拉伸的区域
 *
 *  @return 返回创建好的图像视图
 */
+ (UIImageView *)createImageViewImageName:(NSString *)imageName capInsets:(UIEdgeInsets)capInset;


@end

/**
 设置本地图片
 */
@interface UIImageView (SetupLocaleImage)

/**
 *  为图像视图设置本地图片
 *
 *  @param imageName 本地图片名
 */
- (void)setupLocaleImage:(NSString *)imageName;

/**
 *  获取本地图片
 *
 *  @param imageName 本地图片名
 *
 *  @return 返回加载好的图片
 */
- (UIImage *)imageName:(NSString *)imageName;

/**
 *  获取本地图片
 *
 *  @param imageName  本地图片名
 *  @param isCap      是否拉伸
 *  @param edgeInsets 拉伸的数值
 *
 *  @return 返回加载好的图片
 */
- (UIImage *)imageName:(NSString *)imageName isCap:(BOOL)isCap capInsets:(UIEdgeInsets)edgeInsets;

@end