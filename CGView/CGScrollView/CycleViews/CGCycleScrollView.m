//
//  CGCycleScrollView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGCycleScrollView.h"
#import "PureLayout.h"
#import "CGCycleContentView.h"
#import "UIView+Frame.h"
#import "CGScrollView.h"
#import "UIViewCommonDefine.h"
#import "NSTimer+TimerSetupState.h"

@interface CGCycleScrollView ()<UIScrollViewDelegate>
{
    ///当前总的加载数
    NSInteger _totalViews;
    
    ///标识约束是否设置完成
    BOOL didSetupConstraints;
    
    ///计时器
    NSTimer *_autoScrollTimer;
}

@property (nonatomic, readonly) NSInteger currentLoadViewsNumber;

@property (nonatomic, strong) CGScrollView *cycleScrollView;

///当前显示视图的索引
@property (nonatomic, assign) NSInteger currentLoadIndex;
@end

@implementation CGCycleScrollView

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self initializationVariable];
    }
    return self;
}

///初始化相关参数
- (void)initializationVariable
{
//    self.isCycle = YES;
    self.isAutoScrollView = NO;
    self.currentLoadIndex = 0;
    self.cycleScrollView.showsVerticalScrollIndicator = NO;
    self.cycleScrollView.showsHorizontalScrollIndicator = NO;
    self.cycleScrollView.scrollsToTop = NO;
    self.cycleScrollView.pagingEnabled = YES;
    self.cycleScrollView.delegate = self;
}

#pragma mark - 对相关属性进行赋值
- (void)setDataSource:(id<CGCycleScrollViewDataSource>)dataSource
{
    if (![_dataSource isEqual:dataSource]) {
        _dataSource = dataSource;
        [self performSelector:@selector(reloadAllView) withObject:nil afterDelay:0];
    }
}

- (CGScrollView *)cycleScrollView
{
    if (_cycleScrollView) {
        return _cycleScrollView;
    }
    
    _cycleScrollView = [[CGScrollView alloc] init];
    [self addSubview:_cycleScrollView];
    return _cycleScrollView;
}

- (NSInteger)currentLoadViewsNumber
{
    return 3;
}

- (void)setIsAutoScrollView:(BOOL)isAutoScrollView
{
    if (self.delayTimeInterval == 0) {
        self.delayTimeInterval = 2;
    }
    
    if (_isAutoScrollView != isAutoScrollView) {
        
        _isAutoScrollView = isAutoScrollView;
        if (_isAutoScrollView && _autoScrollTimer == nil) {
            [self performSelector:@selector(startTimer) withObject:nil afterDelay:self.delayTimeInterval];
        }
    }
}

- (void)setDelayTimeInterval:(NSTimeInterval)delayTimeInterval
{
    if (_delayTimeInterval != delayTimeInterval) {
        _delayTimeInterval = delayTimeInterval;
        if (self.isAutoScrollView) {
            //当自动滑动打开时，每隔多少秒数值改变时，更新计时器
            [self updateTimer];
        }
    }
}

#pragma mark - 计时器操作
- (NSTimer *)autoScrollTimer
{
    
    if (_autoScrollTimer) {
        return _autoScrollTimer;
    }
    _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.delayTimeInterval target:self selector:@selector(reloadNextPageView:) userInfo:nil repeats:YES];
    
    return _autoScrollTimer;
}

- (void)startTimer
{
    [[self autoScrollTimer] startTimer];
}

- (void)stopTimer
{
    if (_autoScrollTimer) {
        [_autoScrollTimer stopTimer];
        _autoScrollTimer = nil;
    }
}

- (void)pauseTimer
{
    [[self autoScrollTimer] pauseTimer];
}

- (void)startTimerAfterDelayTimeInterval
{
    [[self autoScrollTimer] startTimerAfterTimeInterval:self.delayTimeInterval];
}

- (void)updateTimer
{
    [self stopTimer];
    [self startTimer];
}

- (void)reloadNextPageView:(NSTimer *)timer
{
    [self.cycleScrollView setContentOffset:CGPointMake(self.width * 2, self.cycleScrollView.contentOffset.y)
                                  animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSInteger)calculatePageValue:(NSInteger)paramPage
{
    if (paramPage >= _totalViews) {
        paramPage = 0;
    }
    if (paramPage < 0) {
        paramPage = _totalViews - 1;
    }
    return paramPage;
}

///设置当前需要加载视图的索引列表
- (NSArray *)setupCurrentLoadViewIndex
{
    NSInteger currentViewIndex  = self.currentLoadIndex;
    NSInteger nextViewIndex     = 0;
    NSInteger previousViewIndex = 0;
        
    nextViewIndex = [self calculatePageValue:currentViewIndex + 1];
    currentViewIndex = self.currentLoadIndex;
    previousViewIndex = [self calculatePageValue:currentViewIndex - 1];
    
    return @[@(previousViewIndex), @(currentViewIndex), @(nextViewIndex)];
}

- (void)reloadAllView
{
    [self removeAllSubviews];
    
    _totalViews = [self.dataSource numberInCycleScrollView:self];
    
    //滑动区域
    self.cycleScrollView.contentSize = CGSizeMake(self.width * self.currentLoadViewsNumber, 0);
    
    //滑动视图加载内容
    NSArray *indexs = [self setupCurrentLoadViewIndex];
    
    for (NSInteger i = 0; i < indexs.count; i++) {
        
        NSInteger index = [indexs[i] integerValue];
        UIView *subview = [self.dataSource cycleScrollView:self viewForNumberAtIndex:index];
        
        CGRect frame = CGRectMake(i * self.width, 0, self.width, self.height);
        
        CGCycleContentView *contentView = [[CGCycleContentView alloc] initWithFrame:frame];
        
        contentView.detailContentView = subview;
        contentView.tag = index;
        
        [self.cycleScrollView addSubview:contentView];
    }
    
    [self.cycleScrollView setContentOffset:CGPointMake(self.cycleScrollView.width, self.cycleScrollView.contentOffset.y)];
}

- (void)removeAllSubviews
{
    for (UIView *view in self.cycleScrollView.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark - 更新视图布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cycleScrollView.frame = self.bounds;
}

#pragma mark -
- (BOOL)judgeIsAllReload:(NSInteger)paramIndex isNextPage:(BOOL)isNextPage
{
    if (!self.isCycle) {
        
        if ((isNextPage && (paramIndex + self.currentLoadViewsNumber == _totalViews)) || (!isNextPage && paramIndex == 0)) {
            
            return NO;
        }
    }
    return YES;
}

- (BOOL)judgeIsCurrentLoadIndexReloadIsNextPage:(BOOL)isNextPage
{
    return [self judgeIsAllReload:self.currentLoadIndex isNextPage:isNextPage];
}

///刷新视图，是否向下翻
- (void)reloadAllViewForIsNextPage:(BOOL)isNextPage
{
    self.currentLoadIndex = [self calculatePageValue:self.currentLoadIndex + (isNextPage ? 1 : -1)];
    [self reloadAllView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //向上翻一张
    if (offsetX <= 0) {
        
        [self reloadAllViewForIsNextPage:NO];
    }
    
    //向下翻一张
    if (offsetX >= self.width * 2) {
        
        [self reloadAllViewForIsNextPage:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.cycleScrollView setContentOffset:CGPointMake(self.cycleScrollView.width, self.cycleScrollView.contentOffset.y) animated:YES];
    [self startTimerAfterDelayTimeInterval];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self pauseTimer];
}

- (void)dealloc
{
    
}
@end
