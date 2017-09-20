//
//  PlayerNode.h
//  ARKitSceneTest
//
//  Created by Maxim Makhun on 9/20/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;

@interface PlayerNode : SCNNode

- (void)pause;

- (void)play;

- (BOOL)isPaused;

@end
