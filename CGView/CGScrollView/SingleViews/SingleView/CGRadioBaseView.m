//
//  CGRadioBaseView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGRadioBaseView.h"
#import "CGSomeColorButton.h"
#import "CGSingleSubControl.h"
#import "PureLayout.h"
#import "UIView+Frame.h"

@interface CGRadioBaseView ()
{
    NSInteger _totalNumber;
}

@end

@implementation CGRadioBaseView

- (void)setDataSource:(id<CGSingleViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self performSelector:@selector(reloadAllView) withObject:nil afterDelay:0.0];
    //    [self reloadAllView];
}

- (void)clearContentView
{
    //移除所有子视图、并且初始化选择数据
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.selectControl = nil;
}

- (void)reloadAllView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(reloadAllView) object:nil];
    //清除子视图
    [self clearContentView];
    
    //加载内容为行
    NSInteger totalSection = 1;
    _totalNumber = [self.dataSource singleView:self numberOfSections:0];
    
    CGFloat totalWidth = 0;
    
    for (NSInteger section = 0; section < totalSection; section++) {
        
        for (NSInteger row = 0; row < _totalNumber; row++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UIControl *control = [self setupRadioContentViewAtIndexPath:indexPath];
            [self setupRadioContent:control frameAtIndexPath:indexPath totalWidth:&totalWidth];
            
            control.tag = indexPath.row;
            [self addSubview:control];
            
            //仅在当前一行下使用，以后扩展到多行时使用 selectIndexPath 属性
            if (self.selectIndex == indexPath.row || [self.selectControl isEqual:control]) {
                self.selectControl = control;
            }
        }
    }
    
    self.totalWidths = totalWidth;
    [self setupRadioView];
    
    if (self.didSetupViewFinish) {
        
        self.didSetupViewFinish();
    }
}

- (UIControl *)setupRadioContentViewAtIndexPath:(NSIndexPath *)indexPath
{
    UIControl *control = nil;
    if ([self.dataSource respondsToSelector:@selector(singleView:controlAtIndex:)]) {
        
        //若类实现singleView:controlAtIndex:方法，则加载自定义视图
        UIView *subView = [self.dataSource singleView:self controlAtIndex:indexPath];
        
        CGSingleSubControl *ctl = [[CGSingleSubControl alloc] init];
        
        ctl.translatesAutoresizingMaskIntoConstraints = self.isAutoLaout;
        
        ctl.contentView = subView;
        
        control = ctl;
    }else if ([self.dataSource respondsToSelector:@selector(singleView:controlTitleAtIndex:)]) {
        
        NSString *title = [self.dataSource singleView:self controlTitleAtIndex:indexPath];
        control = [self setupRadioDefaultControlAtIndexPath:indexPath title:title];
    }else {
        
        NSAssert(nil, @"singleView:controlAtIndex:或singleView:controlTitleAtIndex:必须任意实现其中之一");
    }
    
    return control;
}

- (UIControl *)setupRadioDefaultControlAtIndexPath:(NSIndexPath *)indexPath title:(NSString *)title
{
    UIColor *normalColor = nil;
    UIColor *selectColor = nil;
    
    if ([self.dataSource respondsToSelector:@selector(singleView:titleAtIndexPath:normalColor:selectColor:)]){
        [self.dataSource singleView:self titleAtIndexPath:indexPath normalColor:&normalColor selectColor:&selectColor];
    }
    UIControl *ctl = [CGSomeColorButton createButtonAtTitle:title normalTitleColor:normalColor selectorTitleColor:selectColor];
    
    return ctl;
}

- (void)setupRadioContent:(UIControl *)control frameAtIndexPath:(NSIndexPath *)indexPath totalWidth:(CGFloat *)totalWidth
{
    
    CGFloat width = self.itemWidth;
    if (!self.isAutoLaout && [self.dataSource respondsToSelector:@selector(singleView:widthForIndexPath:)]) {
        
        width = [self.dataSource singleView:self widthForIndexPath:indexPath];
    }
    
    CGFloat totalAllWidth = *totalWidth + self.itemSpace;
    control.frame = CGRectMake(totalAllWidth, 0, width, self.itemHeight);
    
    *totalWidth += control.width + self.itemSpace;
}

- (UIView *)selectedNextView
{
    return [self selectedIsNextView:YES];
}

- (UIView *)selectedPreviousView
{
    return [self selectedIsNextView:NO];
}

- (UIView *)selectedIsNextView:(BOOL)isNextView
{
    UIView *view = nil;
    if (self.selectControl) {
        view = [self viewWithTag:self.selectControl.tag + (isNextView ? 1 : -1)];
    }
    return view;
}
@end
