//
//  UIView+AddLayoutConstraint.h
//  soho
//
//  Created by 345 on 14/11/18.
//  Copyright (c) 2014年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 调式约束的私用API
 
/// 查看当前视图约束的布局
@interface UIWindow (AUtoLayoutDebug)

+ (UIWindow *)keyWindow;
- (NSString *)_autolayoutTrace;

@end
 */

typedef NS_ENUM(NSInteger, KGCLayoutAttribute){
    kGCLayoutAttributeLeading       = 1 << 0,
    kGCLayoutAttributeTrailing      = 1 << 1,
    kGCLayoutAttributeTop           = 1 << 2,
    kGCLayoutAttributeBottom        = 1 << 3,
    kGCLayoutAttributeWidth         = 1 << 4,
    kGCLayoutAttributeHeight        = 1 << 5,
    kGCLayoutAttributeCenterX       = 1 << 6,
    kGCLayoutAttributeCenterY       = 1 << 7,
    
    KGCLayoutAttributeCenter    = (kGCLayoutAttributeCenterX | kGCLayoutAttributeCenterY),
    kGCLayoutAttributeAllEdge   = (kGCLayoutAttributeLeading | kGCLayoutAttributeTrailing | kGCLayoutAttributeTop | kGCLayoutAttributeBottom),
    kGCLayoutAttributeSize      = (kGCLayoutAttributeWidth | kGCLayoutAttributeHeight),
    
    kGCLayoutAttributeAll       = (kGCLayoutAttributeAllEdge | kGCLayoutAttributeSize)
};

 NSString * const GCLayoutAttributeLeading;
 NSString * const GCLayoutAttributeTrailing;
 NSString * const GCLayoutAttributeTop;
 NSString * const GCLayoutAttributeBottom;
 NSString * const GCLayoutAttributeWidth;
 NSString * const GCLayoutAttributeHeight;
 NSString * const GCLayoutAttributeCenterX;
 NSString * const GCLayoutAttributeCenterY;

/**
 添加约束
 */
@interface UIView (AddLayoutConstraint)

/**
 为视图添加约束
 @param atts 添加哪些约束
 @param size 当设置宽高约束时的参数
 @param noAdd 当宽或高的值小于等于零时是否添加宽高
 @return 返回设置的所有约束
 */
- (NSArray *)addConstraintWithAttribute:(KGCLayoutAttribute)atts size:(CGSize)size zeroIsNoAddAttribute:(BOOL)noAdd;

/**
 为视图添加约束
 @param atts 添加哪些约束
 @param size 当设置宽高约束时的参数
 @param noAdd 当宽或高的值小于等于零时是否添加宽高
 @return 返回设置的所有约束组成的字典
 */
- (NSDictionary *)addDicConstraintWithAttribute:(KGCLayoutAttribute)atts size:(CGSize)size zeroIsNoAddAttribute:(BOOL)noAdd;

/**
 为视图添加约束 默认当宽高设置为零时不添加设置宽高约束
 @param atts 添加哪些约束
 @param size 当设置宽高约束时的参数
 @return 返回设置的所有约束
 */
- (NSArray *)addConstraintWithAttribute:(KGCLayoutAttribute)atts size:(CGSize)size;

/**
 为视图添加约束 默认当宽高设置为零时不添加设置宽高约束
 @param atts 添加哪些约束
 @param size 当设置宽高约束时的参数
 @return 返回设置的所有约束组成的字典
 */
- (NSDictionary *)addDicConstraintWithAttribute:(KGCLayoutAttribute)atts size:(CGSize)size;

/**
 为视图添加约束，忽略宽高的设置
 @param atts 添加哪些约束
 @param size 当设置宽高约束时的参数
 @return 返回设置的所有约束
 */
- (NSArray *)addConstraintWithAttribute:(KGCLayoutAttribute)atts;

/**
 为视图添加约束，忽略宽高的设置
 @param atts 添加哪些约束
 @param size 当设置宽高约束时的参数
 @return 返回设置的所有约束组成的字典
 */
- (NSDictionary *)addDicConstraintWithAttribute:(KGCLayoutAttribute)atts;

/**
 添加一个约束并加到父视图上
 */
- (NSLayoutConstraint *)addConstraintWithEqualToSuperattribute:(NSLayoutAttribute)att1;
/**
 添加一个约束并加到父视图
 参数同constraintWithItem:attribute:relatedBy:toItem:attribute:multiplier:constant:方法
 */
- (NSLayoutConstraint *)addConstraintWithAttribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 atttribute:(NSLayoutAttribute)att2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;

/**
 添加一组约束并加到父视图
 参数同constraintsWithVisualFormat:options:metrics:views:方法
 */
- (NSArray *)addConstraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 添加一组约束并加到父视图
 */
- (NSArray *)addConstraintsWithVisualFormat:(NSString *)format views:(NSDictionary *)views;

/**
 添加一组约束
 注意：添加的视图必须公用一个父视图
 @param formats 其中的对象为 约束格式化对象  类型为NSString
 */
- (NSArray *)addConstraintsWithVisualFormats:(NSArray *)formats views:(NSDictionary *)views;

/**
 设置视图的宽度
 */
- (NSLayoutConstraint *)addConstraintWithWidth:(CGFloat)width;

/**
 设置视图的高度
 */
- (NSLayoutConstraint *)addConstraintWithHeight:(CGFloat)height;

/**
 设置视图的大小
 */
- (NSArray *)setupViewSize:(CGSize)size;

@end
