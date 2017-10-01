//
//  TVNode.h
//  ARPlayer
//
//  Created by Maxim Makhun on 10/1/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;
@import AVFoundation;

@interface TVNode : SCNNode

@property(nonatomic, strong, readonly) AVPlayer *player;

@end
