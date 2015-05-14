//
//  CGSingleSubView.m
//  PDPracticeDemo
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGSingleSubControl.h"
#import "PureLayout.h"

@interface CGSingleSubControl ()
{
    BOOL didSetupConstraints;
}
@end
@implementation CGSingleSubControl

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    
}

- (void)updateConstraints
{
    if (didSetupConstraints) {
        
        [_contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        didSetupConstraints = YES;
    }
    [super updateConstraints];
}
@end
