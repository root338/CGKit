//
//  UIView+AddLayoutConstraint.m
//  soho
//
//  Created by 345 on 14/11/18.
//  Copyright (c) 2014年 Chinamobo. All rights reserved.
//

#import "UIView+AddLayoutConstraint.h"

 NSString * const GCLayoutAttributeLeading      = @"GCLayoutAttributeLeading";
 NSString * const GCLayoutAttributeTrailing     = @"GCLayoutAttributeTrailing";
 NSString * const GCLayoutAttributeTop       = @"GCLayoutAttributeTop";
 NSString * const GCLayoutAttributeBottom    = @"GCLayoutAttributeBottom";
 NSString * const GCLayoutAttributeWidth     = @"GCLayoutAttributeWidth";
 NSString * const GCLayoutAttributeHeight    = @"GCLayoutAttributeHeight";
 NSString * const GCLayoutAttributeCenterX   = @"GCLayoutAttributeCenterX";
 NSString * const GCLayoutAttributeCenterY   = @"GCLayoutAttributeCenterY";

@implementation UIView (AddLayoutConstraint)

- (NSArray *)addConstraintWithAttribute:(KGCLayoutAttribute)atts
{
    return [self addConstraintWithAttribute:atts size:CGSizeZero];
}

- (NSDictionary *)addDicConstraintWithAttribute:(KGCLayoutAttribute)atts
{
    return [self addDicConstraintWithAttribute:atts size:CGSizeZero];
}

- (NSArray *)addConstraintWithAttribute:(KGCLayoutAttribute)atts size:(CGSize)size
{
    return [self addConstraintWithAttribute:atts size:size zeroIsNoAddAttribute:YES];
}

- (NSDictionary *)addDicConstraintWithAttribute:(KGCLayoutAttribute)atts size:(CGSize)size
{
    return [self addDicConstraintWithAttribute:atts size:size zeroIsNoAddAttribute:YES];
}

- (NSArray *)addConstraintWithAttribute:(KGCLayoutAttribute)atts size:(CGSize)size zeroIsNoAddAttribute:(BOOL)noAdd
{
    NSDictionary *dic = [self addDicConstraintWithAttribute:atts size:size zeroIsNoAddAttribute:noAdd];
    
    return [dic allValues];
}

/**
 设置约束的值
 
 用于判断加什么约束和加的约束到字典中的键值
 @return 返回一个数组，数组第一个对象是加的约束的键值，数组第二个对象是加的约束的值
 */
- (NSArray *)dicForkey:(KGCLayoutAttribute)layoutAttribute
{
    const NSString *key = nil;
    NSLayoutAttribute value = 0;
    switch (layoutAttribute) {
        case kGCLayoutAttributeTop:
            key = GCLayoutAttributeTop;
            value = NSLayoutAttributeTop;
            break;
        case kGCLayoutAttributeBottom:
            key = GCLayoutAttributeBottom;
            value = NSLayoutAttributeBottom;
            break;
        case kGCLayoutAttributeLeading:
            key = GCLayoutAttributeLeading;
            value = NSLayoutAttributeLeading;
            break;
        case kGCLayoutAttributeTrailing:
            key = GCLayoutAttributeTrailing;
            value = NSLayoutAttributeTrailing;
            break;
        case kGCLayoutAttributeCenterX:
            key = GCLayoutAttributeCenterX;
            value = NSLayoutAttributeCenterX;
            break;
        case kGCLayoutAttributeCenterY:
            key = GCLayoutAttributeCenterY;
            value = NSLayoutAttributeCenterY;
            break;
        case kGCLayoutAttributeWidth:
            key = GCLayoutAttributeWidth;
            value = NSLayoutAttributeWidth;
            break;
        case kGCLayoutAttributeHeight:
            key = GCLayoutAttributeHeight;
            value = NSLayoutAttributeHeight;
        default:
            break;
    }
    if (key) {
        return @[key, @(value)];
    }else {
        return nil;
    }
}

