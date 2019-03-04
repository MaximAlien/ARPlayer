//
//  PlaneRendererNode.h
//  ARKitExample
//
//  Created by Maxim Makhun on 9/7/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;
@import ARKit;

NS_ASSUME_NONNULL_BEGIN

/*!
 @class PlaneRendererNode
 @abstract Node which is used to render horizontal planes.
 */
@interface PlaneRendererNode : SCNNode

/*!
 @method initWithAnchor
 @abstract It's possible to init PlaneRendererNode only using this method. Every PlaneRendererNode is
 attached to specific ARPlaneAnchor and can be either visible or not (depending on settings).
 */
- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor visible:(BOOL)visible NS_DESIGNATED_INITIALIZER;

- (instancetype)init __attribute__((unavailable("Use initWithAnchor:visible: to create instance of this class.")));

/*!
 @method update:
 @abstract Update location of PlaneRendererNode depending on location of ARPlaneAnchor.
 */
- (void)update:(ARPlaneAnchor *)anchor;

/*!
 @method hide
 @abstract Hide current PlaneRendererNode.
 */
- (void)hide;

/*!
 @method show
 @abstract Show current PlaneRendererNode.
 */
- (void)show;

@end

NS_ASSUME_NONNULL_END
