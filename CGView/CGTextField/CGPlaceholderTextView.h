//
//  CGPlaceholderTextView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  增加提示文本
 *  未实现
 */
@interface CGPlaceholderTextView : UITextView

/**
 *  提示内容
 */
@property (strong, nonatomic) NSString *placeholder;

/**
 *  提示文本的颜色
 */
@property (strong, nonatomic) UIColor *placeholderTextColor;

/**
 *  提示文本距离textView的边界
 */
@property (assign, nonatomic) UIEdgeInsets edgeInsetMarginForPlaceholder;
@end
