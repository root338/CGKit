//
//  CGTabScrollView.m
//  iSpa
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import "CGSingleControlView.h"
#import "PureLayout.h"
#import "UIViewCommonDefine.h"
#import "CGSomeColorButton.h"
#import "CGSingleContentView.h"
#import "UIView+Frame.h"
#import "CGSingleSliderView.h"
#import "UIControl+CalculateArea.h"

@interface CGSingleControlView ()
{
    ///单选视图
    CGSingleContentView *_contentView;
    
    ///滑块视图
    CGSingleSliderView *_sliderView;
    
    //约束相关
    
    ///标识约束是否添加，避免重复添加
    BOOL didSetupConstraints;
    
    //滑块约束设置
    
    ///滑块水平约束
    NSLayoutConstraint *_sliderHConstraint;
    ///滑块左边与选择控件左边对齐
    NSLayoutConstraint *_sliderLeadingEqual;
}

///查看当前视图按钮是否有选择控件
@property (nonatomic, readonly) BOOL selectControlState;
@end

@implementation CGSingleControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - setting property
- (CGSingleContentView *)contentView
{
    if (_contentView) {
        return _contentView;
    }
    _contentView = [CGSingleContentView newAutoLayoutView];
    
    [self setupCallback];
    
    [self addSubview:_contentView];
    return _contentView;
}

- (CGSingleSliderView *)sliderView
{
    if (_sliderView) {
        return _sliderView;
    }
    
    _sliderView = [CGSingleSliderView createSingleSliderView];
    [self addSubview:_sliderView];
    return _sliderView;
}

- (void)setTitles:(NSArray *)titles
{
    if (![self.contentView.titleArray isEqualToArray:titles]) {
        
        self.contentView.titleArray = [NSMutableArray arrayWithArray:titles];
        
    }
}

- (NSArray *)titles
{
    return self.contentView.titleArray;
}

///设置选择回调
- (void)setupCallback
{
    __weak CGSingleControlView *weakSelf = self;
    if (!_contentView.selectCallback) {
        _contentView.selectCallback = ^(UIControl *selectedControl) {
            
            CGSingleControlView *strongSelf = weakSelf;
            if (strongSelf) {
                strongSelf.selectedControl = selectedControl;
                [strongSelf setupSliderLocation:selectedControl];
            }
        };
    }
    if (!_sliderView.setupWidthTypeChange) {
        _sliderView.setupWidthTypeChange = ^(BOOL isFixedWidth) {
            
            CGSingleControlView *strongSelf = weakSelf;
            if (strongSelf) {
                
                [strongSelf setupSliderConstraints];
            }
        };
    }
}

- (void)setupSliderConstraints
{
    
    [self removeSliderLeadingConstraint];
    
    switch (self.sliderView.sliderWidthType) {
        case CGSliderWidthTypeDefault:
            
        {
            
            _sliderLeadingEqual = [self.selectedControl autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.sliderView];
        }
            break;
        default:
            break;
    }
}

- (void)removeSliderLeadingConstraint
{
    if (_sliderLeadingEqual) {
        [self removeConstraint:_sliderLeadingEqual];
        _sliderLeadingEqual = nil;
    }
}

- (void)removeSliderHConstraint
{
    //当为固定宽度时删除约束滑块宽度的约束
    if (_sliderHConstraint) {
        [self removeConstraint:_sliderHConstraint];
        _sliderHConstraint = nil;
    }
}

///设置滑块的位置
- (void)setupSliderLocation:(UIControl *)selectedControl
{
    //判断是否与按钮标题宽度相等
    //注意：这里按钮宽度是等宽的，自定义的宽度是恒定的（暂定，如果动态也不在这设置），所以这两者不用在选择控件变化时改变滑块宽度
    BOOL isSetupSliderWidth = (self.sliderView.sliderWidthType == CGSliderWidthTypeEqualTitleWidth);
    CGFloat afterSlider = 0;
    
    if (isSetupSliderWidth) {
        //当根据滑块标题设置滑块宽度时执行此方法计算按钮标题宽度
        afterSlider = [selectedControl calculateButtonTitleSize].width;
    }
    
    [UIView animateWithDuration:.3 animations:^{
        
        CGPoint center = _sliderView.center;
        center.x = selectedControl.center.x;
        self.sliderView.center = center;
        if (isSetupSliderWidth) {
            self.sliderView.width = afterSlider;
        }
    } completion:^(BOOL finished) {
        
        [self removeSliderHConstraint];
        
        if (selectedControl) {
            //设置滑块的水平中心等于选择的按钮的水平中心
            _sliderHConstraint = [_sliderView autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:selectedControl];
        }
        if (isSetupSliderWidth) {
            
            self.sliderView.sliderWidth = afterSlider;
        }else {
            [self setupSliderConstraints];
        }
    }];
}

#pragma mark - update layout

- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
        [UIView autoSetPriority:900 forConstraints:^{
            [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        }];
        
        [self.contentView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.sliderView];
        [self.sliderView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}
@end
