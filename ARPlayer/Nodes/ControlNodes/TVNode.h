//
//  TVNode.h
//  ARPlayer
//
//  Created by Maxim Makhun on 10/1/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;
@import AVFoundation;

#import "ControlNode.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 @class TVNode
 @abstract TVNode - node which contains media playback surface and TV node.
 */
@interface TVNode : ControlNode

/*!
 @property player
 @abstract AVPlayer instance, using which it's possible to control playback.
 */
@property (nonatomic, strong, nullable) AVPlayer *player;

@end

NS_ASSUME_NONNULL_END
