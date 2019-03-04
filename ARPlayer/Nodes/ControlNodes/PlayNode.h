//
//  PlayNode.h
//  ARPlayer
//
//  Created by Maxim Makhun on 9/30/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;

#import "ControlNode.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PlayerState) {
    Playing,
    Paused,
};

/*!
 @class PlayNode
 @abstract Node by pressing which playback can be toggled - either paused on moved to playing state.
 */
@interface PlayNode : ControlNode

/*!
 @property state
 @abstract Current playback state - can be either paused or playing.
 */
@property (nonatomic) PlayerState state;

@end

NS_ASSUME_NONNULL_END
