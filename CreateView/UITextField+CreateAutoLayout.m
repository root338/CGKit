//
//  UITextField+CreateAutoLayout.m
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UITextField+CreateAutoLayout.h"

@implementation UITextField (CreateAutoLayout)

+ (UITextField *)createAutoLayoutTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    return textField;
}


@end
