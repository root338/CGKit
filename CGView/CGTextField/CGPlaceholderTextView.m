//
//  CGPlaceholderTextView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGPlaceholderTextView.h"
#import "PureLayout.h"

@interface CGPlaceholderTextView ()
{
    /**
     *  提示的文本容器
     */
    UILabel *_placeholderLabel;
    
    /**
     *  是否设置好约束的标志
     */
    BOOL didSetupConstraints;
    
    /**
     *  提示文本的字体
     */
    UIFont *_fontPlaceholder;
    
    /**
     *  是否使用文本视图的字体样式
     */
    BOOL isApplyTextViewFont;
}

@end

@implementation CGPlaceholderTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - 自定义实例的实现
- (UIColor *)placeholderTextColor
{
    if (_placeholderTextColor) {
        return _placeholderTextColor;
    }
    
    _placeholderTextColor = [UIColor lightGrayColor];
    return _placeholderTextColor;
}

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = [UILabel newAutoLayoutView];
        _placeholderLabel.font = _fontPlaceholder;
        _placeholderLabel.textColor = self.placeholderTextColor;
        [self addSubview:_placeholderLabel];
        
//        [self updateConstraintsIfNeeded];
//        [self setNeedsUpdateConstraints];
//        
//        [self layoutIfNeeded];
//        [self setNeedsLayout];
    }
    
    return _placeholderLabel;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    if (!self.text || !self.text.length) {
        [self placeholderLabel].text = placeholder;
    }
}

#pragma mark - 重写系统方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    _fontPlaceholder = font;
}

#pragma mark - 更新视图约束
- (void)updateConstraints
{
    if (!didSetupConstraints) {
//        [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:self.edgeInsetMarginForPlaceholder.top];
//        [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:self.edgeInsetMarginForPlaceholder.left];
//        [UIView autoSetPriority:800 forConstraints:^{
//            
//            [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:self.edgeInsetMarginForPlaceholder.bottom];
//            [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:self.edgeInsetMarginForPlaceholder.right];
//        }];
        [_placeholderLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        didSetupConstraints = YES;
    }
    [super updateConstraints];
}
@end
