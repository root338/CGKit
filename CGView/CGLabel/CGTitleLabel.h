//
//  CGTitleLabel.h
//  soho
//
//  Created by 345 on 15/1/6.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置UIlabel的标题
 
 当使用xib时默认在xib中的title为提示文字，在xib环境下优先使用 Label 的attributedText属性
 
 */
@interface CGTitleLabel : UILabel

/**
 显示的标题的属性
 */
@property (strong, nonatomic) NSAttributedString *title;

/**
 显示内容的属性
 */
@property (strong, nonatomic) NSAttributedString *content;

/**
 设置标题与内容的间距
 
 只在有标题的情况下有效
 */
@property (assign, nonatomic) float spacingBetweenTheTitleAndContent;
@end
