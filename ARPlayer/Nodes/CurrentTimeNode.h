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

/*!
 @class CurrentTimeNode
 @abstract Node which is placed on top of vide surface to show current playback time.
 */
@interface CurrentTimeNode : SCNNode

/*!
 @method subscribeForPlayerTimeUpdates:
 @abstract Subscribe to time playback updates of AVPlayer instance.
 */
- (void)subscribeForPlayerTimeUpdates:(AVPlayer *)player;

/*!
 @method resetTimeForPlayer:
 @abstract Reset current time information in CurrentTimeNode.
 */
- (void)resetTimeForPlayer:(AVPlayer *)player;

@end

NS_ASSUME_NONNULL_END
