//
//  CGAttributedPlaceholderLabel.m
//  iOSTestProject
//
//  Created by 345 on 15/1/13.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "CGAttributedPlaceholderLabel.h"

@interface CGAttributedPlaceholderLabel ()
{
    ///用于标识用户输入的是提示文本还是直接赋值，YES表示有文本，NO表示没有文本
    BOOL isMarkInputText;
    
    ///存储Label的自身文本属性
    NSDictionary *textAttributedDic;
}
@end

@implementation CGAttributedPlaceholderLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initLabel];
    }
    return self;
}

- (void)initLabel
{
    textAttributedDic = @{
                          NSForegroundColorAttributeName : self.textColor,
                          NSFontAttributeName : self.font
                          };
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initLabel];
    
    NSString *labelText = self.attributedText.string;
    self.attributedText = nil;
    self.placeholderText = labelText;
}

/////判断Label的输入内容是否为空
//- (BOOL)judgeLableTextIsNotNull
//{
//    if (self.attributedText && [self.attributedText.string length]) {
//        return YES;
//    }
//    return NO;
//}

- (NSDictionary *)attributedDic
{
    if (_attributedDic) {
        return _attributedDic;
    }
    
    _attributedDic = @{
                       NSForegroundColorAttributeName : [UIColor lightGrayColor],
                       NSFontAttributeName : self.font,
                       };
    return _attributedDic;
}

- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = placeholderText;
    
    if (_placeholderText) {
        [self setPlaceholderAttributedString:[[NSAttributedString alloc] initWithString:_placeholderText attributes:self.attributedDic]];
    }else {
        self.placeholderAttributedString = nil;
    }
}

- (void)setPlaceholderAttributedString:(NSAttributedString *)placeholderAttributedString
{
    _placeholderAttributedString = placeholderAttributedString;
    isMarkInputText ?: [self setAttributedText:nil];
}

- (void)setText:(NSString *)text
{
    if (!text) {
        isMarkInputText = NO;
        [self setAttributedText:nil];
    }else {
        isMarkInputText = YES;
        if (self.attributedText && [text isEqualToString:self.attributedText.string]) {
            return;
        }
        
        [self setAttributedText:[[NSAttributedString alloc] initWithString:text attributes:textAttributedDic]];
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if (attributedText) {
        [super setAttributedText:attributedText];
    }else {
        if (self.placeholderAttributedString) {
            [super setAttributedText:self.placeholderAttributedString];
        }else {
            [super setAttributedText:nil];
        }
    }
}
@end
