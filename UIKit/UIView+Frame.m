//
//  UIView+Frame.m
//  iOSTestProject
//
//  Created by 345 on 15/1/11.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "UIView+Frame.h"
#import "EXTKeyPathCoding.h"

@implementation UIView (Frame)

@dynamic size;
@dynamic width;
@dynamic height;

@dynamic origin;
@dynamic y;
@dynamic x;

+ (NSSet *)keyPathsForValuesAffectingX {
    return [NSSet setWithObject:@keypathClassInstance(UIView, frame)];
}
+ (NSSet *)keyPathsForValuesAffectingY {
    return [NSSet setWithObject:@keypathClassInstance(UIView, frame)];
}

+ (NSSet *)keyPathsForValuesAffectingOrigin
{
    return [NSSet setWithObject:@keypathClassInstance(UIView, frame)];
}


+ (NSSet *)keyPathsForValuesAffectingWidth
{
    return [NSSet setWithObject:@keypathClassInstance(UIView, bounds)];
}

+ (NSSet *)keyPathsForValuesAffectingHeight
{
    return [NSSet setWithObject:@keypathClassInstance(UIView, bounds)];
}

+ (NSSet *)keyPathsForValuesAffectingSize
{
    return [NSSet setWithObject:@keypathClassInstance(UIView, bounds)];
}




- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)width
{
    return self.bounds.size.width;
}

- (CGFloat)height
{
    return self.bounds.size.height;
}

- (CGSize)size
{
    return self.bounds.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

@end
