//
//  Utils.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/24/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;
@import AudioToolbox;

// Utils
#import "Utils.h"
#import "SettingsManager.h"

@implementation Utils

+ (void)handleTouch:(SCNNode *)node {
    if ([SettingsManager instance].vibrateOnTouch) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    if ([SettingsManager instance].animateOnTouch) {
        SCNAction *moveDown = [SCNAction moveBy:SCNVector3Make(0.0f,
                                                               -0.03f,
                                                               0.0f)
                                       duration:0.2f];
        moveDown.timingMode = SCNActionTimingModeEaseInEaseOut;
        SCNAction *moveUp = [SCNAction moveBy:SCNVector3Make(0.0f,
                                                             0.03f,
                                                             0.0f)
                                     duration:0.2f];
        moveUp.timingMode = SCNActionTimingModeEaseInEaseOut;
        SCNAction *moveAction = [SCNAction repeatAction:[SCNAction sequence:@[moveDown, moveUp]]
                                                  count:1];
        [node runAction:moveAction];
    }
}

+ (NSArray<NSURL *> *)playlist {
    return [NSArray arrayWithObjects:
            [NSURL URLWithString:@"http://devstreaming.apple.com/videos/wwdc/2014/609xxkxq1v95fju/609/609_sd_whats_new_in_scenekit.mov"],
            [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sample_video_iTunes" ofType:@"mov"]], nil];
}

@end
