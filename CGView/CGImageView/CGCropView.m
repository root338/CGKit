//
//  CGCropView.m
//  Corp
//
//  Created by 345 on 15/2/2.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "CGCropView.h"
#import "NSObject+AreaCalculate.h"

typedef void(^setupAreaValue)(CGFloat value);
@interface CGCropView ()
{
    CGPoint _startPoint;
    CGFloat _transformDistance;
}

/**
 *  当前点击的类型
 */
@property (assign, nonatomic, readwrite) CropClickType currentCropClickType;

//@property (strong, nonatomic) UIPinchGestureRecognizer *pinchGestureRecognizer;
@end

@implementation CGCropView
@synthesize currentShowAreaCropView = _currentShowAreaCropView;
@synthesize pinchGestureRecognizer = _pinchGestureRecognizer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.screenshotUncheckAreaColor = [UIColor colorWithWhite:0 alpha:.6];
        self.backgroundColor = [UIColor clearColor];
        self.clickErrorRangeFloat = 10;
        
        
        CGFloat defaultSideLength = 200;
        self.currentShowAreaCropView = CGRectMake(self.center.x - defaultSideLength / 2, self.center.y - defaultSideLength / 2, defaultSideLength, defaultSideLength);
        
//        self.pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGestureRecognizer:)];
//        [self addGestureRecognizer:self.pinchGestureRecognizer];
    }
    return self;
}

//- (void)handlePinchGestureRecognizer:(UIPinchGestureRecognizer *)pinch
//{
//    if ([self.delegate respondsToSelector:@selector(cropView:pinchGestureRecognizer:)]) {
//        [self.delegate cropView:self pinchGestureRecognizer:pinch];
//    }
//}

- (UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    if (_pinchGestureRecognizer) {
        return _pinchGestureRecognizer;
    }
    
    _pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] init];
    [self addGestureRecognizer:_pinchGestureRecognizer];
    return _pinchGestureRecognizer;
}

- (void)setCropSize:(CGSize)cropSize
{
    self.currentShowAreaCropView = (CGRect){self.currentShowAreaCropView.origin, cropSize};
}

- (CGSize)cropSize
{
    return self.currentShowAreaCropView.size;
}

- (void)setFixedProportionFloat:(CGFloat)fixedProportionFloat
{
    _fixedProportionFloat = fixedProportionFloat;
    
    self.currentShowAreaCropView = [self availableRect_maxRect:[self getMaxAvailableRect] scale:fixedProportionFloat];
}

- (void)setCurrentShowAreaCropView:(CGRect)currentShowAreaCropView
{
    if (!CGRectEqualToRect(currentShowAreaCropView, _currentShowAreaCropView)) {
        
        _currentShowAreaCropView = currentShowAreaCropView;
//        [self cropAreaRestrictionsFunction:YES];
        [self setNeedsDisplay];
    }
}

- (void)reloadUpdateCropRect
{
//    CGRect maxAvailableRect = [self getMaxAvailableRect];
    
}

///获取截取框的最大区域
- (CGRect)getMaxAvailableRect
{
    CGRect maxAvailableRect = CGRectZero;
    if ([self.delegate respondsToSelector:@selector(setupAvailableAreaCropView:)]) {
        maxAvailableRect = [self.delegate setupAvailableAreaCropView:self];
    }
    if (CGRectEqualToRect(maxAvailableRect, CGRectZero)) {
        maxAvailableRect = self.bounds;
    }else {
        maxAvailableRect = CGRectIntersection(maxAvailableRect, self.bounds);
    }
    
    return maxAvailableRect;
}

///判断截取框的显示区域是否符合规定
- (BOOL)cropAreaRestrictionsFunction:(CGRect)cropNewRect
{
    BOOL result = YES;
    ///限制的最大得区域
    CGRect maxAvailableRect = [self getMaxAvailableRect];
//    if ([self.delegate respondsToSelector:@selector(setupAvailableAreaCropView:)]) {
//        CGRect availableArea = [self.delegate setupAvailableAreaCropView:self];
//        if (!CGRectContainsRect(availableArea, cropNewRect)) {
//            
//            result = NO;
//        }
//        
//    }
//    if (result) {
//        if (!CGRectContainsRect(self.bounds, cropNewRect)) {
//            result = NO;
//        }
//    }
    if (!CGRectContainsRect(maxAvailableRect, cropNewRect)) {
        return NO;
    }
    return result;
}

///设置截取框的显示区域，并且保证显示区域在规定范围内
- (void)setupCropAreaRestrictions:(CGRect *)cropNewRect
{
    
    if ([self.delegate respondsToSelector:@selector(setupAvailableAreaCropView:)]) {
        CGRect availableArea = [self.delegate setupAvailableAreaCropView:self];
        *cropNewRect = CGRectIntersection(*cropNewRect, availableArea);
    }
    
    *cropNewRect = CGRectIntersection(*cropNewRect, self.bounds);
}

