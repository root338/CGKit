//
//  CGPlaceholderLabel.m
//  BaseModel
//
//  Created by 345 on 14/12/17.
//  Copyright (c) 2014年 345. All rights reserved.
//

#import "CGPlaceholderLabel.h"
#import "UIView+AddLayoutConstraint.h"
#import "UIView+AddLayoutConstraint.h"

@interface CGPlaceholderLabel ()
{
    ///保存设置label的文字
    NSAttributedString *labelAttributedText;
    
    ///标识当前传入的字符串为设置的提示语
    BOOL markIsPlaceholder;
}
//@property (strong, nonatomic, readwrite) UILabel *placeholderLabel;


@end

@implementation CGPlaceholderLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//@synthesize placeholderLabel = _placeholderLabel;
//@synthesize placeholderText = _placeholderText;

//- (UILabel *)placeholderLabel
//{
//    if (_placeholderLabel) {
//        return _placeholderLabel;
//    }
//    
//    _placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
//    _placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addSubview:_placeholderLabel];
//    
//    [_placeholderLabel addConstraintWithAttribute:kGCLayoutAttributeAllEdge];
//    _placeholderLabel.text = _placeholderText;
//    _placeholderLabel.textColor = [UIColor lightGrayColor];
//    return _placeholderLabel;
//}
//
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    self.placeholderText = self.text;
//    self.text = nil;
//}
//
//- (void)setText:(NSString *)text
//{
//    [super setText:text];
//    [self verificationInputText:text];
//}
//
//- (void)setAttributedText:(NSAttributedString *)attributedText
//{
//    [super setAttributedText:attributedText];
//    [self verificationInputText:attributedText.string];
//}
//
//- (void)verificationInputText:(NSString *)text
//{
//    if (text.length) {
//        [self.placeholderLabel removeFromSuperview], _placeholderLabel = nil;;
//    }else {
//        self.placeholderLabel.text = _placeholderText;
//    }
//}
//
//- (void)setPlaceholderText:(NSString *)placeholderText
//{
//    _placeholderText = placeholderText;
//    
//    self.placeholderLabel.text = _placeholderText;
//}

- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = placeholderText;
    [self setupPlaceholder];
}

- (void)setAttributedDictionary:(NSDictionary *)attributedDictionary
{
    _attributedDictionary = attributedDictionary;
    [self setupPlaceholder];
}

- (void)setupPlaceholder
{
    self.placeholderAttributedText = [[NSAttributedString alloc] initWithString:self.placeholderText attributes:self.attributedDictionary];
}

- (void)setPlaceholderAttributedText:(NSAttributedString *)placeholderAttributedText
{
    _placeholderAttributedText = placeholderAttributedText;
    
    
    if ([self inputTextIsNULL]) {
        markIsPlaceholder = YES;
        self.attributedText = placeholderAttributedText;
        markIsPlaceholder = NO;
    }
}

- (void)setText:(NSString *)text
{
    //由于当设置text值为 空值时系统不会自动调用setAttributedText方法，需手动调用
    if (text.length) {
        [super setText:text];
    }else {
        //当出入nil时 临时存储的对象labelAttributedText也会被设置为空
        [self setAttributedText:nil];
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if (!markIsPlaceholder) {
        labelAttributedText = attributedText;
        if ([self inputTextIsNULL]) {
            attributedText = self.placeholderAttributedText;
        }
    }
    [super setAttributedText:attributedText];
}

- (BOOL)inputTextIsNULL
{
    return !labelAttributedText || !labelAttributedText.length;
}
@end
