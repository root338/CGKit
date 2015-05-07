//
//  UIViewDefine.h
//  PDPracticeDemo
//
//  Created by apple on 15/4/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#ifndef PDPracticeDemo_UIViewDefine_h
#define PDPracticeDemo_UIViewDefine_h

#import <UIKit/UIKit.h>

#define __KLessThanOrEqual(a, max) \
if ( (a) > (max) ) {\
    a = max;\
}

#define __KGreaterThanOrEqual(a, min) \
if ( (a) < (min) ) {\
    a = min;\
}

#define __KDeviceIsLandscape UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

#define __KColorRGBValueJudge(a) __KLessThanOrEqual(a, 255)
#define __KRGB(r,g,b) [UIColor colorWithRed:__KColorRGBValueJudge(r)/255.0 green:__KColorRGBValueJudge(g)/255.0 blue:__KColorRGBValueJudge(b)/255.0]

#endif
