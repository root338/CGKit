//
//  CGBaseControl.h
//  iSpa
//
//  Created by 345 on 15/5/27.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGRadioView;

@interface CGBaseControl : UIControl

/**
 高亮时的颜色
 */
@property (strong, nonatomic) UIColor *highlightColor;

@property (weak, nonatomic) CGRadioView *radioView;

@property (strong, nonatomic) UIView *contentView;

@property (assign, nonatomic) BOOL  isAutoLayout;
@end
