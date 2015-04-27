//
//  UIButton+CreateAutoLayout.m
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIButton+CreateAutoLayout.h"

@implementation UIButton (CreateAutoLayout)

+ (UIButton *)createDefaultAutoButton
{
    return [self createAutoLayoutButtonType:UIButtonTypeSystem];
}

+ (UIButton *)createAutoLayoutButtonType:(UIButtonType)type
{
    UIButton *_button = [UIButton buttonWithType:type];
    _button.translatesAutoresizingMaskIntoConstraints = NO;
    
    return _button;
}

+ (UIButton *)createAutoLayoutButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor bgImage:(UIImage *)bgImage
{
    return [self createAutoLayoutButtonType:type title:title titleColor:titleColor image:bgImage isBgImage:YES];
}

+ (UIButton *)createAutoLayoutButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName isBgImage:(BOOL)isBgImage
{
    
    return [self createAutoLayoutButtonType:type title:title titleColor:titleColor image:imageName ? [UIImage imageNamed:imageName] : nil isBgImage:isBgImage];
}

+ (UIButton *)createAutoLayoutButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor image:(UIImage *)image isBgImage:(BOOL)isBgImage
{
    UIButton *_button = [self createAutoLayoutButtonType:type];
    [_button setTitle:title forState:UIControlStateNormal];
    [_button setTitleColor:titleColor forState:UIControlStateNormal];
    if (image) {
        if (isBgImage) {
            [_button setBackgroundImage:image forState:UIControlStateNormal];
            
        }else {
            [_button setImage:image forState:UIControlStateNormal];
        }
    }
    
    return _button;
}

+ (UIButton *)createAutoLayoutButtonType:(UIButtonType)type normalimageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName
{
    return [self createAutoLayoutButtonType:type normalimage:imageName ? [UIImage imageNamed:imageName] : nil highlightedImage:highlightedImageName ? [UIImage imageNamed:highlightedImageName] : nil];
}

+ (UIButton *)createAutoLayoutButtonType:(UIButtonType)type normalimage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    UIButton *_button = [self createAutoLayoutButtonType:type];
    [_button setImage:image forState:UIControlStateNormal];
    if (highlightedImage) {
        [_button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    return _button;
}

@end
