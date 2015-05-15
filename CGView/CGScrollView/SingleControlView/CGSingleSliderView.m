//
//  CGSingleSliderView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGSingleSliderView.h"
#import "UIViewCommonDefine.h"
#import "PureLayout.h"

@interface CGSingleSliderView ()
{
    NSLayoutConstraint *heightConstraint;
//    NSLayoutConstraint *widthConstraint;
}

@end

@implementation CGSingleSliderView

#pragma mark - create (init) sliderView
+ (instancetype)createSingleSliderView
{
    CGSingleSliderView *sliderView = [[CGSingleSliderView alloc] init];
    return sliderView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.sliderHeight = 2;
        _sliderWidthType = CGSliderWidthTypeDefault;
    }
    return self;
}

#pragma mark - setting property
//- (void)setSliderColor:(UIColor *)sliderColor
//{
//    _sliderColor = sliderColor;
//    self.backgroundColor = _sliderColor;
//}

- (void)setSliderHeight:(CGFloat)sliderHeight
{
    if (_sliderHeight != sliderHeight) {
        
        _sliderHeight = sliderHeight;
        
        if (heightConstraint) {
            [self removeConstraint:heightConstraint];
        }
        heightConstraint = [self autoSetDimension:ALDimensionHeight toSize:_sliderHeight];
    }
    
}

//- (void)setSliderWidth:(CGFloat)sliderWidth
//{
//    
//    _sliderWidth = sliderWidth;
//    [self handleWidthTypeChange];
//}

- (void)setSliderWidthType:(CGSliderWidthType)sliderWidthType
{
    
    _sliderWidthType = sliderWidthType;
//    [self handleWidthTypeChange];
}

//- (void)handleWidthTypeChange
//{
//    BOOL isFixed = NO;
//    switch (_sliderWidthType) {
//        case CGSliderWidthTypeDefault:
//            
//            [self removeWidthConstraint];
//            break;
//        case CGSliderWidthTypeCustomWidth:
//        case CGSliderWidthTypeEqualTitleWidth:
//            
//            isFixed = YES;
//            [self setupWidthConstraint:_sliderWidth];
//            break;
//        default:
//            break;
//    }
//    [self senderCallback:isFixed];
//}

//- (void)removeWidthConstraint
//{
//    if (heightConstraint) {
//        [self removeConstraint:heightConstraint];
//        heightConstraint = nil;
//    }
//}

//- (void)setupWidthConstraint:(CGFloat)width
//{
//    if (widthConstraint) {
//        widthConstraint.constant = width;
//    }else {
//        widthConstraint = [self autoSetDimension:ALDimensionWidth toSize:width];
//    }
//}
//
//- (void)senderCallback:(BOOL)isFixedWidth
//{
//    if (self.setupWidthTypeChange) {
//        self.setupWidthTypeChange(isFixedWidth);
//    }
//}

//#pragma mark - setup slider location
//- (void)setupSliderLeadingToViewEqual:(UIView *)view
//{
//    
//}
//
//- (void)setupSliderWidthEqual:(CGFloat)width
//{
//    
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
