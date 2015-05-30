//
//  CGSingleSubView.m
//  PDPracticeDemo
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGSingleSubControl.h"
#import "PureLayout.h"
#import "AreaEdge.h"

@interface CGSingleSubControl ()
{
//    BOOL didSetupConstraints;
}
@end
@implementation CGSingleSubControl

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    
    [self addSubview:contentView];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleEdgeMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _contentView.frame = self.bounds;
}
//- (void)updateConstraints
//{
//    
//    if (didSetupConstraints) {
//        
//        [_contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
//        didSetupConstraints = YES;
//    }
//    [super updateConstraints];
//}
@end
