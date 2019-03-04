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

@interface PlaneRendererNode : SCNNode

- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor visible:(BOOL)visible;

- (void)update:(ARPlaneAnchor *)anchor;

- (void)hide;

- (void)show;

@end

NS_ASSUME_NONNULL_END
