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
@class CGRadioView;

typedef NS_ENUM(NSInteger, CGSliderWidthType) {
    
    ///使用默认样式与选择的控件一样宽
    CGSliderWidthTypeDefault,
    
    ///与控件标题一样宽
    CGSliderWidthTypeEqualTitleWidth,
    
    ///自定义
    CGSliderWidthTypeCustomWidth
};

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
@property (readonly, nonatomic) CGRadioView* radioSetView;

#pragma mark - 滑块视图样式设定
/**
 设置滑块宽度类型
 */
@property (assign, nonatomic) CGSliderWidthType sliderWidthType;

/**
 下方滑块的高度 默认值为2
 */
@property (assign, nonatomic) CGFloat sliderHeight;

/**
 只有当 CGSliderWidthType 为 CGSliderWidthTypeCustomWidth 时自动设置的值才有效
 */
@property (assign, nonatomic) CGFloat sliderWidth;

/**
 *  下方滑块的颜色 默认颜色为rgba(253,120,1,1)
 */
@property (strong, nonatomic) UIColor *sliderColor;

#pragma mark - 单选视图内容设置
/**
 选择控件之间的间距
 */
@property (assign, nonatomic) CGFloat controlSpace;

/**
 设置按钮默认标题颜色
 */
@property (strong, nonatomic) UIColor *normalTitleColor;

/**
 设置按钮默认选中颜色
 */
@property (strong, nonatomic) UIColor *selectedTitleColor;

/**
 *  设置需要添加的按钮的样式
 *
 *  @param index 添加的索引
 *
 *  @return 返回的设置好的按钮
 */
- (UIButton *)createSingleButtonAtIndex:(NSInteger)index;
@end
