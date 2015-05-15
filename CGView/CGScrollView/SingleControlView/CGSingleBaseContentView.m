//
//  CGSingleBaseContentView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGSingleBaseContentView.h"
#import "PureLayout.h"
#import "CGSomeColorButton.h"
#import "CGSingleSubControl.h"


@interface CGSingleBaseContentView ()
{
    BOOL didSetupConstraints;
}

@end

@implementation CGSingleBaseContentView

#pragma mark - create (init)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        _spaceMargin = YES;
        _itemSpace = 0;
        _matchedSize = YES;
    }
    return self;
}

#pragma mark - setting property

#pragma mark - setup content view

- (void)reloadAllView
{
    
    [super reloadAllView];
    
    //手动刷新页面约束
    [self updateConstraints];
}


#pragma mark - update layout
- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
//        [self.subviews autoRemoveConstraints];
        
        if (self.subviews.count) {
            if (self.subviews.count == 1) {
                [self.subviews[0] autoPinEdgesToSuperviewEdgesWithInsets:self.controlEdgeInset];
            }else {
                [self.subviews autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:self.itemSpace insetSpacing:self.spaceMargin matchedSizes:self.matchedSize];
                //此处是否需要加上按钮与父视图之间的约束，以后再看
                [self.subviews[0] autoPinEdgeToSuperviewEdge:ALEdgeTop];
                [self.subviews[0] autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            }
            
            didSetupConstraints = YES;
        }
        
    }
    
    [super updateConstraints];
}
@end
