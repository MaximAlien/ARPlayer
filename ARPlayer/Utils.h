//
//  Utils.h
//  ARPlayer
//
//  Created by Maxim Makhun on 9/24/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import Foundation;

extern NSString * const kMediaPlayerNode;
extern NSString * const kTVNode;
extern NSString * const kVideoRendererNode;
extern NSString * const kPlayNode;
extern NSString * const kStopNode;
extern NSString * const kNextTrackNode;
extern NSString * const kPreviousTrackNode;

@interface Utils : NSObject

+ (void)handleTouch:(SCNNode *)node;

+ (SCNVector3)getBoundingBox:(SCNNode *)node;

+ (NSArray<NSURL *> *)playlist;

@end
