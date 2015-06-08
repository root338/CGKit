//
//  CGRadioView.h
//  iSpa
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGRadioViewDelegate.h"

@class CGRadioView;

/**
 单选视图
 */
@interface CGRadioView : UIView

@property (weak, nonatomic) id<CGRadioViewDelegate> delegate;

/**
 选择的控件
 */
@property (strong, nonatomic) UIControl* selectControl;

/**
 选择的控件索引，即control的tag值
 */
@property (assign, nonatomic) NSInteger selectIndex;

///**
// *  选择控件的位置
// */
//@property (strong, nonatomic) NSIndexPath *selectIndexPath;

/**
 选择回调
 */
@property (copy, nonatomic) void(^didSelectedCallback)(void);

/**
 *  设置单选视图，在添加完控件后更新视图信息
 */
- (void)setupRadioView;

/**
 *  设置默认选择项
 *
 *  @param selected      所选的索引
 */
- (void)initializationSelectedIndex:(NSInteger)selected;

/**
 *  根据索引返回选择控件的对象
 *
 *  @param paramIndex 索引
 *
 *  @return 对应选择视图
 */
- (UIControl *)controlAtIndex:(NSInteger)paramIndex;

/**
 *  根据相对于单选视图的坐标获取对应选择控件
 *
 *  @param point 相对于单选视图的坐标
 *
 *  @return 对应选择视图
 */
- (UIControl *)controlAtPoint:(CGPoint)point;

/**
 *  根据传入选择控件获得对应索引
 *
 *  @param paramControl 选择控件
 *
 *  @return 对应索引
 */
- (NSInteger)indexAtControl:(UIControl *)paramControl;
@end
