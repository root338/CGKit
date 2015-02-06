//
//  UIColor+HexColor.h
//  BaseModel
//
//  Created by 345 on 14/11/4.
//  Copyright (c) 2014年 345. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 一些颜色的转换
 */
@interface UIColor (HexColor)

- (UIColor *)initWithRGBHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor*)colorWithRGBHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor*)colorWithRGBHex:(NSInteger)hexValue;

+ (UIColor *)colorWithRGBString:(NSString *)nsstring;
+ (UIColor *)colorWithRGBString:(NSString *)nsstring alpha:(CGFloat)alpha;

+ (UIColor *)colorWithPatternImageName:(NSString *)resourceName;

@end
