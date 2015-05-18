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

@interface CGCycleScrollView ()<UIScrollViewDelegate>
{
    ///当前总的加载数
    NSInteger _totalViews;
    
    ///当前显示视图的索引
    NSInteger _currentLoadIndex;
    
    ///标识约束是否设置完成
    BOOL didSetupConstraints;
}

@property (nonatomic, readonly) NSInteger currentLoadViewsNumber;

@property (nonatomic, strong) CGScrollView *cycleScrollView;

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
    _currentLoadIndex = 0;
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
    NSInteger currentViewIndex  = _currentLoadIndex;
    NSInteger nextViewIndex     = 0;
    NSInteger previousViewIndex = 0;
        
    nextViewIndex = [self calculatePageValue:currentViewIndex + 1];
    currentViewIndex = _currentLoadIndex;
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

///刷新视图，是否向下翻
- (void)reloadAllViewForIsNextPage:(BOOL)isNextPage
{
    _currentLoadIndex = [self calculatePageValue:_currentLoadIndex + (isNextPage ? 1 : -1)];
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
}
@end
