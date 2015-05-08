//
//  CGRadioView.h
//  iSpa
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGRadioView;
@protocol CGRadioViewDelegate <NSObject>

@optional
/**
 *  选择控件之后的回调
 *
 *  @param radioView       操作的主视图
 *  @param selectedControl 选择的控件
 */
- (void)radioView:(CGRadioView *)radioView selectedControl:(UIControl *)selectedControl;

@end

/**
 单选视图
 */
@interface CGRadioView : UIView

@property (weak, nonatomic) id<CGRadioViewDelegate> delegate;

/**
 选择的控件
 */
@property (strong, nonatomic) UIControl* selectControl;

/**
 选择的控件索引，即control的tag值
 */
@property (assign, nonatomic) NSInteger selectIndex;

/**
 *  设置单选视图，在添加完控件后更新视图信息
 */
- (void)setupRadioView;
@end
