//
//  UIView+CreateSubAutoLayout.m
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIView+CreateSubAutoLayout.h"
#import "CreateView.h"

@implementation UIView (CreateSubAutoLayout)

- (instancetype)createSubAutoLayoutClass:(Class)subViewclass
{
    
    UIView *view = [[subViewclass alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:view];
    
    return view;
}

- (instancetype)createSubAutoLayoutType:(CGCreateSubViewType)viewType
{
    UIView *view = nil;
    
    switch (viewType) {
        case CGCreateSubViewTypeButton:
            view = [UIButton createDefaultAutoButton];
            break;
        case CGCreateSubViewTypeTextField:
            view = [UITextField createAutoLayoutTextField];
            break;
        case CGCreateSubViewTypeLabel:
            view = [UILabel createAutoLayoutLabel];
            break;
        case CGCreateSubViewTypeView:
            view = [UIView new];
            break;
        default:
            break;
    }
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    
    return view;
}
@end
