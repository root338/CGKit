//
//  CGSingleScrollView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGSingleScrollView;
@class CGRadioBaseView;

/**
 *  横向滑动选择视图
 *  功能： 可以横向滑动视图，当是选择视图时可以执行单选
 *
 *  @warning 1.指定刷新索引没有完成，需要完善。 2.删除功能需要添加 3.执行过程中得动画效果
 */
@interface CGSingleScrollView : UIView

/**
 单选视图
 */
@property (readonly, nonatomic) CGRadioBaseView *singleView;

/**
 选择的宽度
 */
@property (assign, nonatomic) CGFloat itemWidth;

/**
 视图之间的间距
 */
@property (assign, nonatomic) CGFloat itemSpace;

@end
