//
//  CGTabScrollView.h
//  iSpa
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGSingleControlView;
@class CGSingleContentView;
@class CGSingleSliderView;

@protocol CGSingleControlViewDelegate <NSObject>

@optional
/**
 *  选择控件后的回调
 *  @warning 关于选择回调，还是直接在所需要的视图页面加个KVO的观察
 *
 *  @param tabScrollView  当前所选的主页面
 *  @param selectedButton 所选择的按钮
 */
- (void)singleControl:(CGSingleControlView *)singleControl selectedAtIndex:(NSInteger)selectedIndex;

@end

/**
 横向选择视图
 
 该类主要设置内容：不是加载数据而是通过值传递给子视图
 主要逻辑是设置滑块可变参数，比如设置滑块宽度，显示位置
 */
@interface CGSingleControlView : UIView

@property (weak, nonatomic) IBOutlet id<CGSingleControlViewDelegate> delegate;

#pragma mark - 添加数据
/**
 需要显示的标题
 */
@property (nonatomic) NSArray *titles;

#pragma mark - 可设置子视图对象


/**
 下方选择指示器-——滑块 
 默认背景色和contentView视图中按钮选中颜色相同
 */
@property (readonly, nonatomic) CGSingleSliderView *sliderView;

/**
 已选的控件
 */
@property (readonly, nonatomic) UIControl *selectedControl;

#pragma mark - CGSingleContentView属性设置
/**
 -----------------------------
 ***这样设置属性是为了避免单选视图对象对外暴露而导致设置的复杂性，和或许会破坏默认设置的功能
 ***
 ***
 ***如果想自定义扩展度更高的单选视图可以直接使用CGSingleBaseContentView类
 ***
 ***以后想到更好的再优化这里吧 -_-
 -----------------------------
 */


/**
 默认选择的控件索引
 */
@property (nonatomic) NSInteger defaultSelectedIndex;

/**
 设置按钮默认标题颜色 默认颜色为黑色
 */
@property (nonatomic) UIColor *normalColorControlTitle;

/**
 设置按钮默认选中颜色 默认颜色为红色
 */
@property (nonatomic) UIColor *selectedColorControlTitle;
@end
