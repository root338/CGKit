//
//  UILabel+CreateAutoLayout.h
//  PDPracticeDemo
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CreateAutoLayout)

/**
 *  创建一个支持auto layout 的label
 *
 *  @return 返回创建好的Label
 */
+ (UILabel *)createAutoLayoutLabel;

/**
 *  创建定制化的文本框
 *
 *  @param textColor 设置文本框的字体颜色
 *
 *  @return 返回创建好的文本视图
 */
+ (UILabel *)createCustormizedLabel:(UIColor *)textColor;
@end
