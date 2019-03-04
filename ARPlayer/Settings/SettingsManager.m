//
//  SettingsManager.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/23/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "SettingsManager.h"

// Utils
#import "Constants.h"

@interface SettingsManager () {
    BOOL _showPlanes;
    BOOL _vibrateOnTouch;
    BOOL _animateOnTouch;
    BOOL _scaleAllowed;
    BOOL _rotationAllowed;
    BOOL _repositionAllowed;
}

@end

@implementation SettingsManager

+ (instancetype)instance {
    static SettingsManager *sharedManager;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
    });

    return sharedManager;
}

#pragma mark - Read/write to settings methods

- (BOOL)showPlanes {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kShowPlanesSettingsKey];
}

- (void)setShowPlanes:(BOOL)showPlanes {
    _showPlanes = showPlanes;
    
    [[NSUserDefaults standardUserDefaults] setBool:_showPlanes forKey:kShowPlanesSettingsKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationShowPlanes
                                                        object:nil];
}

- (BOOL)vibrateOnTouch {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVibrateOnTouchKey];
}

- (void)setVibrateOnTouch:(BOOL)vibrateOnTouch {
    _vibrateOnTouch = vibrateOnTouch;
    
    [[NSUserDefaults standardUserDefaults] setBool:_vibrateOnTouch forKey:kVibrateOnTouchKey];
}

- (BOOL)animateOnTouch {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kAnimateOnTouchKey];
}

- (void)setAnimateOnTouch:(BOOL)animateOnTouch {
    _animateOnTouch = animateOnTouch;
    
    [[NSUserDefaults standardUserDefaults] setBool:_animateOnTouch forKey:kAnimateOnTouchKey];
}

- (BOOL)scaleAllowed {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kScaleAllowedKey];
}

- (void)setScaleAllowed:(BOOL)scaleAllowed {
    _scaleAllowed = scaleAllowed;
    
    [[NSUserDefaults standardUserDefaults] setBool:_scaleAllowed forKey:kScaleAllowedKey];
}

- (BOOL)rotationAllowed {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kRotationAllowedKey];
}

- (void)setRotationAllowed:(BOOL)rotationAllowed {
    _rotationAllowed = rotationAllowed;
    
    [[NSUserDefaults standardUserDefaults] setBool:_rotationAllowed forKey:kRotationAllowedKey];
}

- (BOOL)repositionAllowed {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kRepositionAllowedKey];
}

- (void)setRepositionAllowed:(BOOL)repositionAllowed {
    _repositionAllowed = repositionAllowed;
    
    [[NSUserDefaults standardUserDefaults] setBool:_repositionAllowed forKey:kRepositionAllowedKey];
}

@end
