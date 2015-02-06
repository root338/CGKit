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

@property (strong, nonatomic) NSString *placeholderText;
@property (strong, nonatomic, readonly) UILabel *placeholderLabel;
@end
