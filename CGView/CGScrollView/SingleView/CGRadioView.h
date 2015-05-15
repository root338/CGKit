//
//  CGRadioView.h
//  iSpa
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGRadioView;
@protocol CGRadioViewDelegate <NSObject>

@optional
/**
 *  选择控件之后的回调
 *
 *  @param radioView       操作的主视图
 *  @param selectedControl 选择的控件
 */
- (void)radioView:(CGRadioView *)radioView selectedControl:(UIControl *)selectedControl;

/**
 *  返回所选择的控件是否应该被选
 *
 *  @param radioView       单选视图
 *  @param selectedControl 将要选择的控件
 *
 *  @return 返回一个BOOL值，表示是否应该被选
 */
- (BOOL)radioView:(CGRadioView *)radioView shouldSelectedControl:(UIControl *)selectedControl;

@end

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
 *  设置单选视图，在添加完控件后更新视图信息
 */
- (void)setupRadioView;

/**
 *  设置默认选择项
 *
 *  @param selected      所选的索引
 */
- (void)initializationSelectedIndex:(NSInteger)selected;
@end
