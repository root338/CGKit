//
//  CGCropView.h
//  Corp
//
//  Created by 345 on 15/2/2.
//  Copyright (c) 2015年 345. All rights reserved.
//

/**
 实现的不是太好，后期需要重构，
 现发现的不足有：
    1. 显示的裁剪框应该新建个类来维护，方便以后显示不同形状的裁剪框
 */
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CropClickType){
    ///未点中截取框
    kCropClickTypeNotSelector   =   0 << 0,
    
    ///点击上边框
    kCropClickTypeTopMargin     =   1 << 0,
    
    ///点击左边框
    kCropClickTypeLeftMargin    =   1 << 1,
    
    ///点击下边框
    kCropClickTypeBottomMargin  =   1 << 2,
    
    ///点击右边框
    kCropClickTypeRightMargin   =   1 << 3,
    
    ///点击截取框内部
    kCropClickTypeInside        =   1 << 4,
    
    ///点击左上角
    kCropClickTypeUpperLeftMargin   =   kCropClickTypeTopMargin | kCropClickTypeLeftMargin,
    
    ///点击左下角
    kCropClickTypeLowerLeftMargin   =   kCropClickTypeLeftMargin | kCropClickTypeBottomMargin,
    
    ///点击右下角
    kCropClickTypeLowerRightMargin  =   kCropClickTypeBottomMargin | kCropClickTypeRightMargin,
    
    ///点击右上角
    kCropClickTypeUpperRightMargin  =   kCropClickTypeRightMargin | kCropClickTypeTopMargin
};

@class CGCropView;
@protocol CGCropViewDelegate <NSObject>

@optional

/**
 *  设置截取框的可用显示区域
 *
 *  @param cropView 当前截取框的对象
 *
 *  @return 返回设置的可用区域
 */
- (CGRect)setupAvailableAreaCropView:(CGCropView *)cropView;

/**
 *  当前截取框的显示区域
 *
 *  @param cropView 当前截取框的对象
 *  @param cropRect 当前截取框的显示区域
 */
- (void)cropView:(CGCropView *)cropView currentCropRect:(CGRect)cropRect;

/**
 *  点击的坐标和相对于截取框的类型
 *
 *  @param cropView  当前截取框的对象
 *  @param point     点击的坐标
 *  @param pointType 点击的坐标相对于截取框的类型
 */
- (void)cropView:(CGCropView *)cropView clickPoint:(CGPoint)point type:(CropClickType)pointType;

///**
// *  多指触发屏幕时，是否对截取框进行操作
// *
// *  @param cropView 当前截取框的对象
// *  @param distancePoint 两点偏移量
// *
// *  @return 返回一个BOOL值，表示是否对截取框进行操作
// */
//- (BOOL)cropViewMulti_FingredWhereToContinue:(CGCropView *)cropView startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

///**
// *  捏合手势的回调方法
// *
// *  @param cropView 当前手势的视图对象
// *  @param pinch    触发的手势
// */
//- (void)cropView:(CGCropView *)cropView pinchGestureRecognizer:(UIPinchGestureRecognizer *)pinch;
@end

@interface CGCropView : UIView

/**
 *  代理对象
 */
@property (weak, nonatomic) id<CGCropViewDelegate> delegate;

/**
 *  截图的显示区域
 */
@property (assign, nonatomic) CGSize cropSize;

/**
 *  截图未选中区域的背景色
 *  
 *  默认颜色为 黑色 透明度 0.6
 */
@property (strong, nonatomic) UIColor *screenshotUncheckAreaColor;

/**
 *  当前截取框的显示区域
 */
@property (assign, nonatomic) CGRect currentShowAreaCropView;

/**
 *  点击的允许误差范围 必须大于零的数值
 */
@property (assign, nonatomic) float clickErrorRangeFloat;

/**
 *  是否是固定比例
 */
@property (assign, nonatomic) BOOL isFixedProportion;

/**
 *  宽高比例的数值
 *
 *  已宽为基数 1 比上高所得到的数值
 */
@property (assign, nonatomic) CGFloat fixedProportionFloat;

/**
 *  当前点击的类型
 */
@property (assign, nonatomic, readonly) CropClickType currentCropClickType;

/**
 *  截取框的最小显示大小
 */
@property (assign, nonatomic) CGSize minCropSize;

/**
 *  设置视图捏合手势
 *
 *  一般设置触发的方法来操作被截取的图片大小
 */
@property (strong, nonatomic, readonly) UIPinchGestureRecognizer *pinchGestureRecognizer;

/**
 *  两点之间的偏移距离
 *
 *  @param startPoint 起始点
 *  @param endPoint   结束点
 *
 *  @return 返回两点之间的坐标偏移
 */
- (CGPoint)offsetLocationStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 *  求两点之间的距离
 *
 *  @param startPoint 起始点
 *  @param endPoint   结束点
 *
 *  @return 返回两点之间的直线距离
 */
- (CGFloat)distanceStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 *  设置当前点击的类型
 */
- (void)setupClickType_CurrentCropClickPoint:(CGPoint)point event:(UIEvent *)event;

/**
 *  更新截取框的显示区域
 */
- (void)reloadUpdateCropRect;
@end
