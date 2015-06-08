//
//  CGRadioViewDelegate.h
//  SingleView
//
//  Created by 345 on 15/5/26.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CGRadioView;
@protocol CGRadioViewDelegate <NSObject>

@optional
/**
 *  选择控件之后的回调
 */
- (void)radioView:(CGRadioView *)radioView selectedAtIndex:(NSInteger)selectedIndex;

/**
 *  返回所选择的控件是否应该被选
 */
- (BOOL)radioView:(CGRadioView *)radioView shouldSelectedIndex:(NSInteger)selectedIndex;

/**
 *  是否高亮
 */
- (BOOL)radioView:(CGRadioView *)radioView shouldHighlightAtIndex:(NSInteger)index;

/**
 *  控件即将高亮时回调
 */
- (void)radioView:(CGRadioView *)radioView didHighlightAtIndex:(NSInteger)index;

/**
 *  控件高亮消失时回调
 */
- (void)radioView:(CGRadioView *)radioView didUnhighlightAtIndex:(NSInteger)index;
@end