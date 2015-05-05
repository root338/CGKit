//
//  BaseView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 重写 init 方法，默认设置translatesAutoresizingMaskIntoConstraints 为NO
 
 
 可以使用 ALView+PureLayout.h 文件中UIView 的扩展方法 + (instancetype)newAutoLayoutView; 类实现
 */
@interface CGBaseAutoLayoutView : UIView

@end
