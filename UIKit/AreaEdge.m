//
//  NSObject+AreaEdge.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AreaEdge.h"

UIEdgeInsets UIEdgeInsetsEqualMake(CGFloat value)
{
    return UIEdgeInsetsMake(value, value, value, value);
}

const UIViewAutoresizing UIViewAutoresizingFlexibleEdgeMargin = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;

const UIViewAutoresizing UIViewAutoresizingFlexibleSize = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;