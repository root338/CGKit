//
//  UIViewCommonDefine.h
//  PDPracticeDemo
//
//  Created by apple on 15/4/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#ifndef PDPracticeDemo_UIViewCommonDefine_h
#define PDPracticeDemo_UIViewCommonDefine_h

@import UIKit;

#define __KLessThanOrEqual(a, max) \
( (a) > (max) ) ? max : a

#define __KGreaterThanOrEqual(a, min) \
( (a) < (min) ) ? min : a

#define __KDeviceIsLandscape UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

#define __KColorRGBValueJudge(a) __KLessThanOrEqual(a, 255)

#define __KRGBA(r,g,b,a) [UIColor colorWithRed:(__KColorRGBValueJudge(r))/255.0 green:(__KColorRGBValueJudge(g))/255.0 blue:(__KColorRGBValueJudge(b))/255.0 alpha:(a)]

#define __KRGB(r,g,b) __KRGBA(r,g,b,1)

#endif
