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

NSString * const kMediaPlayerNode = @"media_player_node";
NSString * const kTVNode = @"tv_node";
NSString * const kVideoRendererNode = @"video_renderer_node";
NSString * const kPlayNode = @"play_node";
NSString * const kStopNode = @"stop_node";
NSString * const kNextTrackNode = @"next_track_node";
NSString * const kPreviousTrackNode = @"previous_track_node";

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

+ (SCNVector3)getBoundingBox:(SCNNode *)node {
    SCNVector3 min = SCNVector3Zero;
    SCNVector3 max = SCNVector3Zero;
    [node getBoundingBoxMin:&min max:&max];
    
    CGFloat width = max.x - min.x;
    CGFloat height = max.y - min.y;
    CGFloat length = max.z - min.z;
    
    return SCNVector3Make(width, height, length);
}

+ (NSArray<NSURL *> *)playlist {
    return [NSArray arrayWithObjects:
            [NSURL URLWithString:@"http://devstreaming.apple.com/videos/wwdc/2014/609xxkxq1v95fju/609/609_sd_whats_new_in_scenekit.mov"],
            [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sample_video_iTunes" ofType:@"mov"]], nil];
}

@end
