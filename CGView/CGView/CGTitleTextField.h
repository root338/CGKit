//
//  CGTitleTextField.h
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGTitleBaseView.h"

#import "CGBaseTextField.h"
#import "CGBaseLabel.h"
/**
 带标题的文本输入框
 */
@interface CGTitleTextField : CGTitleBaseView

/**
 *  显示的标题
 */
@property (strong, nonatomic, readonly) CGBaseLabel *titleLabel;

/**
 *  输入文本框
 */
@property (strong, nonatomic, readonly) CGBaseTextField *inputTextField;
@end
