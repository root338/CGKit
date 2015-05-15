//
//  CGSingleSliderView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CGSliderWidthType) {
    
    ///使用默认样式与选择的控件一样宽
    CGSliderWidthTypeDefault,
    
    ///与控件标题一样宽
    CGSliderWidthTypeEqualTitleWidth,
    
    ///自定义
    CGSliderWidthTypeCustomWidth
};

/**
 单选按钮中定制的滑块
 */
@interface CGSingleSliderView : UIView

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
 暂时取消设置功能
 */
@property (readonly, nonatomic) CGFloat sliderWidth;

/**
 *  下方滑块的颜色 默认颜色为rgba(253,120,1,1)
 */
//@property (strong, nonatomic) UIColor *sliderColor;

/**
 当宽度变为固定宽度时需要删除滑块与其他按钮的宽度设置
 */
//@property (copy, nonatomic) void (^setupWidthTypeChange)(BOOL fixedWidth);

/**
 *  创建一个滑块
 *
 *  @return 返回创建好的滑块
 */
+ (instancetype)createSingleSliderView;


//该类不应该处理滑块的位置信息————暂时这样理解的
//
///**
// *  设置滑块与选中视图头相等
// *
// *  @param view
// */
//- (void)setupSliderLeadingToViewEqual:(UIView *)view;
//
///**
// *  设置滑块宽度固定值
// *
// *  @param width
// */
//- (void)setupSliderWidthEqual:(CGFloat)width;
//
///**
// *  根据滑块样式设置滑块位置
// *
// *  @param type  滑块样式
// *  @param view  相对视图
// *  @param width 相对宽度
// */
//- (void)setupSliderWidthType:(CGSliderWidthType)type view:(UIView *)view width:(CGFloat)width;
//
///**
// *  根据滑块现在的样式设置滑块的位置
// *
// *  @param view  相对视图
// *  @param width 相对宽度
// */
//- (void)setupSliderView:(UIView *)view width:(CGFloat)width;
@end
