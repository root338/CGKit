//
//  CGTabScrollView.h
//  iSpa
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGSingleControlView;
@class CGSomeColorButton;
@class CGSingleContentView;
@class CGSingleSliderView;

@protocol CGSingleControlViewDelegate <NSObject>

/**
 *  选择控件后的回调
 *  @warning 关于选择回调，还是直接在所需要的视图页面加个KVO的观察
 *
 *  @param tabScrollView  当前所选的主页面
 *  @param selectedButton 所选择的按钮
 */
- (void)tabScrollView:(CGSingleControlView *)tabScrollView selectedButton:(CGSomeColorButton *)selectedButton index:(NSInteger)index;

@end

/**
 横向选择视图
 
 不足：该视图适合一次性规定的视图，动态添加暂时没有完成
 
    后续的动态添加可以继承该类，在子类中进行
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
 选择控件主视图
 */
@property (readonly, nonatomic) CGSingleContentView* contentView;

/**
 下方选择指示器-——滑块
 */
@property (readonly, nonatomic) CGSingleSliderView *sliderView;

/**
 已选的控件
 */
@property (strong, nonatomic) UIControl *selectedControl;
@end
