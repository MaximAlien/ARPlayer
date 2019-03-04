//
//  GestureHandler.h
//  ARPlayer
//
//  Created by Maxim Makhun on 10/1/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import Foundation;
@import ARKit;

@interface GestureHandler : NSObject

+ (void)handlePlayback:(UITapGestureRecognizer *)recognizer
           inSceneView:(ARSCNView *)sceneView;

+ (void)handleInsertion:(UILongPressGestureRecognizer *)recognizer
            inSceneView:(ARSCNView *)sceneView;

+ (void)handleScale:(UIPinchGestureRecognizer *)recognizer
        inSceneView:(ARSCNView *)sceneView;

+ (void)handleRotation:(UIRotationGestureRecognizer *)recognizer
           inSceneView:(ARSCNView *)sceneView;

+ (void)handlePosition:(UIPanGestureRecognizer *)recognizer
           inSceneView:(ARSCNView *)sceneView;

@end
