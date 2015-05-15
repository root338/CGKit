//
//  CGTabScrollView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGSingleScrollView.h"

#import "PureLayout.h"
#import "CGRadioBaseView.h"
#import "UIView+Frame.h"

@interface CGSingleScrollView ()
{
    
    BOOL didSetupConstraints;
    
    ///加载的视图总数
    NSInteger _totalCount;
    
//    CGSize totalContentSize;
}

@property (strong, nonatomic) UIScrollView *scrollView;

///加载选择的控件
@property (strong, nonatomic) CGRadioBaseView *contentView;

///加载的视图宽度集合
@property (strong, nonatomic) NSMutableArray *totalViewWidths;
@end

@implementation CGSingleScrollView

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

#pragma mark - setup view
- (void)setItemSpace:(CGFloat)itemSpace
{
    _itemSpace = itemSpace;
    self.contentView.itemSpace = itemSpace;
}

- (void)setItemWidth:(CGFloat)itemWidth
{
    _itemWidth = itemWidth;
    self.contentView.itemWidth = itemWidth;
}

- (CGRadioBaseView *)contentView
{
    if (_contentView) {
        return _contentView;
    }
    
    _contentView = [[CGRadioBaseView alloc] init];
    _contentView.itemHeight = self.height;
    [self setupRadioCallback];
    [[self scrollView] addSubview:_contentView];
    return _contentView;
}

- (CGRadioBaseView *)singleView
{
    return self.contentView;
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

- (void)setupRadioCallback
{
    __weak CGSingleScrollView *weakSelf = self;
    _contentView.didSetupViewFinish = ^(void) {
        
        CGSingleScrollView *strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf updateRadioView];
        }
    };
    
    _contentView.didSelectedCallback = ^(void) {
        
        CGSingleScrollView *strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf updateScrollLocation];
        }
    };
}

- (void)updateScrollLocation
{
    //获取当前选中按钮在滑动视图的坐标
    CGPoint startPointToScrollView = [self.contentView convertPoint:self.contentView.selectControl.origin toView:self.scrollView];
    
    //获取当前选中按钮在主视图的坐标
    CGPoint startPointToContentView = [self.contentView convertPoint:self.contentView.selectControl.origin toView:self];
    
    //
//    CGPoint nextEndPoint = CGPointZero;
//    CGPoint previousEndPoint = CGPointZero;
//    
//    //获取选中按钮下一个视图在滑动视图的坐标
//    UIView *nextView = [self.contentView selectedNextView];
//    if (nextView) {
//        CGPoint nextPointToScrollView = [self.contentView convertPoint:nextView.origin toView:self.scrollView];
//        CGPoint nextPointToContentView = [self.contentView convertPoint:nextView.origin toView:self];
//        
//        nextEndPoint = CGPointMake(nextPointToScrollView.x + self.itemSpace + nextView.width, nextView.y);
//    }
//    
//    //获取选中按钮上一个视图在滑动视图的坐标
//    UIView *previousView = [self.contentView selectedPreviousView];
//    if (previousView) {
//        CGPoint previousPointToScrollView = [self.contentView convertPoint:previousView.origin toView:self.scrollView];
//        CGPoint previousPointToContentView = [self.contentView convertPoint:previousView.origin toView:self];
//        
//        previousEndPoint = CGPointMake(previousPointToScrollView.x + self.itemSpace + previousView.width, previousView.y);
//    }
    
    startPointToScrollView.x -= startPointToContentView.x;
    
    CGPoint endPoint = CGPointMake(startPointToScrollView.x + self.itemSpace + self.contentView.selectControl.width, startPointToScrollView.y);
    
    if (startPointToScrollView.x + self.scrollView.width > self.scrollView.contentSize.width) {
        return;
    }
    
    if (endPoint.x + self.scrollView.width > self.scrollView.contentSize.width) {
        endPoint = CGPointMake(self.scrollView.contentSize.width - self.scrollView.width, endPoint.y);
    }
//    CGPoint currentContentOffset = self.scrollView.contentOffset;
//    CGPoint centerPoint = CGPointMake(currentContentOffset.x + self.scrollView.width / 2, self.scrollView.height / 2);
//    
    [self.scrollView setContentOffset:endPoint animated:YES];
}

/**
 *  更新contentView视图中的内容
 *
 */
- (void)updateRadioView
{
    self.contentView.frame = CGRectMake(0, 0, self.contentView.totalWidths, self.height);
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
@end
