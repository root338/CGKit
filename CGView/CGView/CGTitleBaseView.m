//
//  CGTitleBaseView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGTitleBaseView.h"
#import "PureLayout.h"

@interface CGTitleBaseView ()
{
    ///标识约束有没有添加成功
    BOOL didSetupConstraints;
}
@end

@implementation CGTitleBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)setRightViewPriority:(CGFloat)rightViewPriority
{
    _rightViewPriority = rightViewPriority;
    [self.leftView setContentHuggingPriority:self.rightViewPriority forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
        [self.leftView autoPinEdgesToSuperviewEdgesWithInsets:self.edgeInsetView excludingEdge:ALEdgeTrailing];
        [self.rightView autoPinEdgesToSuperviewEdgesWithInsets:self.edgeInsetView excludingEdge:ALEdgeLeading];
        [self.leftView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.rightView withOffset:-1 * self.viewSpace];
        [self.rightView setContentHuggingPriority:self.rightViewPriority forAxis:UILayoutConstraintAxisHorizontal];
        
        didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}
@end
