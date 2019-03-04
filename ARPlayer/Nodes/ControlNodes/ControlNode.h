//
//  ControlNode.h
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import SceneKit;

NS_ASSUME_NONNULL_BEGIN

/*!
 @class ControlNode
 @abstract Node which is used as a base class for all nodes which can control video playback.
 */
@interface ControlNode : SCNNode

/*!
 @method animate
 @abstract Animate control media player action depending on settings.
 */
- (void)animate;

@end

NS_ASSUME_NONNULL_END
