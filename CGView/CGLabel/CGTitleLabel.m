//
//  CGTitleLabel.m
//  soho
//
//  Created by 345 on 15/1/6.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import "CGTitleLabel.h"

@interface CGTitleLabel ()


@end

@implementation CGTitleLabel

@synthesize title = _title;
@synthesize content = _content;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _spacingBetweenTheTitleAndContent = 5;
    if (self.attributedText && self.attributedText.length) {
        self.title = self.attributedText;
    }else {
        self.title = [[NSAttributedString alloc] initWithString:self.text attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    }
    
}

- (void)setTitle:(NSAttributedString *)title
{
    if (![_title isEqualToAttributedString:title]) {
        
        _title = title;
        [self setAttributedText:nil];
    }
}

- (void)setContent:(NSAttributedString *)content
{
    if (![_content isEqualToAttributedString:content]) {
        
        _content = content;
        [self setAttributedText:nil];
    }
}

- (void)setText:(NSString *)text
{
    if (text) {
        self.content = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    }else {
        self.content = nil;
    }
    
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if (attributedText) {
        _content = attributedText;
    }
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] init];
    if (_title) {
        [att appendAttributedString:_title];
        
        NSAttributedString *placeholderStr = [[NSAttributedString alloc] initWithString:@" " attributes:@{NSKernAttributeName : @(_spacingBetweenTheTitleAndContent)}];
        [att appendAttributedString:placeholderStr];
    }
    if (_content) {
        [att appendAttributedString:_content];
    }
    
    [super setAttributedText:att];
}
@end
