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
#import "CGSingleBaseContentView.h"

@interface CGSingleContentView ()<CGSingleViewDataSource, CGRadioViewDelegate>
{
    BOOL didSetupConstraints;
    
    CGSingleBaseContentView *_contentView;
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
    if (!_contentView) {
        _contentView = [[CGSingleBaseContentView alloc] init];
        
        //放在_contentView.dataSource = self;代码前面时，默认选择时也会回调
        _contentView.delegate = self;
        
        [self addSubview:_contentView];
    }
    
    _contentView.dataSource = self;
    
}

#pragma mark - update layout
- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
        [_contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        didSetupConstraints = YES;
    }
    [super updateConstraints];
}

#pragma mark - CGSingleViewDataSource
- (NSInteger)singleView:(CGRadioView *)singleView numberOfSections:(NSInteger)index
{
    return self.titleArray.count;
}

- (NSString *)singleView:(CGRadioView *)singleView controlTitleAtIndex:(NSIndexPath *)indexPath
{
    return self.titleArray[indexPath.row];
}

- (void)singleView:(CGRadioView *)singleView titleAtIndexPath:(NSIndexPath *)indexPath normalColor:(UIColor *__autoreleasing *)normalColor selectColor:(UIColor *__autoreleasing *)selectColor
{
    *normalColor = self.normalTitleColor;
    *selectColor = self.selectedTitleColor;
}

#pragma mark - CGRadioViewDelegate
- (void)radioView:(CGRadioView *)radioView selectedControl:(UIControl *)selectedControl
{
    if (self.selectCallback) {
        
//        NSAssert([selectedControl isKindOfClass:[UIButton class]], @"必须是UIButton的子类");
        self.selectCallback((id)selectedControl);
    }
}

@end
