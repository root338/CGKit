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
 */
@property (assign, nonatomic) CGFloat sliderWidth;

/**
 *  下方滑块的颜色 默认颜色为rgba(253,120,1,1)
 */
@property (strong, nonatomic) UIColor *sliderColor;

/**
 *  创建一个滑块
 *
 *  @return 返回创建好的滑块
 */
+ (instancetype)createSingleSliderView;

/**
 *  初始化一个滑块
 *
 *  @return 返回滑块
 */
- (instancetype)initWithFrame:(CGRect)frame;
@end
