//
//  SettingsManager.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/23/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "SettingsManager.h"

@interface SettingsManager ()

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

@end
