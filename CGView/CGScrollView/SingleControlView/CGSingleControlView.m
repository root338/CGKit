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

@interface CGSingleControlView ()<CGRadioViewDelegate>
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
    ///滑块高度约束
    NSLayoutConstraint *_sliderHeightConstraint;
    ///滑块高度约束
    NSLayoutConstraint *_sliderWidthConstraint;
}

///查看当前视图按钮是否有选择控件
@property (nonatomic, readonly) BOOL selectControlState;
@end

@implementation CGSingleControlView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)setTitles:(NSArray *)titles
{
    if (![_titles isEqualToArray:titles]) {
        _titles = titles;
        
        [self setupContentView];
    }
}

- (void)setSliderHeight:(CGFloat)sliderHeight
{
    _sliderHeight = sliderHeight;
    [self setupSliderViewHeight];
}

- (void)setSliderWidth:(CGFloat)sliderWidth
{
    _sliderWidth = sliderWidth;
    
    [self setupSliderViewWidth];
}

- (void)setSliderColor:(UIColor *)sliderColor
{
    if (![_sliderColor isEqual:sliderColor]) {
        
        _sliderColor = sliderColor;
        [self sliderView].backgroundColor = self.sliderColor;
    }
}

//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    
////    self.sliderWidthType = CGSliderWidthTypeEqualTitleWidth;
//}

- (CGRadioView *)radioSetView
{
    return _contentView;
}

- (UIColor *)normalTitleColor
{
    if (_normalTitleColor) {
        return _normalTitleColor;
    }
    
    _normalTitleColor = [UIColor blackColor];
    return _normalTitleColor;
}

- (UIColor *)selectedTitleColor
{
    if (_selectedTitleColor) {
        return _selectedTitleColor;
    }
    
    _selectedTitleColor = __KRGB(253,120,1);
    return _selectedTitleColor;
}

///添加按钮视图
- (void)setupContentView
{
    if (![_contentView superview]) {
        
        //创建单选按钮视图 并添加到主视图上去
        _contentView = [CGRadioView newAutoLayoutView];
        [self addSubview:_contentView];
    }
    
    //删除所有子视图
    for (UIView *view in _contentView.subviews) {
        
        
        [view removeFromSuperview];
    }
    
    //设置单选视图中的选择控件
    for (NSInteger index = 0; index < self.titles.count; index++) {
        
        //对于以后按钮的样式不同的问题，可以继承UIButton 自定义实现
        //这里使用点击按钮时，当前标题颜色变浅的效果
        
        //创建按钮
        UIButton *button = [self createSingleButtonAtIndex:index];
        
        [_contentView addSubview:button];
        
        //设置添加的选择按钮，默认为0
        if (index == _contentView.selectIndex) {
            _contentView.selectControl = button;
        }
    }
    
//    //默认选择索引
//    _contentView.selectIndex = 0;
    
    //添加代理执行回调
    [_contentView setDelegate:self];
    [_contentView setupRadioView];
    
    if (!_sliderColor) {
        //当滑块没有默认颜色时使用按钮高亮的颜色为默认颜色
        self.sliderColor = self.selectedTitleColor;
    }
    
    //创建滑块并添加到主视图
    [self sliderView];
}