/**
 *  ///设置新的截取框的显示区域
 *
 *  @param distance 偏移的单位坐标
 */
- (void)setupNewCropArea:(CGPoint)offsetDistance
{
    CGRect tmpCopyCurrentShowArea = self.currentShowAreaCropView;
    
    BOOL top    = _currentCropClickType & kCropClickTypeTopMargin;
    BOOL left   = _currentCropClickType & kCropClickTypeLeftMargin;
    BOOL right  = _currentCropClickType & kCropClickTypeRightMargin;
    BOOL bottom = _currentCropClickType & kCropClickTypeBottomMargin;
    BOOL inside = _currentCropClickType & kCropClickTypeInside;
    
    if (self.isFixedProportion) {
        
        if (top || bottom) {
            
            CGFloat oldHeight = tmpCopyCurrentShowArea.size.height;
            CGFloat newHeight = oldHeight + (top ? -1 : 1) * offsetDistance.y;
            CGFloat oldWidth = tmpCopyCurrentShowArea.size.width;
            CGFloat newWidth = newHeight * self.fixedProportionFloat;
            tmpCopyCurrentShowArea.size = CGSizeMake(newWidth, newHeight);
            
            tmpCopyCurrentShowArea.origin.x -= (newWidth - oldWidth) / 2;
            
            if (top) {
                tmpCopyCurrentShowArea.origin.y += offsetDistance.y;
            }
        }
        
        if (left || right) {
            
            CGFloat oldWidth = tmpCopyCurrentShowArea.size.width;
            CGFloat newWidth = oldWidth - (left ? 1 : -1) * offsetDistance.x;
            CGFloat oldHeight = tmpCopyCurrentShowArea.size.height;
            CGFloat newHeight = newWidth / self.fixedProportionFloat;
            tmpCopyCurrentShowArea.size = CGSizeMake(newWidth, newHeight);
            
            tmpCopyCurrentShowArea.origin.y -= (newHeight - oldHeight) / 2;
            
            if (left) {
                tmpCopyCurrentShowArea.origin.x += offsetDistance.x;
                
            }
        }
        
        if (inside) {
            
            tmpCopyCurrentShowArea.origin.y += offsetDistance.y;
            if (![self cropAreaRestrictionsFunction:tmpCopyCurrentShowArea]) {
                tmpCopyCurrentShowArea.origin.y -= offsetDistance.y;
            }
            tmpCopyCurrentShowArea.origin.x += offsetDistance.x;
            if (![self cropAreaRestrictionsFunction:tmpCopyCurrentShowArea]) {
                tmpCopyCurrentShowArea.origin.x -= offsetDistance.x;
            }
        }
    }else {
        if (top || inside) {
            tmpCopyCurrentShowArea.origin.y += offsetDistance.y;
        }
        if (left || inside) {
            tmpCopyCurrentShowArea.origin.x += offsetDistance.x;
        }
        if (top || bottom) {
            tmpCopyCurrentShowArea.size.height += (top ? -1 : 1) * offsetDistance.y;
        }
        
        if (left || right) {
            tmpCopyCurrentShowArea.size.width += (left ? -1 : 1) * offsetDistance.x;
        }
    }
    
    if ([self cropAreaRestrictionsFunction:tmpCopyCurrentShowArea]) {
        self.currentShowAreaCropView = tmpCopyCurrentShowArea;
    }
    
//    [self setupCropAreaRestrictions:&tmpCopyCurrentShowArea];
//    self.currentShowAreaCropView = tmpCopyCurrentShowArea;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGSize viewSize = self.bounds.size;
    CGPoint currentCropStartPoint = self.currentShowAreaCropView.origin;
    
    CGRect topRect = CGRectMake(0, 0, viewSize.width, currentCropStartPoint.y);
    CGRect leftRect = CGRectMake(0, currentCropStartPoint.y, currentCropStartPoint.x, self.cropSize.height);
    CGRect bottomRect = CGRectMake(0, currentCropStartPoint.y + self.cropSize.height, viewSize.width, viewSize.height - currentCropStartPoint.y - self.cropSize.height);
    CGRect rightRect = CGRectMake(currentCropStartPoint.x + self.cropSize.width, currentCropStartPoint.y, viewSize.width - currentCropStartPoint.x - self.cropSize.width, self.cropSize.height);
    
    const CGRect rects[] = {
        topRect,
        leftRect,
        bottomRect,
        rightRect
    };
    
    CGPathAddRects(path, NULL, rects, 4);
    
    [self.screenshotUncheckAreaColor setFill];
//    [[UIColor whiteColor] setStroke];
    CGContextAddPath(context, path);
    
    CGContextDrawPath(context, kCGPathFill);
    
    CGPathRelease(path);
}

