//
//  SceneGestureRecognizerDelegate.h
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface SceneGestureRecognizerDelegate : NSObject

- (instancetype)initWithSceneView:(ARSCNView *)sceneView NS_DESIGNATED_INITIALIZER;

- (instancetype)init __attribute__((unavailable("Use initWithSceneView: to create instance of this class.")));

@end

NS_ASSUME_NONNULL_END
