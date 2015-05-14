//
//  UIControl+CalculateArea.m
//  PDPracticeDemo
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIControl+CalculateArea.h"

@implementation UIControl (CalculateArea)

- (CGSize)calculateButtonTitleSize
{
    CGSize titleSize = CGSizeZero;
    if ([self isKindOfClass:[UIButton class]]) {
        
        UIButton *btn = (id)self;
        NSAttributedString *titleAttributed = [btn currentAttributedTitle];
        if (titleAttributed) {
            
            titleSize = titleAttributed.size;
        }else {
            
            NSString *title = [btn currentTitle];
            titleSize = [title sizeWithAttributes:@{
                                                    NSFontAttributeName : btn.titleLabel.font
                                                    }];
        }
    }else {
        
#ifdef EDBUG
        NSLog(@"不是按钮，无法计算其标题长度");
#endif
    }
    
    return titleSize;
}

@end
