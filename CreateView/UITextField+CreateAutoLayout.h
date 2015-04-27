//
//  UITextField+CreateAutoLayout.h
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CreateAutoLayout)

/**
 *  创建一个支持autolayout的text field
 *
 *  @return 返回创建好的UITextField对象
 */
+ (UITextField *)createAutoLayoutTextField;

@end
