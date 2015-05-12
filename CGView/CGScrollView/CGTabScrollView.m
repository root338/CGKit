//
//  CGTabScrollView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGTabScrollView.h"
#import "PureLayout.h"
#import "CGRadioView.h"
#import "UIView+Frame.h"

@interface CGTabScrollView ()
{
    
    BOOL didSetupConstraints;
    
    ///加载的视图总数
    NSInteger _totalCount;
    
//    CGSize totalContentSize;
}

@property (strong, nonatomic) UIScrollView *scrollView;

///加载选择的控件
@property (strong, nonatomic) CGRadioView *contentView;

///加载的视图宽度集合
@property (strong, nonatomic) NSMutableArray *totalViewWidths;
@end

@implementation CGTabScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setDelegate:(id<CGTabScrollViewDataSource>)delegate
{
    if (![_delegate isEqual:delegate]) {
        _delegate = delegate;
        [self reloadAllData];
    }
}

#pragma mark - setup view
- (CGRadioView *)contentView
{
    if (_contentView) {
        return _contentView;
    }
    
    _contentView = [[CGRadioView alloc] init];
    [[self scrollView] addSubview:_contentView];
    return _contentView;
}

- (UIScrollView *)scrollView
{
    if (_scrollView) {
        return _scrollView;
    }
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:_scrollView];
    return _scrollView;
}

#pragma mark - update data
- (NSMutableArray *)totalViewWidths
{
    if (_totalViewWidths) {
        return _totalViewWidths;
    }
    
    _totalViewWidths = [NSMutableArray new];
    return _totalViewWidths;
}

- (void)clearAllData
{
    
    for (id subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    _contentView.selectControl = nil;
    _contentView.selectIndex = 0;
    
    [self.totalViewWidths removeAllObjects];
    
//    totalContentSize = CGSizeZero;
}

- (void)reloadAllData
{
    [self clearAllData];
    
    _totalCount = [self.delegate tabScrollViewNumberView:self];
    
    [self updateContentViewAtStartIndex:0];
}

- (void)reloadIndexs:(NSArray *)indexs
{
    
}

/**
 *  更新contentView视图中的内容
 *
 *  @param index 从哪个视图索引开始更新
 */
- (void)updateContentViewAtStartIndex:(NSInteger)index
{
    //设置后的总宽度
    CGFloat totalWidth;
    //间距
    CGFloat spaceWith = self.itemSpace;
    
    for (NSInteger index = 0; index < _totalCount; index++) {
        
        CGFloat width = self.itemWidth;
        if ([self.delegate respondsToSelector:@selector(tabScrollView:widthForIndex:)]) {
            width = [self.delegate tabScrollView:self widthForIndex:index];
        }
        
        UIView *view = [self.delegate tabScrollView:self numberViewAtIndex:index];
        
        [self.totalViewWidths addObject:@(width)];
        
        CGRect frame = CGRectMake(totalWidth, 0, width, self.height);
        view.frame = frame;
        
        [self.contentView addSubview:view];
        
        totalWidth += width + spaceWith;
    }
    
    [self.contentView setupRadioView];
    self.contentView.frame = CGRectMake(0, 0, totalWidth, self.height);
    self.scrollView.contentSize = self.contentView.size;
}

#pragma mark - update Constraints

- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
        [self.scrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        didSetupConstraints = YES;
    }
    [super updateConstraints];
}

#pragma mark - 点击事件
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    return YES;
}
@end
