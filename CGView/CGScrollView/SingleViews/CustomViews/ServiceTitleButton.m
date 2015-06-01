//
//  ServiceTitleButton.m
//  iSpa
//
//  Created by 345 on 15/5/29.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import "ServiceTitleButton.h"
#import "PureLayout.h"
#import "CommonHeader.h"

@interface ServiceTitleButton ()
{
    BOOL didSetupConstraints;
    
    UIColor *normalColor;
    UIColor *selectedColor;
    
    NSMutableArray *constraintsArray;
}

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation ServiceTitleButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        normalColor = [UIColor blackColor];
        selectedColor = __KRGB(253,120,1);
    }
    return self;
}

- (void)rorationImage:(CGFloat)roration
{
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:.3 animations:^{
        self.imageView.transform = CGAffineTransformMakeRotation(roration);
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}

- (void)setIsRorationAngle:(BOOL)isRorationAngle
{
    if (_isRorationAngle != isRorationAngle && self.userInteractionEnabled) {
        _isRorationAngle = isRorationAngle;
        [self rorationImage:isRorationAngle ? M_PI : 0];
    }
}

- (UIView *)contentView
{
    self.isAutoLayout = YES;
    UIView *contentView = [super contentView];
    if (contentView == nil) {
        
        contentView = [UIView newAutoLayoutView];
        [self addSubview:contentView];
        
        self.contentView = contentView;
    }
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    return contentView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    if (image && self.imageView == nil) {
        
        self.imageView = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:self.imageView];
    }
    [self.imageView setImage:image];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    if (title.length && self.titleLabel == nil) {
        self.titleLabel = [UILabel newAutoLayoutView];
        [self.contentView addSubview:self.titleLabel];
    }
    [self.titleLabel setText:title];
}

- (void)setType:(ServiceImageLocationType)type
{
    if (_type != type) {
        _type = type;
        
        didSetupConstraints = NO;
        [self updateConstraints];
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    UIColor *color = self.selected ? selectedColor : normalColor;
    if (highlighted) {
        UIColor *highlightColor = [color colorWithAlphaComponent:.7];
        self.titleLabel.textColor = highlightColor;
    }else {
        self.titleLabel.textColor = color;
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.titleLabel.textColor = selected ? selectedColor : normalColor;
}

- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
        if (constraintsArray == nil) {
            constraintsArray = [NSMutableArray new];
        }else {
            [self removeConstraints:constraintsArray];
            [constraintsArray removeAllObjects];
        }
        
        [self setupContentView];
        if ((self.titleLabel && !self.imageView) || (!self.titleLabel && self.imageView)) {
            UIView *paramView = self.titleLabel ? self.titleLabel : self.imageView;
            
            [constraintsArray addObjectsFromArray:[self setupSingleViewConstrains:paramView]];
        }else if (!self.titleLabel && !self.imageView) {
            
        }else {
            
            UIView *view1 = nil;
            UIView *view2 = nil;
            
            if (_type == ServiceImageLocationTypeTop) {
                view1 = self.imageView;
                view2 = self.titleLabel;
            }else if (_type == ServiceImageLocationTypeBottom) {
                view2 = self.imageView;
                view1 = self.titleLabel;
            }else if (_type == ServiceImageLocationTypeLeading) {
                view1 = self.imageView;
                view2 = self.titleLabel;
            }else if (_type == ServiceImageLocationTypeTrailing) {
                view1 = self.titleLabel;
                view2 = self.imageView;
            }
            
            view1.translatesAutoresizingMaskIntoConstraints = NO;
            view2.translatesAutoresizingMaskIntoConstraints = NO;
            
            NSDictionary *viewsDic = NSDictionaryOfVariableBindings(view1, view2);
            
            switch (_type) {
                case ServiceImageLocationTypeTop:
                case ServiceImageLocationTypeBottom:
                {
                    
                    NSString *V = @"V:|-(>=0)-[view1][view2]-|";
                    NSString *imgH = @"|-(>=0)-[view1]-(>=0)-|";
                    NSString *titH = @"|-(>=0)-[view2]-(>=0)-|";
                    
                    [constraintsArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:V options:0 metrics:nil views:viewsDic]];
                    [constraintsArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:imgH options:0 metrics:nil views:viewsDic]];
                    [constraintsArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:titH options:0 metrics:nil views:viewsDic]];
                    
                    [self addConstraints:constraintsArray];
                    
                    [constraintsArray addObject:[view1 autoAlignAxisToSuperviewAxis:ALAxisVertical]];
                    [constraintsArray addObject:[view2 autoAlignAxisToSuperviewAxis:ALAxisVertical]];
                }
                    break;
                case ServiceImageLocationTypeLeading:
                case ServiceImageLocationTypeTrailing:
                {
                    NSString *imgV = @"V:|-(>=0)-[view1]-(>=0)-|";
                    NSString *titV = @"V:|-(>=0)-[view2]-(>=0)-|";
                    NSString *H = @"|[view1][view2]|";
                    
                    [constraintsArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:imgV options:0 metrics:nil views:viewsDic]];
                    [constraintsArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:titV options:0 metrics:nil views:viewsDic]];
                    [constraintsArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:H options:0 metrics:nil views:viewsDic]];
                    
                    [self addConstraints:constraintsArray];
                    
                    [constraintsArray addObject:[view1 autoAlignAxisToSuperviewAxis:ALAxisHorizontal]];
                    [constraintsArray addObject:[view2 autoAlignAxisToSuperviewAxis:ALAxisHorizontal]];
                }
                    break;
                default:
                    break;
            }
        }
        
        didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (NSArray *)setupSingleViewConstrains:(UIView *)paramView
{
    NSMutableArray *arr = [NSMutableArray new];
    
    [arr addObjectsFromArray:[paramView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero]];
    return arr;
}

- (NSArray *)setupContentView
{
    UIView *contentView = self.contentView;
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObjectsFromArray:[self.contentView autoCenterInSuperview]];
    //    [arr addObjectsFromArray:[paramView autoPinEdgesToSuperviewEdgesRelation:NSLayoutRelationGreaterThanOrEqual]];
    NSString *v = @"V:|-(>=0)-[contentView]-(>=0)-|";
    NSString *h = @"|-(>=0)-[contentView]-(>=0)-|";
    NSDictionary *viewsDic = NSDictionaryOfVariableBindings(contentView);
    [arr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:v options:0 metrics:nil views:viewsDic]];
    [arr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:h options:0 metrics:nil views:viewsDic]];
    return arr;
}
@end