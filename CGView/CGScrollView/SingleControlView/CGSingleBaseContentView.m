//
//  CGSingleBaseContentView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGSingleBaseContentView.h"
#import "PureLayout.h"

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
- (void)setDataSource:(id<CGSingleViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reloadAllView];
}

#pragma mark - setup content view
- (void)clearAllView
{
    //移除所有子视图、并且初始化选择数据
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.selectControl = nil;
}

- (void)reloadAllView
{
    //加载内容为行
    NSInteger total_section = 1;
    
    //每行有多少内容
    NSInteger total_index = [self.dataSource singleView:self numberOfSections:0];
    
    for (NSInteger section = 0; section < total_section; section++) {
        for (NSInteger index = 0; index < total_index; index++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
            
            UIControl *control = [self.dataSource singleView:self controlAtIndex:indexPath];
            [self addSubview:control];
            
            //仅在当前一行下使用，以后扩展到多行时使用 selectIndexPath 属性
            if (self.selectIndex == index || [self.selectControl isEqual:control]) {
                self.selectControl = control;
            }
        }
    }
}


#pragma mark - update layout
- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
        [self.subviews autoRemoveConstraints];
        
        if (self.subviews.count == 1) {
            [self.subviews[0] autoPinEdgesToSuperviewEdgesWithInsets:self.controlEdgeInset];
        }else {
            [self.subviews autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:self.itemSpace insetSpacing:self.spaceMargin matchedSizes:self.matchedSize];
            //此处是否需要加上按钮与父视图之间的约束，以后再看
        }
        
        didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}
@end
