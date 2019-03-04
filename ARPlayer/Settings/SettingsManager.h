//
//  SettingsManager.h
//  ARPlayer
//
//  Created by Maxim Makhun on 9/23/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import Foundation;

@interface SettingsManager : NSObject

+ (instancetype)instance;

@property (nonatomic) BOOL showPlanes;

@property (nonatomic) BOOL vibrateOnTouch;

@property (nonatomic) BOOL animateOnTouch;

@property (nonatomic) BOOL scaleAllowed;

@property (nonatomic) BOOL rotationAllowed;

@property (nonatomic) BOOL repositionAllowed;

@end
