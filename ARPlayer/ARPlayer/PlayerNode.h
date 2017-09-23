//
//  PlayerNode.h
//  ARKitSceneTest
//
//  Created by Maxim Makhun on 9/20/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;

@interface PlayerNode : SCNNode

@property(nonatomic, readonly) BOOL playerPaused;

- (void)pause;

- (void)play;

- (void)stop;

@end
