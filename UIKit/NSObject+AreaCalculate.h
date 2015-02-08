//
//  AreaCalculate.h
//  Corp
//
//  Created by apple on 15/2/8.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import <UIKit/UIKit.h>

//计算指定区域的中心点
//#define _CGRectCenter(a) CGPointMake((a).origin.x + (a).size.width / 2, (a).origin.y + (a).size.height / 2)

/**
 *  对区域的计算
 */
@interface NSObject (AreaCalculate)

/**
 *  计算指定区域中符合条件的最大区域
 *
 *  @param maxRect     指定的区域
 *  @param scale       宽：高的比例因数
 *
 *  @return 返回最大的符合条件的区域
 */
- (CGRect)availableRect_maxRect:(CGRect)maxRect scale:(CGFloat)scale;

/**
 *  计算指定区域中符合条件的最大区域
 *
 *  @param maxRect     指定的区域
 *  @param scale       宽：高的比例因数
 *  @param contentMode 内部最大视图在指定区域的位置（暂没有实现）
 *
 *  @return 返回最大的符合条件的区域
 */
- (CGRect)availableRect_maxRect:(CGRect)maxRect scale:(CGFloat)scale contentMode:(NSUInteger)contentMode;

/**
 *  自动设置符合条件的区域
 *
 *  @warning:设置的并非最大区域，将设置不超过currentRect区域并符合maxRect区域的区域
 *
 *  @param maxRect 指定的区域
 *  @param scale   宽：高的比例因数
 *  @param currentRect 当前已经设置的选择区域
 *
 *  @return 返回自动设置并符合条件的区域
 */
- (CGRect)automaticSetupAvailableRect_maxRect:(CGRect)maxRect scale:(CGFloat)scale currentRect:(CGRect)currentRect;
@end

/**
 *  对区域比较的扩展
 */
@interface NSObject (AreaCompare)

/**
 *  对CGSize的比较，当rect1 比 rect2 中的size区域大时返回YES
 *
 *  @param rect1 比较的区域1
 *  @param rect2 比较的区域2
 *
 *  @return 返回区域1是否比区域2大
 */
BOOL _CGRectForSizeGreaterThan(CGRect rect1, CGRect rect2);

/**
 *  对CGSize的比较，当size1 比 size2 的大时返回YES
 *
 *  @param size1 比较的大小1
 *  @param size2 比较的大小2
 *
 *  @return 返回大小1是否比大小2大
 */
BOOL _CGSizeGreaterThan(CGSize size1, CGSize size2);

/**
 *  计算指定区域的中心点
 *
 *  @param rect 指定的区域
 *
 *  @return 返回指定区域的中心点
 */
CGPoint _CGRectCenter(CGRect rect);
@end