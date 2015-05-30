//
//  UIButton+GCLayout.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIButton+GCLayout.h"

@implementation UIButton (GCLayout)

- (void)centerImageAndButton:(CGFloat)gap imageOnTop:(BOOL)imageOnTop
{
    NSInteger sign = imageOnTop ? 1 : -1;
    
    CGSize imageSize = self.imageView.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake((imageSize.height+gap)*sign, -imageSize.width, 0, 0);
    
    CGSize titleSize = self.titleLabel.bounds.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height+gap)*sign, 0, 0, -titleSize.width);
}

@end
