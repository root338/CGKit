//
//  CGBaseTextField.h
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  文本输入框的基类
 */
@interface CGBaseTextField : UITextField

/**
 *  输入框离边界的间隔
 */
@property (assign, nonatomic) UIEdgeInsets textEdgeInsets;
@end
