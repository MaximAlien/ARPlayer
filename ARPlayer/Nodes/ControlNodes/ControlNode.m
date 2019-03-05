//
//  ControlNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

#import "ControlNode.h"

// Utils
#import "SettingsManager.h"

// Categories
#import "UIImpactFeedbackGenerator+Helpers.h"

@interface ControlNode ()

@end

@implementation ControlNode

- (void)animate {
    if ([SettingsManager instance].animateOnTouch) {
        SCNAction *moveDown = [SCNAction moveBy:SCNVector3Make(0.0f, -0.03f, 0.0f)
                                       duration:0.2f];
        moveDown.timingMode = SCNActionTimingModeEaseInEaseOut;
        SCNAction *moveUp = [SCNAction moveBy:SCNVector3Make(0.0f, 0.03f, 0.0f)
                                     duration:0.2f];
        moveUp.timingMode = SCNActionTimingModeEaseInEaseOut;
        SCNAction *moveAction = [SCNAction repeatAction:[SCNAction sequence:@[moveDown, moveUp]]
                                                  count:1];
        [self runAction:moveAction];
    }
}

- (void)vibrate {
    if ([SettingsManager instance].vibrateOnTouch) {
        [UIImpactFeedbackGenerator heavyImpactOccurred];
    }
}

@end
