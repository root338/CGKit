//
//  UIButton+CreateAutoLayout.h
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CreateAutoLayout)

/**
 *  创建默认的支持auto layout按钮
 *
 *  @return 返回创建的按钮
 */
+ (UIButton *)createDefaultAutoButton;

/**
 *  创建指定样式的支持auto layout按钮
 *
 *  @param type 按钮的样式
 *
 *  @return 返回创建的按钮
 */
+ (UIButton *)createAutoLayoutButtonType:(UIButtonType)type;

/**
 *  创建指定样式的支持auto layout按钮
 *
 *  @param type       按钮的样式
 *  @param title      标题
 *  @param titleColor 标题的颜色
 *  @param bgImage    背景图片
 *
 *  @return 返回创建的按钮
 */
+ (UIButton *)createAutoLayoutButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor bgImage:(UIImage *)bgImage;

/**
 *  创建指定样式的支持auto layout按钮
 *
 *  @param type       按钮的样式
 *  @param title      标题
 *  @param titleColor 标题的颜色
 *  @param imageName  添加图片的名字  @warning 仅适用于本地图片
 *  @param isBgImage  是否是背景图片
 *
 *  @return 返回创建好的按钮
 */
+ (UIButton *)createAutoLayoutButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName isBgImage:(BOOL)isBgImage;

/**
 *  创建指定样式的支持auto layout按钮
 *
 *  @param type       按钮的样式
 *  @param title      标题
 *  @param titleColor 标题的颜色
 *  @param image  添加图片的名字
 *  @param isBgImage  是否是背景图片
 *
 *  @return 返回创建好的按钮
 */
+ (UIButton *)createAutoLayoutButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor image:(UIImage *)image isBgImage:(BOOL)isBgImage;

/**
 *  创建指定样式的支持auto layout按钮  只增加图片
 *
 *  @param type                 按钮的样式
 *  @param imageName            默认图片的名字
 *  @param highlightedImageName 高亮的图片名字
 *
 *  @return 返回创建好的按钮
 */
+ (UIButton *)createAutoLayoutButtonType:(UIButtonType)type normalimageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName;

/**
 *  创建指定样式的支持auto layout按钮  只增加图片
 *
 *  @param type                 按钮的样式
 *  @param imageName            默认图片
 *  @param highlightedImageName 高亮的图片
 *
 *  @return 返回创建好的按钮
 */
+ (UIButton *)createAutoLayoutButtonType:(UIButtonType)type normalimage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;
@end
