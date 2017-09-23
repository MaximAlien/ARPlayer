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

@property (nonatomic) BOOL shouldShowPlanes;

@end
