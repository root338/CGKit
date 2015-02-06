//
//  CGAttributedPlaceholderLabel.h
//  iOSTestProject
//
//  Created by 345 on 15/1/13.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 添加当UILabel没有内容时的文字提示
 
 当使用xib时默认在xib中的title为提示文字
 */
@interface CGAttributedPlaceholderLabel : UILabel

/**
 提示的文本内容
 */
@property (strong, nonatomic) NSString *placeholderText;

/**
 设置的通用提示文本属性
 */
@property (strong, nonatomic) NSDictionary *attributedDic;

/**
 提示文本的属性内容
 */
@property (strong, nonatomic) NSAttributedString *placeholderAttributedString;

@end
