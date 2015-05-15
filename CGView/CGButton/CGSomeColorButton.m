//
//  CGSomeColorButton.m
//  iSpa
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import "CGSomeColorButton.h"

@interface CGSomeColorButton ()
{
    UIColor *normalForHighlightedColor;
    UIColor *selectedForHighlightedColor;
    
    UIColor *normalColor;
    UIColor *selectedColor;
}
@end

@implementation CGSomeColorButton

+ (UIButton *)createButtonAtTitle:(NSString *)title normalTitleColor:(UIColor *)normalColor selectorTitleColor:(UIColor *)selectorColor
{
    CGSomeColorButton *button = [CGSomeColorButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    
    if (!normalColor) {
        normalColor = [UIColor blackColor];
    }
    if (!selectorColor) {
        selectorColor = [UIColor redColor];
    }
    if (normalColor) {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    
    if (selectorColor) {
        [button setTitleColor:selectorColor forState:UIControlStateSelected];
    }
    
    return button;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    switch (state) {
        case UIControlStateNormal:
            normalColor = color;
            normalForHighlightedColor = [color colorWithAlphaComponent:.7];
            break;
        case UIControlStateSelected:
            selectedColor = color;
            selectedForHighlightedColor = [color colorWithAlphaComponent:.7];
            break;
        default:
            break;
    }
    [super setTitleColor:color forState:state];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    BOOL isSelectedSelf = self.selected;
    //不知道为什么动态改变 button 高亮的标题颜色时，显示的高亮颜色不是按照预设的，所有当高亮时显示 通常状态下的颜色
    //以后明白为什么时再改好。。。
    //注意：这里调用的是父类的 setTitlrColor:forState:方法，为了不改变子类中颜色的预设 -_-
    [super setTitleColor:isSelectedSelf ? selectedForHighlightedColor : normalForHighlightedColor forState:isSelectedSelf ? UIControlStateNormal : UIControlStateHighlighted];
}

- (void)setSelected:(BOOL)selected
{
    
    [super setSelected:selected];
    
    //为了应对高亮时的问题，现在在选中与未选中状态改变时动态还原预设的颜色
    //注意：这里可以调用父类的 setTitleColor:forState:方法也可以调用子类的方法，因为它是还原预设颜色
    [super setTitleColor:selected ? selectedColor : normalColor forState:selected ? UIControlStateSelected : UIControlStateNormal];
}

@end