- (void)setClickErrorRangeFloat:(float)clickErrorRangeFloat
{
    _clickErrorRangeFloat = clickErrorRangeFloat < 0 ?: clickErrorRangeFloat;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    [self setupClickType_CurrentCropClickPoint:point event:event];
    
    return [super hitTest:point withEvent:event];
}


/// 设置当前点击的类型
- (void)setupClickType_CurrentCropClickPoint:(CGPoint)point event:(UIEvent *)event
{
    float offectOrigin = _clickErrorRangeFloat / 2;
    CGPoint currentShowCropPoint = self.currentShowAreaCropView.origin;
    
    ///范围边界的四个点坐标
    CGPoint upperLeft = CGPointMake(currentShowCropPoint.x - offectOrigin, currentShowCropPoint.y - offectOrigin);
    CGPoint lowerLeft = CGPointMake(currentShowCropPoint.x - offectOrigin, currentShowCropPoint.y - offectOrigin + self.cropSize.height);
    CGPoint upperRight = CGPointMake(currentShowCropPoint.x - offectOrigin + self.cropSize.width, currentShowCropPoint.y - offectOrigin);
    //    CGPoint lowerRight = CGPointMake(currentShowCropPoint.x - offectOrigin + self.cropSize.width, currentShowCropPoint.y + offectOrigin + self.cropSize.height);
    
    ///两种类型的区域
    CGSize size1 = CGSizeMake(self.cropSize.width + _clickErrorRangeFloat, _clickErrorRangeFloat);
    CGSize size2 = CGSizeMake(_clickErrorRangeFloat, self.cropSize.height + _clickErrorRangeFloat);
    
    ///内部区域
    CGRect insideRect = CGRectMake(currentShowCropPoint.x + offectOrigin, currentShowCropPoint.y + offectOrigin, self.cropSize.width - _clickErrorRangeFloat, self.cropSize.height - _clickErrorRangeFloat);
    
    CGRect topRect = (CGRect){upperLeft, size1};
    CGRect leftRect = (CGRect){upperLeft, size2};
    CGRect bottomRect = (CGRect){lowerLeft, size1};
    CGRect rightRect = (CGRect){upperRight, size2};
    
    CropClickType type = kCropClickTypeNotSelector;
    if (CGRectContainsPoint(topRect, point)) {
        type += kCropClickTypeTopMargin;
    }
    if (CGRectContainsPoint(leftRect, point)) {
        type += kCropClickTypeLeftMargin;
    }
    if (CGRectContainsPoint(bottomRect, point)) {
        type += kCropClickTypeBottomMargin;
    }
    if (CGRectContainsPoint(rightRect, point)) {
        type += kCropClickTypeRightMargin;
    }
    if (CGRectContainsPoint(insideRect, point)) {
        type += kCropClickTypeInside;
    }
    
    self.currentCropClickType = type;
    if ([self.delegate respondsToSelector:@selector(cropView:clickPoint:type:)]) {
        [self.delegate cropView:self clickPoint:point type:type];
    }
}

///获取任意的一个点集合中的坐标
- (CGPoint)touchesAnyPoint:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint tmpPoint = [touch locationInView:self];
    return tmpPoint;
}

///求两点之间的距离
- (CGFloat)distanceStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CGPoint offsetPoint = [self offsetLocationStartPoint:startPoint endPoint:endPoint];
    
    CGFloat distance = sqrt((offsetPoint.x * offsetPoint.x) + (offsetPoint.y * offsetPoint.y));
    
    return distance;
}

///两点之间的偏移距离
- (CGPoint)offsetLocationStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CGFloat spaceX = endPoint.x - startPoint.x;
    CGFloat spaceY = endPoint.y - startPoint.y;
    
    CGPoint offsetLocation = CGPointMake(spaceX, spaceY);
    return offsetLocation;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    _startPoint = [self touchesAnyPoint:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint movePoint = [self touchesAnyPoint:touches];
    
//    BOOL result = YES;
//    if ([event allTouches].count > 1 && [self.delegate respondsToSelector:@selector(cropViewMulti_FingredWhereToContinue:startPoint:endPoint:)]) {
//        result = [self.delegate cropViewMulti_FingredWhereToContinue:self startPoint:_startPoint endPoint:movePoint];
//    }
//    if (result) {
    CGPoint offsetDistance = [self offsetLocationStartPoint:_startPoint endPoint:movePoint];
    
    [self setupNewCropArea:offsetDistance];
//    }
    
    _startPoint = movePoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.currentCropClickType = kCropClickTypeNotSelector;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.currentCropClickType = kCropClickTypeNotSelector;
}
@end
