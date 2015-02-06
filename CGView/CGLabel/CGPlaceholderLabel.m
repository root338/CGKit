//
//  CGPlaceholderLabel.m
//  BaseModel
//
//  Created by 345 on 14/12/17.
//  Copyright (c) 2014年 345. All rights reserved.
//

#import "CGPlaceholderLabel.h"
#import "UIView+AddLayoutConstraint.h"

@interface CGPlaceholderLabel ()

@property (strong, nonatomic, readwrite) UILabel *placeholderLabel;

@end

@implementation CGPlaceholderLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize placeholderLabel = _placeholderLabel;
@synthesize placeholderText = _placeholderText;

- (UILabel *)placeholderLabel
{
    if (_placeholderLabel) {
        return _placeholderLabel;
    }
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_placeholderLabel];
    
    [_placeholderLabel addConstraintWithAttribute:kGCLayoutAttributeAllEdge];
    _placeholderLabel.text = _placeholderText;
    _placeholderLabel.textColor = [UIColor lightGrayColor];
    return _placeholderLabel;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.placeholderText = self.text;
    self.text = nil;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self verificationInputText:text];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self verificationInputText:attributedText.string];
}

- (void)verificationInputText:(NSString *)text
{
    if (text.length) {
        [self.placeholderLabel removeFromSuperview], _placeholderLabel = nil;;
    }else {
        self.placeholderLabel.text = _placeholderText;
    }
}

- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = placeholderText;
    
    self.placeholderLabel.text = _placeholderText;
}
@end
