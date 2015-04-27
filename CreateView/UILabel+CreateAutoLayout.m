//
//  UILabel+CreateAutoLayout.m
//  PDPracticeDemo
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UILabel+CreateAutoLayout.h"

@implementation UILabel (CreateAutoLayout)

+ (UILabel *)createAutoLayoutLabel
{
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    return label;
}

+ (UILabel *)createCustormizedLabel:(UIColor *)textColor
{
    UILabel *label = [self createAutoLayoutLabel];
    
    label.font = [UIFont systemFontOfSize:14];
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = .6;
    label.textColor = textColor;
    
    return label;
}
@end
