//
//  CGCropImage.m
//  Corp
//
//  Created by 345 on 15/1/30.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "CGCropImage.h"
#import "CGZoomImageView.h"
#import "CGCropView.h"

@interface CGCropImage ()<UIGestureRecognizerDelegate, CGZoomImageViewDelegate, CGCropViewDelegate>
{
    
}

@property (strong, nonatomic) CGZoomImageView *imageView;

@property (strong, nonatomic) CGCropView *cropView;
@end

@implementation CGCropImage

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

- (CGZoomImageView *)imageView
{
    if (_imageView) {
        return _imageView;
    }
    
    _imageView = [[CGZoomImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];
    
//    _imageView.maxZoomScale = 2;
    _imageView.minZoomScale = 1;
    _imageView.delegate = self;
//    _imageView.isAutoImageViewContentMode = YES;
    
    return _imageView;
}

- (CGCropView *)cropView
{
    if (_cropView) {
        return _cropView;
    }
    
    _cropView = [[CGCropView alloc] initWithFrame:self.bounds];
    _cropView.cropSize = CGSizeMake(200, 180);
    
    _cropView.delegate = self;
    [_cropView.pinchGestureRecognizer addTarget:self.imageView action:@selector(zoomImageView:)];
    _cropView.isFixedProportion = YES;
    _cropView.fixedProportionFloat = 4/3.;
    
    [self addSubview:_cropView];
    return _cropView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
    self.imageView.isZoomLessThanMinScale = NO;
    
    [self cropView];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    [[self cropView] setupClickType_CurrentCropClickPoint:point event:event];
    if ([[self cropView] currentCropClickType] == kCropClickTypeNotSelector) {
        return self.imageView.scrollView;
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - CGZoomImageViewDelegate
- (void)zoomImageView:(CGZoomImageView *)zoomImageView imageRect:(CGRect)imageRect
{
    
}

#pragma mark - CGCropViewDelegate
//- (void)cropView:(CGCropView *)cropView pinchGestureRecognizer:(UIPinchGestureRecognizer *)pinch
//{
//    [self.imageView zoomImageView:pinch];
//}

- (CGRect)setupAvailableAreaCropView:(CGCropView *)cropView
{
    return self.imageView.imageCurrentRect;
}
@end
