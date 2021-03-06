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

#define DEBUG 1

#define __KLessThanOrEqual(a, max) \
( (a) > (max) ) ? max : a

#define __KGreaterThanOrEqual(a, min) \
( (a) < (min) ) ? min : a

#define __KDeviceIsLandscape UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

#define __KColorRGBValueJudge(a) __KLessThanOrEqual(a, 255)

#define __KRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define __KRGB(r,g,b) __KRGBA(r,g,b,1)

#define __KRGBA_16(value, a) [UIColor colorWithRed:((value & 0xFF0000) >> 16)/255. green:((value & 0x00FF00) >> 16)/255.0 blue:((value & 0x0000FF) >> 16)/255.0 alpha:(a)]

#define __KRGB_16(value) __KRGBA_16(value, 1)


#ifdef DEBUG

#define NSLOG(format, ...) \
do  {   \
fprintf(stderr, "<%s, %d> %s \n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__); \
(NSLog)((format), ##__VA_ARGS__);   \
fprintf(stderr, "-----------\n");   \
} while(0)

#define _NSLOG NSLOG(nil)
#else

#define NSLOG(format, ...)

#define _NSLOG
#endif

#endif
