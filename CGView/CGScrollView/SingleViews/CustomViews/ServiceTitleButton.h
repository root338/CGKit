//
//  ServiceTitleButton.h
//  iSpa
//
//  Created by 345 on 15/5/29.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import "CGBaseControl.h"
#import "PureLayoutDefines.h"

typedef NS_ENUM(NSInteger, ServiceImageLocationType) {
    
    ServiceImageLocationTypeLeading,
    ServiceImageLocationTypeTop,
    ServiceImageLocationTypeTrailing,
    ServiceImageLocationTypeBottom,
};

@interface ServiceTitleButton : CGBaseControl

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSString *title;

@property (assign, nonatomic) ServiceImageLocationType type;

@property (assign, nonatomic) BOOL isRorationAngle;
@end