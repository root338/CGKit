//
//  CGZoomImageView.h
//  Corp
//
//  Created by 345 on 15/2/2.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGZoomImageView;
@protocol CGZoomImageViewDelegate <NSObject>

@optional
/**
 *  当图片的现实区域变化时进行回调
 *
 *  @param zoomImageView 图片的视图对象
 *  @param imageRect     改变后的显示区域
 */
- (void)zoomImageView:(CGZoomImageView *)zoomImageView imageRect:(CGRect)imageRect;

/**
 *  由于控制当前缩放因数下是否可以继续缩放
 *
 *  @param zoomImageView 图片的视图对象
 *  @param scale         当前缩放因数的数值
 *
 *  @return 一个BOOL值，当为YES时可以缩放，当为NO时不可以缩放
 */
- (BOOL)zoomImageView:(CGZoomImageView *)zoomImageView isScale:(CGFloat)scale;
@end

/**
 可以对图片进行缩放
 */
@interface CGZoomImageView : UIView

/**
 代理对象
 */
@property (weak, nonatomic) id<CGZoomImageViewDelegate> delegate;

/**
 加载的图片
 
 默认加载方式为UIViewContentModeScaleAspectFit
 */
@property (strong, nonatomic) UIImage *image;

/**
 最大的放大比例
 */
@property (assign, nonatomic) CGFloat maxZoomScale;

/**
 最小的缩小比例
 默认为 1
 */
@property (assign, nonatomic) CGFloat minZoomScale;

/**
 当前缩放的比例
 */
@property (assign, nonatomic) CGFloat currentZoomScale;

/**
 是否使用自动判断的图片加载模式显示图片
 */
@property (assign, nonatomic) BOOL isAutoImageViewContentMode;

/**
 是否可以缩放图片
 
 默认为 YES
 */
@property (assign, nonatomic) BOOL isZoomImage;

/**
 图片当前显示的区域
 */
@property (assign, nonatomic, readonly) CGRect imageCurrentRect;

@property (strong, nonatomic, readonly) UIScrollView *scrollView;

/**
 缩放手势的触发器
 */
- (void)zoomImageView:(UIPinchGestureRecognizer *)pinch;
@end
