//
//  UIColor+HexColor.m
//  BaseModel
//
//  Created by 345 on 14/11/4.
//  Copyright (c) 2014年 345. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

#pragma mark HexColor
// These code base on: http://imchao.net/2012/01/08/using-hex-value-with-uicolor/
- (UIColor *)initWithRGBHex:(NSInteger)hexValue alpha:(CGFloat)alpha {
    return [self initWithRed:((hexValue & 0xFF0000) >> 16)/255.0f
                       green:((hexValue & 0xFF00) >> 8)/255.0f
                        blue:(hexValue & 0xFF)/255.0f
                       alpha:alpha];
}

+ (UIColor *)colorWithRGBHex:(NSInteger)hexValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((hexValue & 0xFF0000) >> 16)/255.0f
                           green:((hexValue & 0xFF00) >> 8)/255.0f
                            blue:(hexValue & 0xFF)/255.0f
                           alpha:alpha];
}

+ (UIColor *)colorWithRGBHex:(NSInteger)hexValue {
    return [UIColor colorWithRGBHex:hexValue alpha:1.0f];
}


+ (UIColor *)colorWithRGBString:(NSString *)nsstring {
    NSUInteger length = nsstring.length-1;
    //	if (length != 3 && length != 6 ) return [UIColor clearColor];
    if (length != 6 ) return [UIColor clearColor];
    if ([nsstring characterAtIndex:0] != '#') return [UIColor clearColor];
    int color;
    sscanf([nsstring UTF8String], "#%x", &color);
    return [UIColor colorWithRGBHex:color];
}

+ (UIColor *)colorWithRGBString:(NSString *)nsstring alpha:(CGFloat)alpha {
    NSUInteger length = nsstring.length-1;
    //	if (length != 3 && length != 6 ) return [UIColor clearColor];
    if (length != 6 ) return [UIColor clearColor];
    if ([nsstring characterAtIndex:0] != '#') return [UIColor clearColor];
    int color;
    sscanf([nsstring UTF8String], "#%x", &color);
    return [UIColor colorWithRGBHex:color alpha:alpha];
}

+ (UIColor *)colorWithPatternImageName:(NSString *)resourceName {
    return [UIColor colorWithPatternImage:[UIImage imageNamed:resourceName]];
}
@end
