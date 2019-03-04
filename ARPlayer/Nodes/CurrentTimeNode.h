//
//  CurrentTimeNode.h
//  ARPlayer
//
//  Created by Maxim Makhun on 9/30/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;
@import AVFoundation;

NS_ASSUME_NONNULL_BEGIN

@interface CurrentTimeNode : SCNNode

- (void)subscribeForPlayerTimeUpdates:(AVPlayer *)player;

- (void)resetTimeForPlayer:(AVPlayer *)player;

@end

NS_ASSUME_NONNULL_END
