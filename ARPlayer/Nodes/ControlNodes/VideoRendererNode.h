//
//  VideoRendererNode.h
//  ARPlayer
//
//  Created by Maxim Makhun on 05/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import SceneKit;

#import "ControlNode.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 @class VideoRendererNode
 @abstract VideoRendererNode - node on frontal surface of which playback is done.
 */
@interface VideoRendererNode : ControlNode

/*!
 @method initWithParentNode:
 @abstract Initialize node with parent node.
 */
- (instancetype)initWithParentNode:(SCNNode *)node;

@end

NS_ASSUME_NONNULL_END
