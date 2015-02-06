//
//  CGZoomImageView.m
//  Corp
//
//  Created by 345 on 15/2/2.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "CGZoomImageView.h"

@interface CGZoomImageView ()<UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    UIPinchGestureRecognizer *_pinchGestureRecognizer;
    
    CGFloat imageScale;
}

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic, readwrite) UIScrollView *scrollView;

/**
 图片当前显示的区域
 */
@property (assign, nonatomic, readwrite) CGRect imageCurrentRect;
@end

@implementation CGZoomImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        _isZoomImage = YES;
        _maxZoomScale = FLT_MAX;
        _minZoomScale = 1;
        _currentZoomScale = 1;
    }
    
    return self;
}

- (void)initializeVariables
{
    _isZoomImage = YES;
}

- (UIScrollView *)scrollView
{
    if (_scrollView) {
        return _scrollView;
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    ///添加缩放手势
    _pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImageView:)];
    _pinchGestureRecognizer.delegate = self;
    [_scrollView addGestureRecognizer:_pinchGestureRecognizer];
    
    [self addSubview:_scrollView];
    
    return _scrollView;
}

/**
 缩放手势的触发器
 */
- (void)zoomImageView:(UIPinchGestureRecognizer *)pinch
{
    //    CGSize imgSize = self.imageView.image.size;
    switch (pinch.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (imageScale != 0.0) {
                pinch.scale = imageScale;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
            if (pinch.scale < self.minZoomScale) {
                [self animationZoomImageScale:self.minZoomScale];
                return;
            }
            imageScale = pinch.scale;
            break;
        
        default:
            break;
    }
    
    [self zoomImageScale:pinch.scale];
}

- (void)animationZoomImageScale:(CGFloat)scale
{
    imageScale = self.minZoomScale;
    
    [UIView animateWithDuration:.3 animations:^{
        [self zoomImageScale:imageScale];
    }];
}

///缩放图片
- (void)zoomImageScale:(CGFloat)scale
{
    //当不能缩放时直接返回
    if (!_isZoomImage) {
        return;
    }
    
    ///处理图片的位置、大小
    if (scale != NAN && scale != 0) {
        
        BOOL isZoomCurrentScale = YES;
        if ([self.delegate respondsToSelector:@selector(zoomImageView:isScale:)]) {
            isZoomCurrentScale = [self.delegate zoomImageView:self isScale:scale];
        }
        
        if (scale <= self.maxZoomScale && isZoomCurrentScale) {
            
            ///缩放图片
            self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
            
            ///获取图片的加载大小
            CGSize imgSize = [self getImageCurrentShowSize];
            
            ///计算图片缩放后的大小
            CGSize newContentSize = CGSizeMake(imgSize.width * scale, imgSize.height * scale);
            
            ///设置滑动区域
            self.scrollView.contentSize = newContentSize;
            
            ///计算新滑动区域的中心点
            CGPoint newCenter = CGPointMake(MAX(newContentSize.width, self.scrollView.bounds.size.width) / 2, MAX(newContentSize.height, self.scrollView.bounds.size.height) / 2);
            
            ///获取图片的原来的中心点
            CGPoint oldCenter = self.imageView.center;
            
            ///设置图片新的中心点
            self.imageView.center = newCenter;
            
            ///更新图片的显示区域
            self.imageCurrentRect = (CGRect){CGPointMake(newCenter.x - newContentSize.width / 2, newCenter.y - newContentSize.height / 2), newContentSize};
            if ([self.delegate respondsToSelector:@selector(zoomImageView:imageRect:)]) {
                [self.delegate zoomImageView:self imageRect:self.imageCurrentRect];
            }
            
            ///获取原来的滑动视图的偏移量
            CGPoint offset = self.scrollView.contentOffset;
            
            ///计算图片新的和旧的中心点之间的偏移量， 加上原来的滚动视图偏移量得到新值
            offset = CGPointMake(offset.x + (newCenter.x - oldCenter.x), offset.y + ( newCenter.y - oldCenter.y));
            
            ///设置滚动视图的偏移量
            self.scrollView.contentOffset = offset;
            
            _currentZoomScale = scale;
        }
    }
}

///设置图片视图
- (UIImageView *)imageView
{
    if (_imageView) {
        return _imageView;
    }
    
    _imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.scrollView addSubview:_imageView];
    
    return _imageView;
}

///设置加载图片
- (void)setImage:(UIImage *)image
{
    if (image) {
        _image = image;
        
        [self.imageView setImage:_image];
        if (self.isAutoImageViewContentMode) {
            self.imageView.contentMode = [self judgementImageViewMode];
        }
        if (imageScale == 0) {
            imageScale = 1;
        }
        [self zoomImageScale:imageScale];
    }
}

- (void)setCurrentZoomScale:(CGFloat)currentZoomScale
{
    _currentZoomScale = currentZoomScale;
    [self zoomImageScale:currentZoomScale];
}

- (void)setIsAutoImageViewContentMode:(BOOL)isAutoImageViewContentMode
{
    _isAutoImageViewContentMode = isAutoImageViewContentMode;
    if (_isAutoImageViewContentMode && self.imageView.image) {
        self.imageView.contentMode = [self judgementImageViewMode];
    }
}

///判断原图大小视图大于当前视图大小
- (BOOL)judgeImageSizeGreaterThan
{
    CGSize imgSize = self.imageView.image.size;
    CGSize imgViewSize = self.imageView.bounds.size;
    
    if (imgSize.width > imgViewSize.width || imgSize.height > imgViewSize.height) {
        
        return YES;
    }else {
        return NO;
    }
    
}

///获取图片加载时的大小
- (CGSize)getImageCurrentShowSize
{
    CGSize currentSize = CGSizeZero;
    
    switch (self.imageView.contentMode) {
        case UIViewContentModeScaleAspectFit:
        {
            CGSize imgSize = self.imageView.image.size;
            CGSize imgViewSize = self.imageView.bounds.size;
            
//            if ([self judgementImageViewMode]) {
            
                ///获取图片视图宽与图片宽的比例
                CGFloat scale = imgViewSize.width / imgSize.width;
                ///获取相同比例下的高度
                currentSize.height = imgSize.height * scale;
                ///判断该高度是否合适
                if (currentSize.height > imgViewSize.height) {
                    ///不合适时:
                    ///获取图片视图与图片高的比
                    scale = imgViewSize.height / imgSize.height;
                    ///获取图片加载大小
                    currentSize = CGSizeMake(imgSize.width * scale, imgViewSize.height);
                }else {
                    ///合适时
                    ///计算加载图片的宽度
                    currentSize.width = imgViewSize.width;
                }
                
//            }else {
//                ///当图片过小时直接返回图片大小
//                currentSize = imgSize;
//            }
        }
            break;
        case UIViewContentModeScaleAspectFill:
            currentSize = self.imageView.bounds.size;
            break;
        default:
            currentSize = self.imageView.image.size;
            break;
    }
    
    return currentSize;
}

/**
 自动设置当前图片的加载方式
 
 主要就是当图片可以缩放时避免太小的图片才开始就被拉伸
*/
- (UIViewContentMode)judgementImageViewMode
{
    if ([self judgeImageSizeGreaterThan]) {
        return UIViewContentModeScaleAspectFit;
    }else {
        return UIViewContentModeCenter;
    }
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    
//}

@end
