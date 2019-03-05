//
//  ControlNode.h
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import SceneKit;

#import "InteractableProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 @class ControlNode
 @abstract Node which is used as a base class for all nodes which can control video playback.
 */
@interface ControlNode : SCNNode <InteractableProtocol>

@end

NS_ASSUME_NONNULL_END
