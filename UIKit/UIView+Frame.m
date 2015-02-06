//
//  UIView+Frame.m
//  iOSTestProject
//
//  Created by 345 on 15/1/11.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

@dynamic size;
@dynamic width;
@dynamic height;

@dynamic origin;
@dynamic originY;
@dynamic originX;

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width
{
    CGSize size = CGSizeMake(width, self.bounds.size.height);
    self.size = size;
}
- (CGFloat)width
{
    return CGRectGetWidth(self.bounds);
}

- (void)setHeight:(CGFloat)height
{
    CGSize size = CGSizeMake(self.bounds.size.height, height);
    self.size = size;
}
- (CGFloat)height
{
    return CGRectGetHeight(self.bounds);
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOriginX:(CGFloat)originX
{
    CGPoint origin = CGPointMake(originX, self.frame.origin.y);
    self.origin = origin;
}
- (CGFloat)originX
{
    return CGRectGetMinX(self.frame);
}

- (void)setOriginY:(CGFloat)originY
{
    CGPoint origin = CGPointMake(self.frame.origin.x, originY);
    self.origin = origin;
}
- (CGFloat)originY
{
    return CGRectGetMinY(self.frame);
}


@end
