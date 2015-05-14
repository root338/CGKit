//
//  CGSingleContentView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGSingleContentView.h"
#import "PureLayout.h"
#import "CGSomeColorButton.h"

@interface CGSingleContentView ()
{
//    BOOL didSetupConstraints;
}
@end

@implementation CGSingleContentView

#pragma mark - create (init) 



#pragma mark - setup content view
- (void)setTitleArray:(NSMutableArray *)titleArray
{
    if (![_titleArray isEqualToArray:titleArray]) {
        _titleArray = titleArray;
        [self setupContentView];
    }
}

///用于初始化内容视图
- (void)setupContentView
{
    if (self.delegate) {
        
    }
}

#pragma mark - update layout
- (void)updateConstraints
{
    [super updateConstraints];
}

#pragma mark - CGSingleViewDataSource
- (NSInteger)singleView:(CGRadioView *)singleView numberOfSections:(NSInteger)index
{
    return self.titleArray.count;
}

- (UIControl *)singleView:(CGRadioView *)singleView controlAtIndex:(NSIndexPath *)indexPath
{
    CGSomeColorButton *button = [CGSomeColorButton buttonWithType:UIButtonTypeCustom];
    
    ///仅在一行时有用
    //设置视图索引
    button.tag = indexPath.row;
    
    //设置按钮内部内容
    [button setTitle:self.titleArray[indexPath.row] forState:UIControlStateNormal];
    
    //设置按钮外观颜色
    [button setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
    [button setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
    
    return button;
}
@end
