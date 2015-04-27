//
//  CGPlaceholderLabel.h
//  BaseModel
//
//  Created by 345 on 14/12/17.
//  Copyright (c) 2014年 345. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UILabel显示提示文字
 
 当使用xib时默认在xib中的title为提示文字
 */
@interface CGPlaceholderLabel : UILabel

//@property (strong, nonatomic) NSString *placeholderText;
//@property (strong, nonatomic, readonly) UILabel *placeholderLabel;

/**
 默认添加的提示文字
 */
@property (strong, nonatomic) NSString *placeholderText;

/**
 为提示文字placeholderText 设置的属性
 */
@property (strong, nonatomic) NSDictionary *attributedDictionary;

/**
 显示的带属性提示文字，会忽略attributedDictionary属性
 */
@property (strong, nonatomic) NSAttributedString *placeholderAttributedText;

@end
