//
//  CGPageContentView.h
//  PDPracticeDemo
//
//  Created by apple on 15/5/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 对应滑动视图的索引标识
 */
@interface CGPageContentView : UIView

/**
 需要显示的总页数
 */
@property (assign, nonatomic) NSInteger totalPage;

/**
 当前页数
 */
@property (assign, nonatomic) NSInteger currentPage;

/**
 当前页显示的图片
 */
@property (strong, nonatomic) UIImage *currentPageImage;

/**
 其他非选中页显示的图片
 */
@property (strong, nonatomic) UIImage *pageImage;
@end
