//
//  CGCycleContentView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGCycleContentView.h"

@implementation CGCycleContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setDetailContentView:(UIView *)detailContentView
{
    _detailContentView = detailContentView;
    [self addSubview:detailContentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.detailContentView.frame = self.bounds;
}

@end
