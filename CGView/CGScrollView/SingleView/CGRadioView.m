//
//  CGRadioView.m
//  iSpa
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import "CGRadioView.h"

@interface CGRadioView ()
{
    
}

@end

@implementation CGRadioView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)initializationSelectedIndex:(NSInteger)selected
{
    [self performSelector:@selector(setupDefaultSelectedIndex:) withObject:@(selected) afterDelay:0];
}

- (void)setupDefaultSelectedIndex:(NSNumber *)paramIndex
{
    if (paramIndex.integerValue < self.subviews.count) {
        
        [self setSelectIndex:paramIndex.integerValue];
    }else {
#ifdef DEBUG
        NSAssert(nil, @"越界了 -_- ");
#endif
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    if (_selectIndex != selectIndex) {
        _selectIndex = selectIndex;
        
        self.selectControl = (id)[self viewWithTag:_selectIndex];
    }
}

- (void)setSelectControl:(id)selectControl
{
    if (![_selectControl isEqual:selectControl]) {
        
        //取消以前选择控件
        [_selectControl setSelected:NO];
        
        _selectControl = selectControl;
        
        //防止selectedButton 和 selectedIndex 两者循环赋值所以直接实例赋值
        _selectIndex = [_selectControl tag];
        
        [_selectControl setSelected:YES];
        
        if ([self.delegate respondsToSelector:@selector(radioView:selectedControl:)]) {
            
            [self.delegate radioView:self selectedControl:_selectControl];
        }
    }
}

- (void)setupRadioView
{
    [self.subviews enumerateObjectsUsingBlock:^(UIControl* obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj tag] == _selectIndex) {
            self.selectControl = obj;
        }
        if ([self.selectControl isEqual:obj]) {
            self.selectControl = obj;
        }
        
        if ([obj respondsToSelector:@selector(addTarget:action:forControlEvents:)]) {
            [obj addTarget:self action:@selector(handleControlEventAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }];
}

- (void)handleControlEventAction:(id)sender
{
    BOOL isShouldSelectedControl = YES;
    if ([self.delegate respondsToSelector:@selector(radioView:shouldSelectedControl:)]) {
        isShouldSelectedControl = [self.delegate radioView:self shouldSelectedControl:sender];
    }
    
    if (isShouldSelectedControl) {
        self.selectControl = sender;
    }
}
@end