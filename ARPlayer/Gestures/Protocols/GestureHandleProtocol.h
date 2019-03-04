//
//  GestureHandleProtocol.h
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import Foundation;
@import ARKit;

NS_ASSUME_NONNULL_BEGIN

@protocol GestureHandleProtocol <NSObject>

- (void)handleGesture:(UIGestureRecognizer *)gesture inSceneView:(ARSCNView *)sceneView;

@end

NS_ASSUME_NONNULL_END
