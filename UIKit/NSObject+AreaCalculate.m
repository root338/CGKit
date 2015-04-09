//
//  AreaCalculate.m
//  Corp
//
//  Created by apple on 15/2/8.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "NSObject+AreaCalculate.h"


@implementation NSObject (AreaCalculate)

- (CGRect)availableRect_maxRect:(CGRect)maxRect scale:(CGFloat)scale
{
    return [self availableRect_maxRect:maxRect scale:scale contentMode:0];
}

- (CGRect)availableRect_maxRect:(CGRect)maxRect scale:(CGFloat)scale contentMode:(NSUInteger)contentMode
{
    CGRect maxAvailableRect = CGRectZero;
    
    //假设宽比较短
    CGFloat width = maxRect.size.width;
    CGFloat height = width / scale;
    
    if (height > maxRect.size.height) {
        height = maxRect.size.height;
        width = height * scale;
    }
    
    //使用指定区域的中心为满足条件区域的中心点
    // contentMode 没有实现
    CGPoint center = _CGRectCenter(maxRect);
    
    maxAvailableRect = CGRectMake(center.x - width / 2, center.y - height / 2, width, height);
    
    return maxAvailableRect;
}

- (CGRect)automaticSetupAvailableRect_maxRect:(CGRect)maxRect scale:(CGFloat)scale currentRect:(CGRect)currentRect
{
    if (CGRectContainsRect(maxRect, currentRect)) {
        return currentRect;
    }
    
    CGRect maxAvailableRect = CGRectZero; //[self availableRect_maxRect:maxRect scale:scale];
    
    CGRect tmpCurrentRect = currentRect;
    tmpCurrentRect.origin = maxRect.origin;
    if (CGRectContainsRect(maxRect, tmpCurrentRect)) {
        maxAvailableRect = tmpCurrentRect;
    }else {
        
        maxAvailableRect = [self availableRect_maxRect:CGRectIntersection(tmpCurrentRect, maxRect) scale:tmpCurrentRect.size.width / tmpCurrentRect.size.height];
    }
    
    //是否比最大区域X坐标小
    if (currentRect.origin.x < maxRect.origin.x) {
        maxAvailableRect.origin.x = maxRect.origin.x;
    }else {
        //是否比最大区域的左边线还宽
        CGFloat hSpace = currentRect.origin.x + maxAvailableRect.size.width - (maxRect.origin.x + maxRect.size.width);
        if (hSpace > 0) {
            maxAvailableRect.origin.x = maxRect.origin.x + (maxRect.size.width - maxAvailableRect.size.width);
        }
    }
    
    //是否比最大区域Y坐标小
    if (currentRect.origin.y < maxRect.origin.y) {
        //设置可用区域为最大区域坐标
        maxAvailableRect.origin = maxRect.origin;
    }else {
        //是否比最大区域的底线还高
        CGFloat vSpace = currentRect.origin.y + maxAvailableRect.size.height - (maxRect.origin.y + maxRect.size.height);
        
        if (vSpace > 0) {
            maxAvailableRect.origin.y = maxRect.origin.y + (maxRect.size.height - maxAvailableRect.size.height);
        }
    }
    
    return maxAvailableRect;
}
@end

@implementation NSObject (AreaCompare)

BOOL _CGRectForSizeGreaterThan(CGRect rect1, CGRect rect2)
{
    return _CGSizeGreaterThan(rect1.size, rect2.size);
}

BOOL _CGSizeGreaterThan(CGSize size1, CGSize size2)
{
    return (size1.width >= size2.height && size1.height >= size2.height);
}

CGPoint _CGRectCenter(CGRect rect)
{
    return CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2);
}

CGPoint _CGPointSubtractPoint(CGPoint point1, CGPoint point2)
{
    return CGPointMake(point1.x - point2.x, point1.y - point2.y);
}

CGPoint _CGPointForMiddle(CGPoint point)
{
    return _CGPointMiddlePoint(point, CGPointZero);
}

CGPoint _CGPointMiddlePoint(CGPoint point1, CGPoint point2)
{
    return CGPointMake(point1.x + point2.x, point1.y + point2.y);
}
@end