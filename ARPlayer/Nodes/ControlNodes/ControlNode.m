//
//  ControlNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

#import "ControlNode.h"

// Protocols
#import "AnimatableProtocol.h"

// Utils
#import "SettingsManager.h"

// Categories
#import "UIImpactFeedbackGenerator+Helpers.h"

@interface ControlNode () <AnimatableProtocol>

@end

@implementation ControlNode

- (void)animate {
    if ([SettingsManager instance].vibrateOnTouch) {
        [UIImpactFeedbackGenerator heavyImpactOccurred];
    }

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

@end
