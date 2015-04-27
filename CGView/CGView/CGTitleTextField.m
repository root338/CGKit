//
//  CGTitleTextField.m
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGTitleTextField.h"


@interface CGTitleTextField ()

/**
 *  显示的标题
 */
@property (strong, nonatomic, readwrite) CGBaseLabel *titleLabel;

/**
 *  输入文本框
 */
@property (strong, nonatomic, readwrite) CGBaseTextField *inputTextField;
@end

@implementation CGTitleTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.leftView = self.titleLabel;
        [self addSubview:self.titleLabel];
        
        self.rightView = self.inputTextField;
        [self addSubview:self.inputTextField];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGBaseLabel *)titleLabel
{
    if (_titleLabel) {
        return _titleLabel;
    }
    ///初始化
    
    _titleLabel = [[CGBaseLabel alloc] init];
    
    return _titleLabel;
}

- (CGBaseTextField *)inputTextField
{
    if (_inputTextField) {
        return _inputTextField;
    }
    
    ///初始化
    _inputTextField = [[CGBaseTextField alloc] init];
    
    return _inputTextField;
}

@end