- (UIButton *)createSingleButtonAtIndex:(NSInteger)index
{
    CGSomeColorButton *button = [CGSomeColorButton buttonWithType:UIButtonTypeCustom];
    
    //设置视图索引
    button.tag = index;
    
    //设置按钮内部内容
    [button setTitle:self.titles[index] forState:UIControlStateNormal];
    
    //设置按钮外观颜色
    [button setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
    [button setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
    
    return button;
}

- (UIView *)sliderView
{
    if (![_sliderView superview]) {
        _sliderView = [CGSingleSliderView createSingleSliderView];
        [self addSubview:_sliderView];
    }
    return _sliderView;
}

#pragma mark - CGRadioViewDelegate
- (void)radioView:(CGRadioView *)radioView selectedControl:(UIControl *)selectedControl index:(NSInteger)index
{
    //判断是否与按钮标题宽度相等
    //注意：这里按钮宽度是等宽的，自定义的宽度是恒定的（暂定，如果动态也不在这设置），所以这两者不用在选择控件变化时改变滑块宽度
    BOOL isSetupSliderWidth = (self.sliderWidthType == CGSliderWidthTypeEqualTitleWidth);
    CGFloat afterSlider = 0;
    
    if (isSetupSliderWidth) {
        //当根据滑块标题设置滑块宽度时执行此方法计算按钮标题宽度
        afterSlider = [self calculateSelectControlTitle];
    }
    
    [UIView animateWithDuration:.3 animations:^{
        
        CGPoint center = _sliderView.center;
        center.x = selectedControl.center.x;
        _sliderView.center = center;
        if (isSetupSliderWidth) {
            _sliderView.width = afterSlider;
        }
    } completion:^(BOOL finished) {
        
        [self setupSliderH];
        if (isSetupSliderWidth) {
            [self setupSliderWidthConstraint:afterSlider];
        }
    }];
    if ([self.delegate respondsToSelector:@selector(tabScrollView:selectedButton:index:)]) {
        [self.delegate tabScrollView:self selectedButton:(id)selectedControl index:index];
    }
}

/**
 *  计算按钮标题的宽度
 *  @warning 此方法只适用UIButton类或其子类
 *
 *  @return 返回计算后的宽度
 */
- (CGFloat)calculateSelectControlTitle
{
    CGSize titleSize = CGSizeZero;
    
    if ([_contentView.selectControl isKindOfClass:[UIButton class]]) {
        UIButton *button = (id)_contentView.selectControl;
        NSString *title = [button currentTitle];
        
        titleSize = [title sizeWithAttributes:@{
                                                NSFontAttributeName  : button.titleLabel.font
                                                }];
    }
    return titleSize.width;
}

#pragma mark - update layout
- (BOOL)selectControlState
{
    return _contentView && _contentView.selectControl;
}

- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
        
        [_contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, _sliderHeight, 0)];
        
        NSArray *arrays = _contentView.subviews;
        if (arrays.count == 1) {
            [arrays[0] autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        }else {
            [arrays autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:self.controlSpace];
            [arrays[0] autoConstrainAttribute:ALAttributeHorizontal toAttribute:ALAttributeHorizontal ofView:_contentView];
        }
        
        //设置滑块的宽度
//        _sliderWidthConstraint = [_sliderView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:arrays[0]];
        [self setSliderWidth:0];
        
        //设置滑块的高度
        if (_sliderHeight <= 0.00001) {
            self.sliderHeight = 2;
        }
//        _sliderHeightConstraint = [_sliderView autoSetDimension:ALDimensionHeight toSize:_sliderHeight];
        
        //设置滑块底部与父视图底部对齐
        [_sliderView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [self setupSliderH];
        
        didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)setupSliderH
{
    if (_sliderHConstraint) {
        
        [self removeConstraint:_sliderHConstraint];
    }
    if (_contentView.selectControl) {
        //设置滑块的水平中心等于选择的按钮的水平中心
        _sliderHConstraint = [_sliderView autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeVertical ofView:_contentView.selectControl];
    }
}

- (void)setupSliderViewHeight
{
    if (!self.selectControlState) {
        return;
    }
    [self sliderView];
    
    if (!_sliderHeightConstraint) {
        
        _sliderHeightConstraint = [_sliderView autoSetDimension:ALDimensionHeight toSize:_sliderHeight];
    }else {
        
//        if (_sliderHeightConstraint) {
//            [UIView animateWithDuration:0.3 animations:^{
//
//                CGFloat beforeHeight = _sliderView.height;
//                _sliderView.y -= self.sliderHeight - beforeHeight;
//                _sliderView.height = self.sliderHeight;
//            } completion:^(BOOL finished) {
        
        _sliderHeightConstraint.constant = self.sliderHeight;
//            }];
//        }
    }
}

- (void)setupSliderViewWidth
{
    if (!self.selectControlState) {
        return;
    }
    
    if (_sliderWidthConstraint) {
        //当滑块的宽度约束不为nil时移除视图中设置滑块宽度约束
        
        NSArray *views = @[self, _sliderView];
        for (UIView *view in views) {
            if ([view.constraints containsObject:_sliderWidthConstraint]) {
                [view removeConstraint:_sliderWidthConstraint];
                break;
            }
        }
    }
    
    switch (self.sliderWidthType) {
        case CGSliderWidthTypeCustomWidth:
        {
            [self setupSliderWidthConstraint:self.sliderWidth];
        }
            break;
        case CGSliderWidthTypeEqualTitleWidth:
        {
            
            _sliderWidth = [self calculateSelectControlTitle];
            [self setupSliderWidthConstraint:_sliderWidth];
        }
            break;
        default:
            [_sliderView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_contentView.selectControl];
            break;
    }
}

- (void)setupSliderWidthConstraint:(CGFloat)widthConstraint
{
    if (_sliderWidthConstraint) {
        
        _sliderWidthConstraint.constant = widthConstraint;
    }else {
        
        _sliderWidthConstraint = [_sliderView autoSetDimension:ALDimensionWidth toSize:widthConstraint];
    }
}
@end
