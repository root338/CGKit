//
//  UIImageView+CreateAutoLayout.m
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIImageView+CreateAutoLayout.h"

@implementation UIImageView (CreateAutoLayout)

+ (UIImageView *)createImageViewImageName:(NSString *)imageName
{
    return [self createImageViewImageName:imageName contentModel:UIViewContentModeScaleToFill];
}

+ (UIImageView *)createImageViewImageName:(NSString *)imageName contentModel:(UIViewContentMode)contentModel
{
    return [self createImageView_imgName:imageName contentModel:contentModel isCap:NO capInsets:UIEdgeInsetsZero];
}

+ (UIImageView *)createImageViewImageName:(NSString *)imageName capInsets:(UIEdgeInsets)capInset
{
    return [self createImageView_imgName:imageName contentModel:UIViewContentModeScaleToFill isCap:YES capInsets:capInset];
}

/**
 *  创建适配auto layout的图像视图
 *
 *  对图像视图进行详细的设置
 *
 *  @param imgName      本地图片名
 *  @param contentModel 加载图片的方式
 *  @param isCap        是否拉伸图片
 *  @param capInsets    拉伸的值
 *
 *  @return 返回创建好的图像视图
 */
+ (UIImageView *)createImageView_imgName:(NSString *)imgName contentModel:(UIViewContentMode)contentModel isCap:(BOOL)isCap capInsets:(UIEdgeInsets)capInsets
{
    UIImageView *_imageView = [[UIImageView alloc] init];
    
    //使用约束
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //图片加载方式
    _imageView.contentMode = contentModel;
    
    //获取本地图片
    _imageView.image = [_imageView imageName:imgName isCap:isCap capInsets:capInsets];
    
    return _imageView;
}

@end

@implementation UIImageView (SetupLocaleImage)

- (void)setupLocaleImage:(NSString *)imageName
{
    self.image = [self imageName:imageName];
}

- (UIImage *)imageName:(NSString *)imageName
{
    return [self imageName:imageName];
}

- (UIImage *)imageName:(NSString *)imageName isCap:(BOOL)isCap capInsets:(UIEdgeInsets)edgeInsets
{
    UIImage *image = nil;
    if (imageName) {
        image = [UIImage imageNamed:imageName];
    }
    
    
    if (isCap) {
        image = [image resizableImageWithCapInsets:edgeInsets];
    }
    
    return image;
}

@end