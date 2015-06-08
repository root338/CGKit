//
//  CGBaseControl.m
//  iSpa
//
//  Created by 345 on 15/5/27.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import "CGBaseControl.h"
#import "CGRadioView.h"

typedef NS_ENUM(NSInteger, CGTouchStateType) {
    
    CGTouchStateTypePointInside,
    CGTouchStateTypeBegin,
    CGTouchStateTypeMoved,
    CGTouchStateTypeCancelled,
    CGTouchStateTypeEnded
};

@interface CGBaseControl ()
{
    UIColor *_normalColor;
    
    BOOL _isShouldIsHighlight;
}

@end

@implementation CGBaseControl

- (void)initialization
{
    _normalColor = self.backgroundColor;
    self.highlightColor = _normalColor;
    
    _isShouldIsHighlight = YES;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialization];
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (self.highlighted != highlighted) {
        
        [super setHighlighted:highlighted];
        [self changeBackgroundColorIsHighlight:highlighted];
        
        NSInteger index = [self.radioView indexAtControl:self];
        if (highlighted) {
            if ([self.radioView.delegate respondsToSelector:@selector(radioView:didHighlightAtIndex:)]) {
                [self.radioView.delegate radioView:self.radioView didHighlightAtIndex:index];
            }
        }else {
            if ([self.radioView.delegate respondsToSelector:@selector(radioView:didUnhighlightAtIndex:)]) {
                [self.radioView.delegate radioView:self.radioView didUnhighlightAtIndex:index];
            }
        }
    }
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    
    [self addSubview:contentView];
    if (self.isAutoLayout) {
        
        
    }else {
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.isAutoLayout) {
        _contentView.frame = self.bounds;
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)changeBackgroundColorIsHighlight:(BOOL)isHighlight
{
    self.backgroundColor = isHighlight ? self.highlightColor : _normalColor;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    return [super pointInside:point withEvent:event];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if ([self.radioView.delegate respondsToSelector:@selector(radioView:shouldHighlightAtIndex:)]) {
        _isShouldIsHighlight = [self.radioView.delegate radioView:self.radioView shouldHighlightAtIndex:[self.radioView indexAtControl:self]];
    }
    [self touches:touches stateType:CGTouchStateTypeBegin];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touches:touches stateType:CGTouchStateTypeCancelled];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touches:touches stateType:CGTouchStateTypeMoved];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touches:touches stateType:CGTouchStateTypeEnded];
}

- (BOOL)touches:(NSSet *)touches stateType:(CGTouchStateType)type
{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    return [self point:point stateType:type];
}

- (BOOL)point:(CGPoint)point stateType:(CGTouchStateType)type
{
    BOOL isResult = NO;
    BOOL isAreaContain = NO;
    if (CGRectContainsPoint(self.bounds, point)) {
        
        isResult = YES;
        
        isAreaContain = YES;
        
    }else {
        
        isResult = NO;
    }
    
    if (type == CGTouchStateTypeCancelled || type == CGTouchStateTypeEnded) {
        isResult = NO;
    }
    
    self.highlighted = _isShouldIsHighlight ? isResult : NO;
    
    if (isAreaContain) {
        //点击区域在视图内部
        if (type == CGTouchStateTypeEnded) {
            
            [self sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return isResult;
}
@end
