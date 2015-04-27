//
//  UIView+CreateSubAutoLayout.h
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  创建子视图视图的类型
 */
typedef NS_ENUM(NSInteger, CGCreateSubViewType){
    /**
     *  UIView
     */
    CGCreateSubViewTypeView,
    /**
     *  UILabel
     */
    CGCreateSubViewTypeLabel,
    /**
     *  UIButton
     */
    CGCreateSubViewTypeButton,
//    /**
//     *  UIImageView
//     */
//    CGCreateSubViewTypeImageView,
    /**
     *  UITextField
     */
    CGCreateSubViewTypeTextField
};

@interface UIView (CreateSubAutoLayout)

/**
 *  创建一个指定类型的字视图添加到该视图
 *
 *  @param subViewclass 子视图的类型
 *
 *  @return 返回创建好的视图
 */
- (instancetype)createSubAutoLayoutClass:(Class)subViewclass;

/**
 *  创建一个指定类型的字视图添加到该视图
 *
 *  @param viewType 子视图的类型
 *
 *  @return 返回创建好的视图
 */
- (instancetype)createSubAutoLayoutType:(CGCreateSubViewType)viewType;


@end
