//
//  CGSingleSliderView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGSingleSliderView.h"

@implementation CGSingleSliderView

#pragma mark - create (init) sliderView
+ (instancetype)createSingleSliderView
{
    CGSingleSliderView *sliderView = [[CGSingleSliderView alloc] init];
    return sliderView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

#pragma mark - setting property
- (void)setSliderColor:(UIColor *)sliderColor
{
    _sliderColor = sliderColor;
}

- (void)setSliderHeight:(CGFloat)sliderHeight
{
    _sliderHeight = sliderHeight;
}

- (void)setSliderWidth:(CGFloat)sliderWidth
{
    _sliderWidth = sliderWidth;
}

- (void)setSliderWidthType:(CGSliderWidthType)sliderWidthType
{
    _sliderWidthType = sliderWidthType;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
