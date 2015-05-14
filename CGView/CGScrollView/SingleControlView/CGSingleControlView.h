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
@property (strong, nonatomic) NSArray *titles;

#pragma mark - 可设置子视图对象
/**
 选择控件主视图
 */
@property (readonly, nonatomic) CGSingleContentView* radioSetView;

/**
 下方选择指示器-——滑块
 */
@property (readonly, nonatomic) CGSingleSliderView *singleSliderView;


#pragma mark - 单选视图内容设置
/**
 选择控件之间的间距
 */
@property (assign, nonatomic) CGFloat controlSpace;



/**
 *  设置需要添加的按钮的样式
 *
 *  @param index 添加的索引
 *
 *  @return 返回的设置好的按钮
 */
- (UIButton *)createSingleButtonAtIndex:(NSInteger)index;
@end
