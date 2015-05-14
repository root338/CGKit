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
    [self clearAllView];
    
    //加载内容为行
    NSInteger total_section = 1;
    
    //每行有多少内容
    NSInteger total_index = [self.dataSource singleView:self numberOfSections:0];
    
    for (NSInteger section = 0; section < total_section; section++) {
        for (NSInteger index = 0; index < total_index; index++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
            UIControl *control = nil;
            
            if ([self.dataSource respondsToSelector:@selector(singleView:controlAtIndex:)]) {
                //若类实现singleView:controlAtIndex:方法，则加载自定义视图
                UIView *subView = [self.dataSource singleView:self controlAtIndex:indexPath];
                CGSingleSubControl *ctl = [CGSingleSubControl newAutoLayoutView];
                ctl.contentView = subView;
                
                control = ctl;
                
            }else if ([self.dataSource respondsToSelector:@selector(singleView:controlTitleAtIndex:)]){
                
                //若类实现singleView:controlTitleAtIndex:方法，则加载需要加载的标题
                NSString *title = [self.dataSource singleView:self controlTitleAtIndex:indexPath];
                UIColor *normalColor = nil;
                UIColor *selectColor = nil;
                
                if ([self.dataSource respondsToSelector:@selector(singleView:titleAtIndexPath:normalColor:selectColor:)]){
                    [self.dataSource singleView:self titleAtIndexPath:indexPath normalColor:&normalColor selectColor:&selectColor];
                }
                UIControl *ctl = [CGSomeColorButton createButtonAtTitle:title normalTitleColor:normalColor selectorTitleColor:selectColor];
                
                control = ctl;
                
            }else {
                NSAssert(nil, @"singleView:controlAtIndex:或singleView:controlTitleAtIndex:必须任意实现其中之一");
            }
            control.tag = indexPath.row;
            
            [self addSubview:control];
            
            //仅在当前一行下使用，以后扩展到多行时使用 selectIndexPath 属性
            if (self.selectIndex == index || [self.selectControl isEqual:control]) {
                self.selectControl = control;
            }
        }
    }
    
    [self setupRadioView];
}


#pragma mark - update layout
- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
//        [self.subviews autoRemoveConstraints];
        
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
    
    [super updateConstraints];
}
@end
