//
//  SettingsManager.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/23/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "SettingsManager.h"

NSString * const kNotificationShowPlanes = @"kNotificationShowPlanes";

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

- (BOOL)showPlanes {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"showPlanes"];
}

- (void)setShowPlanes:(BOOL)showPlanes {
    _showPlanes = showPlanes;
    
    [[NSUserDefaults standardUserDefaults] setBool:_showPlanes forKey:@"showPlanes"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationShowPlanes
                                                        object:nil];
}

- (BOOL)vibrateOnTouch {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"vibrateOnTouch"];
}

- (void)setVibrateOnTouch:(BOOL)vibrateOnTouch {
    _vibrateOnTouch = vibrateOnTouch;
    
    [[NSUserDefaults standardUserDefaults] setBool:_vibrateOnTouch forKey:@"vibrateOnTouch"];
}

- (BOOL)animateOnTouch {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"animateOnTouch"];
}

- (void)setAnimateOnTouch:(BOOL)animateOnTouch {
    _animateOnTouch = animateOnTouch;
    
    [[NSUserDefaults standardUserDefaults] setBool:_animateOnTouch forKey:@"animateOnTouch"];
}

- (BOOL)scaleAllowed {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"scaleAllowed"];
}

- (void)setScaleAllowed:(BOOL)scaleAllowed {
    _scaleAllowed = scaleAllowed;
    
    [[NSUserDefaults standardUserDefaults] setBool:_scaleAllowed forKey:@"scaleAllowed"];
}

- (BOOL)rotationAllowed {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"rotationAllowed"];
}

- (void)setRotationAllowed:(BOOL)rotationAllowed {
    _rotationAllowed = rotationAllowed;
    
    [[NSUserDefaults standardUserDefaults] setBool:_rotationAllowed forKey:@"rotationAllowed"];
}

- (BOOL)repositionAllowed {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"repositionAllowed"];
}

- (void)setRepositionAllowed:(BOOL)repositionAllowed {
    _repositionAllowed = repositionAllowed;
    
    [[NSUserDefaults standardUserDefaults] setBool:_repositionAllowed forKey:@"repositionAllowed"];
}

@end