- (void)setupConstraint:(KGCLayoutAttribute)layoutAttribute saveDic:(NSMutableDictionary *)dic size:(CGSize)size
{
    NSArray *arr = [self dicForkey:layoutAttribute];
    if (arr) {
        NSString *key = arr[0];
        NSLayoutAttribute layoutArributeValue = [arr[1] integerValue];
        NSLayoutConstraint *constraint = nil;
        if (layoutArributeValue == NSLayoutAttributeWidth || layoutArributeValue == NSLayoutAttributeHeight) {
            constraint = [self setupConstraintWithAttribute:layoutArributeValue value:layoutAttribute == NSLayoutAttributeHeight ? size.height : size.width];
        }else {
            constraint = [self addConstraintWithEqualToSuperattribute:layoutArributeValue];
        }
        [dic setObject:constraint forKey:key];
    }else {
        NSLog(@"设置的约束值有误");
    }
}

- (NSDictionary *)addDicConstraintWithAttribute:(KGCLayoutAttribute)atts size:(CGSize)size zeroIsNoAddAttribute:(BOOL)noAdd
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (NSInteger value = 0; value <= 7; value++) {
        KGCLayoutAttribute layoutAttributeValue = 1 << value;
        if (atts & layoutAttributeValue) {
            if (layoutAttributeValue == kGCLayoutAttributeWidth || layoutAttributeValue == kGCLayoutAttributeHeight) {
                if (!((noAdd && (size.width > 1 || size.height > 1)) || !noAdd)) {
                    continue;
                }
            }
            [self setupConstraint:layoutAttributeValue saveDic:dic size:size];
        }
    }
    return dic;
}

#pragma mark add to super view
- (NSLayoutConstraint *)addConstraintWithEqualToSuperattribute:(NSLayoutAttribute)att1
{
    return [self addConstraintWithAttribute:att1 relatedBy:NSLayoutRelationEqual toItem:self.superview atttribute:att1 multiplier:1.0 constant:0];
}

- (NSLayoutConstraint *)addConstraintWithAttribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 atttribute:(NSLayoutAttribute)att2 multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:att1 relatedBy:relation toItem:view2 attribute:att2 multiplier:multiplier constant:c];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSArray *)addConstraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSArray *atts = [NSLayoutConstraint constraintsWithVisualFormat:format options:options metrics:metrics views:views];
    [self.superview addConstraints:atts];
    return atts;
}

- (NSArray *)addConstraintsWithVisualFormat:(NSString *)format views:(NSDictionary *)views
{
    return [self addConstraintsWithVisualFormat:format options:0 metrics:nil views:views];
}

- (NSArray *)addConstraintsWithVisualFormats:(NSArray *)formats views:(NSDictionary *)views
{
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSString *str in formats) {
        [arr addObjectsFromArray:[self addConstraintsWithVisualFormat:str views:views]];
    }
    return arr;
}

#pragma mark add to view
- (NSLayoutConstraint *)addConstraintWithWidth:(CGFloat)width
{
    return [self setupConstraintWithAttribute:NSLayoutAttributeWidth value:width];
}

- (NSLayoutConstraint *)addConstraintWithHeight:(CGFloat)height
{
    return [self setupConstraintWithAttribute:NSLayoutAttributeHeight value:height];
}

- (NSArray *)setupViewSize:(CGSize)size
{
    NSMutableArray *atts = [NSMutableArray array];
    [atts addObject:[self addConstraintWithWidth:size.width]];
    [atts addObject:[self addConstraintWithHeight:size.height]];
    return atts;
}

- (NSLayoutConstraint *)setupConstraintWithAttribute:(NSLayoutAttribute)att1 value:(CGFloat)value
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:att1 relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:value];
    [self addConstraint:constraint];
    return constraint;
}
@end
